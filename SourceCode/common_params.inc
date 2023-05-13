
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

////////////////////////////////
// Encodings for src0 select //
//////////////////////////////
localparam RF2SRC0 	= 2'b00;
localparam IMM_BR2SRC0 = 2'b01;			// 7-bit SE for branch target
localparam IMM_JMP2SRC0 = 2'b10;		// 12-bit SE for jump target
localparam IMM2SRC0 = 2'b11;			// 4-bit SE Address immediate for LW/SW

////////////////////////////////
// Encodings for src1 select //
//////////////////////////////
localparam RF2SRC1	= 2'b00;
localparam IMM2SRC1 = 2'b01;			// 8-bit data immediate for LLB/LHB
localparam NPC2SRC1 = 2'b10;			// nxt_pc to src1 for JAL instruction



