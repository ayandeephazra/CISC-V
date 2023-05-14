
///////////////////////////////////////
// Create defines for ALU functions //
/////////////////////////////////////
localparam ADD	= 5'b00000;
localparam SUB 	= 5'b00001;
localparam AND	= 5'b00010;
localparam NOR	= 5'b00011; 
localparam SLL	= 5'b00100;
localparam SRL	= 5'b00101;
localparam SRA	= 5'b00110;
localparam LHB  = 5'b00111;
//
localparam NAND = 5'b10000;
localparam OR = 5'b10001;
localparam NOT = 5'b10010;
localparam XOR = 5'b10011;
localparam XNOR = 5'b10100;
localparam UMULO = 5'b10101;
localparam UMULC = 5'b10110;
localparam SMUL = 5'b10111;
localparam DIV = 5'b11000;
localparam SDIV = 5'b11001;

//////////////////////////////////////////
// Create defines for Opcode encodings //
////////////////////////////////////////
localparam ADDi 	= 6'b000000;
localparam ADDZi 	= 6'b000001;
localparam SUBi 	= 6'b000010;
localparam ANDi		= 6'b000011;
localparam NORi		= 6'b000100;
localparam SLLi		= 6'b000101;
localparam SRLi		= 6'b000110;
localparam SRAi		= 6'b000111;
localparam LWi		= 6'b001000;
localparam SWi		= 6'b001001;
localparam LHBi		= 6'b001010;
localparam LLBi		= 6'b001011;
localparam BRi		= 6'b001100;
localparam JALi		= 6'b001101;
localparam JRi		= 6'b001110;
localparam HLTi		= 6'b001111;

// NAND 010000 OR 010001 NOT 010010 XOR 010011 XNOR 010100 UMULO 010101 UMULC 010110 SMUL 010111
// ADDI 011000 SUBI 011001 ANDI 011010 NANDI 011011 ORI 011100 NORI 011101 XORI 011110 XNORI 011111

localparam NANDi 	= 6'b010000;
localparam ORi 		= 6'b010001;
localparam NOTi 	= 6'b010010;
//localparam ANDi		= 6'b010011;
localparam XORi		= 6'b010100;
localparam XNORi	= 6'b010101;
localparam UMULOi	= 6'b010110;
localparam UMULCi	= 6'b010111;
localparam SMULi	= 6'b011000;
localparam ADDIi	= 6'b011001;
localparam SUBIi	= 6'b011010;
localparam ANDIi	= 6'b011011;
localparam NANDIi	= 6'b011100;
localparam ORIi		= 6'b011101;
localparam NORIi	= 6'b011110;
localparam XORIi	= 6'b011111;
localparam XNORIi 	= 6'b100000;

//	UMULI 100000 SMULI 100001 ADDII 100010 SUBII 100011 MULII 100100 DIV 100101 SDIV 100110 DIVI 100111

localparam UMULIi 	= 6'b100001;
localparam SMULIi 	= 6'b100010;
localparam ADDIIi	= 6'b100011;
localparam SUBIIi	= 6'b100100;
localparam MULIIi	= 6'b100101;
localparam DIVi		= 6'b100110;
localparam SDIVi	= 6'b100111;
localparam DIVIi	= 6'b101000;
//localparam SWi		= 6'b101001;
//localparam LHBi		= 6'b101010;
//localparam LLBi		= 6'b101011;
//localparam BRi		= 6'b101100;
//localparam JALi		= 6'b101101;
//localparam JRi		= 6'b101110;
//localparam HLTi		= 6'b101111;

////////////////////////////////
// Encodings for src0 select //
//////////////////////////////
localparam RF2SRC0 	= 3'b000;
localparam IMM_BR2SRC0 = 3'b001;			// 7-bit SE for branch target
localparam IMM_JMP2SRC0 = 3'b010;		// 12-bit SE for jump target
localparam IMM2SRC0 = 3'b011;			// 4-bit SE Address immediate for LW/SW
localparam IMM2SRC0_6BZE = 3'b100;      // 6-bit ZE immediate for Immediate ALU instrs
localparam IMM2SRC0_6BSE = 3'b101;      // 6-bit SE immediate for Immediate ALU instrs

////////////////////////////////
// Encodings for src1 select //
//////////////////////////////
localparam RF2SRC1	= 2'b00;
localparam IMM2SRC1 = 2'b01;			// 8-bit data immediate for LLB/LHB
localparam NPC2SRC1 = 2'b10;			// nxt_pc to src1 for JAL instruction
localparam IMM2SRC1_6BZE = 2'b11;      // 6-bit ZE immediate for Immediate ALU instrs


