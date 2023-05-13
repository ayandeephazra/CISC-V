// Dual port rf memory block.
// instantiated twice in rf.sv to create 3 port register file
module rf_mem(
    input clk,
    input [5:0] r_addr,
    input [5:0] w_addr,
    input [15:0] wdata,
    input we,
    

    output logic [15:0] rdata
);

    reg [15:0] mem [0:63];

    always_ff @ (negedge clk) begin
        if (we && |w_addr)
            mem[w_addr] <= wdata;
        rdata <= mem[r_addr];
    end

endmodule
    
