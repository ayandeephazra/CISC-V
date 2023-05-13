module IM(clk,addr,rd_en,instr);

input clk;
input [15:0] addr; //was 12 in oh
input rd_en;			// asserted when instruction read desired

output reg [47:0] instr;	//output of insturction memory

reg [47:0]instr_mem[0:8191];

// /////////////////////////////////////
// // Memory is latched on clock low //
// ///////////////////////////////////
// always @(addr,rd_en,clk)
//   if (~clk & rd_en)
//     instr <= instr_mem[addr];

always_ff @ (negedge clk)
  if (rd_en)
    instr <= instr_mem[addr];


//////////////////////////////////////
// Testing own instr mem sequences //
////////////////////////////////////
initial begin
  $readmemh("C:/Users/Ayan Deep Hazra/Desktop/Repos/Simple_Multicore_Processor/ExampleASM_and_Assembler/new48bitinstr.hex",instr_mem);
end

endmodule
