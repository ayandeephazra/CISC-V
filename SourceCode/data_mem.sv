module DM(clk,addr,re,we,wrt_data,rd_data);

/////////////////////////////////////////////////////////
// Data memory.  Single ported, can read or write but //
// not both in a single cycle.  Precharge on clock   //
// high, read/write on clock low.                   //
/////////////////////////////////////////////////////
input clk;
input [15:0] addr;
input re;				// asserted when instruction read desired
input we;				// asserted when write desired
input [15:0] wrt_data;	// data to be written

output reg [15:0] rd_data;	//output of data memory

reg [15:0]data_mem[0:8191];

// ///////////////////////////////////////////////
// // Model read, data is flopped on clock low //
// /////////////////////////////////////////////

always_ff @ (negedge clk)
  if (re && ~we)
    rd_data <= data_mem[addr];

	
// ////////////////////////////////////////////////
// // Model write, data is written on clock low //
// //////////////////////////////////////////////

always_ff @( negedge clk )
  if (we && ~re)
    data_mem[addr] <= wrt_data;
  

endmodule
