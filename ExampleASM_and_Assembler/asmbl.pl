#!/usr/bin/perl -w



#USAGE:

#

# asmbl.pl <infile> [ > <outfile> ]



#NOTES:

# -All labels MUST start with L

# -Shift amounts must be in decimal

# -Immediate may be in hex or decimal.  If in hex, precede with "0x"

# -Comments may be specified with either "#" or "//".  

# -No multiline comments

#

# MEM <ADDR> and DATA <VALUE> may be used to specify memory

#





#################################################################





use strict;



if(@ARGV < 1) { print "Usage: asmbl.pl <input assembly file> > outputFile\n"; exit; }





my %regs = ("R0" => "000000", "R1" => "000001", "R2" => "000010", "R3" => "000011",

	    "R4" => "000100", "R5" => "000101", "R6" => "000110", "R7" => "000111",

	    "R8" => "001000", "R9" => "001001", "R10"=> "001010", "R11"=> "001011",

	    "R12"=> "001100", "R13"=> "001101", "R14"=> "001110", "R15"=> "001111",
		
		"R16" => "010000", "R17" => "010001", "R18" => "010010", "R19" => "010011",

	    "R20" => "010100", "R21" => "010101", "R22" => "010110", "R23" => "010111",

	    "R24" => "011000", "R25" => "011001", "R26"=> "011010", "R27"=> "011011",

	    "R28"=> "011100", "R29"=> "011101", "R30"=> "011110", "R31"=> "011111",
		
		"R32" => "100000", "R33" => "100001", "R34" => "100010", "R35" => "100011",

	    "R36" => "100100", "R37" => "100101", "R38" => "100110", "R39" => "100111",

	    "R40" => "101000", "R41" => "101001", "R42"=> "101010", "R43"=> "101011",

	    "R44"=> "101100", "R45"=> "101101", "R46"=> "101110", "R47"=> "101111",
		
		"R48" => "110000", "R49" => "110001", "R50" => "110010", "R51" => "110011",

	    "R52" => "110100", "R53" => "110101", "R54" => "110110", "R55" => "110111",

	    "R56" => "111000", "R57" => "111001", "R58"=> "111010", "R59"=> "111011",

	    "R60"=> "111100", "R61"=> "111101", "R62"=> "111110", "R63"=> "111111");



my %conds = ("NEQ" => "0000", "EQ" => "0001", "GT" => "0010", "LT" => "0011", "GTE" => "0100", "LTE" => "0101", "OVFL" => "0110", "UNCOND" => "0111");



my %numArgs = ( qw/ADD 3 ADDZ 3 SUB 3 AND 3 NOR 3 NAND 3 OR 3 NOT 2 XOR 3 XNOR 3 UMULO 3
		SLL 3 UMULC 3 SMUL 3 SRL 3 SRA 3 LW 3 SW 3 LHB 2 LLB 2 B 2 JAL 1 JR 1 HLT 0
		ADDI 3 SUBI 3 ANDI 3 NANDI 3 ORI 3 NORI 3 XORI 3 XNORI 3 UMULI 3 SMULI 3
		ADDII 3 SUBII 3 MULII 3 DIV 3 SDIV 3 DIVI 3/);

my %opcode = ( qw/ADD 000000 ADDZ 000001 SUB 000010 AND 000011 NOR 000100 SLL 000101 SRL 000110 
	SRA 000111 LW 001000 SW 001001 LHB 001010 LLB 001011 B 001100 JAL 001101 JR 001110 HLT 001111
	NAND 010000 OR 010001 NOT 010010 XOR 010011 XNOR 010100 UMULO 010101 UMULC 010110 SMUL 010111
	ADDI 011000 SUBI 011001 ANDI 011010 NANDI 011011 ORI 011100 NORI 011101 XORI 011110 XNORI 011111
	UMULI 100000 SMULI 100001 ADDII 100010 SUBII 100011 MULII 100100 DIV 100101 SDIV 100110 DIVI 100111/);



my %rlookup = ( 
				"1111", "F" , "1110", "E" , "1101", "D" , "1100", "C",

                "1011", "B" , "1010", "A" , "1001", "9" , "1000", "8",

                "0111", "7" , "0110", "6" , "0101", "5" , "0100", "4",

                "0011", "3" , "0010", "2" , "0001", "1" , "0000", "0");
				


open(IN, "$ARGV[0]") or die("Can't open $ARGV[0]: $!");



my %labels = ( );

my @mem;

my @code;

my @source_lines;

my $addr = 0;



while(<IN>) {

    my $bits = "";



    s/\#(.*)$//;  #remove  (#) comments

    s#//(.*)$##;  #remove (//) comments

    next if( /^\s*$/ );  #skip blank lines



    if(/MEM\s+(\S*)/) {

	$addr = hex($1);

	next;

    }

    if(/DATA\s+(.*)/) {

	my $data = $1;

	$data =~ s/\s*(\S+)\s*/$1/;

	while(length($data) < 4) { $data = "0" . $data }

	$mem[$addr++] = hexToBin($data, 40);

	next;

    }

    $source_lines[$addr] = $_;

    $source_lines[$addr] =~ s/^\s+|\s+$//g;

    $_ = uc($_);



  if(s/(.*)://) {  #capture labels

    my $label = $1;

    $label =~ s/\s*(\S+)\s*/$1/;   #strip white space

    $labels{$label} = $addr;

  }



  if( /^\s*(\S+)\s*(.*)/ ) {

      my $instr = $1;

      my @args = split(",", $2);

      

      if(!exists($numArgs{$instr})) { die("Unknown instruction\n$_") }

      if($numArgs{$instr} != @args) { 

	  die("Error:\n$_\nWrong number of arguments (need $numArgs{$instr} args)\n") 

	  }

      
	  $bits = "000000";
      $bits .= "$opcode{$instr}";
	  $bits .= "000000000000000000";


      #strip whitespace from arguments

      for(my $c=0; $c<@args; $c++) { 

	  $args[$c] =~ s/^\s*(\S+)\s*$/$1/ ;

      }

       if($instr =~ /^(NOT)$/) {

	  foreach my $reg ($args[0], $args[1]) {

	      if(!$regs{$reg}) { die("Bad register ($reg)\n$_") }

	      $bits .= $regs{$reg};

	  }
	   $bits .= "000000";

      }

      if($instr =~ /^(AND|NOR|ADD|ADDZ|SUB|NAND|OR|XOR|XNOR|UMULO|UMULC|SMUL|DIV|SDIV)$/) {

	  foreach my $reg ($args[0], $args[1], $args[2]) {

	      if(!$regs{$reg}) { die("Bad register ($reg)\n$_") }

	      $bits .= $regs{$reg};

	  }

      }

      elsif($instr =~ /^(SRA|SLL|SRL|LW|SW|ADDI|SUBI|ANDI|NANDI|ORI|NORI|XORI|XNORI|UMULI|SMULI|DIVI)$/) {

	  foreach my $reg ($args[0], $args[1]) {

	      if(!$regs{$reg}) { die("Bad register ($reg)\n$_") }

	      $bits .= $regs{$reg};

	  }

	  $bits .= parseImmediate($args[2], 6);

      }
	  
	  elsif($instr =~ /^(ADDII|SUBII|MULII)$/) {

	  foreach my $reg ($args[0]) {

	      if(!$regs{$reg}) { die("Bad register ($reg)\n$_") }

	      $bits .= $regs{$reg};

	  }

	  $bits .= parseImmediate($args[1], 6);
      $bits .= parseImmediate($args[2], 6);
      }

      elsif($instr =~ /^(LHB|LLB)$/) {

	  foreach my $reg ($args[0]) {

	      if(!$regs{$reg}) { die("Bad register ($reg)\n$_") }

	      $bits .= $regs{$reg};

	  }

	  $bits .= parseImmediate($args[1], 12);

      }
	  
	  # 16 bit immediate for branch isntructions

      elsif($instr =~ /^(B)$/) {
	  
	  $bits = "";
	  $bits .= "000000";
      $bits .= "$opcode{$instr}";

	  if(!$conds{$args[0]}) { die("Invalid condition code ($args[0])\n$_\nUse only from {NEQ, EQ, GT, LT, GTE, LTE, OVFL, UNCOND}") }

	  else { $bits .= $conds{$args[0]}; }

	  $bits .= "0000000000000000";

	  if($args[1] !~ /[a-zA-Z]/) { print STDERR "Error: Invalid label name: \"$args[1]\" in line:\n$_"; exit; }

	  $bits .= "|" . $args[1] . "|16|B|";
	  

      }

      elsif($instr =~ /^(JAL)$/) {

	  if($args[0] !~ /[a-zA-Z]/) { print STDERR "Error: Invalid label name: \"$args[0]\" in line:\n$_"; exit; }

	  $bits .= "|" . $args[0] . "|12|J|";

      }

      elsif($instr =~ /^(JR)$/) {
    foreach my $reg ($args[0]) {

        if(!$regs{$reg}) { die("Bad register ($reg)\n$_") }

        $bits .= "0000" . $regs{$reg} . "0000";

    }

      }

      elsif($instr =~ /^(HLT)$/) {
    $bits .= "000000000000";

      }

      #print $bits;

      $mem[$addr] = $bits;

      $code[$addr] = $_;

      $addr += 1;

  }    

}

close(IN);



# print "DEPTH = 64;\n";

# print "WIDTH = 16;\n";

# print "ADDRESS_RADIX = HEX;\n";

# print "DATA_RADIX = HEX;\n";

# print "CONTENT\n";

# print "BEGIN\n";

#print "@"."0\n";



for(my $i=0; $i<scalar(@mem); $i++) {

  $addr = $mem[$i];

  next if(!$addr);
 
  if($addr =~ /\|(.+)\|(\d+)\|(\w)\|/) { 

    if(!$labels{$1}) { die("Error:\nLabel referenced, but doesnt exist ($1)\n") }

    my $disp = $labels{$1} - $i - 1;
#    my $disp = ($3 eq "J") ? $labels{$1} : ($labels{$1} - ($i*2 + 2)) / 2;

    $disp = decToBin($disp, $2);

    $addr =~ s/\|(.+)\|(\d+)\|(\w)\|/$disp/;

  }

  #my $j = $i / 2;  #shift from a byte address to a word address

  # print decToHex($i) . "  :  " . binToHex($addr) . "  ;\n";
	
  print "\@" . decToHex($i, 4) . " " . binToHex($addr) . "\t// " . $source_lines[$i] . "\n";

  #if($code[$i]) { print $code[$i] }

  #else { print "\n" }

}







sub parseImmediate {

    my $imm = $_[0];

    my $hex = ($imm =~ /^0x/i) ? 1 : 0;

    $imm =~ s/^0x//i if($hex);

    return $hex ? hexToBin($imm, $_[1]) : decToBin($imm, $_[1]);

}



sub hexToBin {

  return decToBin(hex($_[0]), $_[1]);

}



sub decToBin {

    my $ret = sprintf("%b", $_[0]);

    while(length($ret) < $_[1]) { $ret = "0" . $ret }

    if(length($ret) > $_[1]) { $ret = substr($ret, length($ret)-$_[1]) }

    return $ret;

}







sub decToHex {

  my $ret = sprintf("%x", $_[0]);

  while(length($ret) < 4) { $ret = "0" . $ret }

  return $ret;

}



sub binToHex {

  $_[0] =~ /(\d{6})(\d{6})(\d{6})(\d{6})(\d{6})(\d{6})(\d{6})(\d{6})/;
  
  # 0000000 opcode[5] R6 R5 R4 R3 R2 R1"00000000000000" 
  my $bitval =  $1 . $2 . $3 . $4. $5 . $6 . $7 . $8;
  my $finhex = "";
  my $start;
  my $end;
  my $substr;
  for(my $c=0; $c<length($bitval); $c = $c + 4) { 
	$start = $c;
	$end = $c + 4;
	$substr = "";
	$substr = substr($bitval, $c, $end - $start);
	#print $substr."\n";
	$finhex = $finhex . $rlookup{$substr};
  }
  
  return $finhex;
  #return $1 . $2 . $3 . $4;
  #return $rlookup{$1} . $rlookup{$2} . $rlookup{$3} . $rlookup{$4}; 

}



