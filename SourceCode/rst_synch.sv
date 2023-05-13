module rst_synch(RST_n, rst_n, clk);
	input clk, RST_n;
	output logic rst_n;
	
	// Flip flops for rst_synch
	reg ff1;
	
	always_ff @ (negedge clk) begin
		// asynch signal reset
		if(!RST_n) begin
			ff1 <= 1'b0;
			rst_n <= 1'b0;
		end
		else begin
			ff1 <= 1'b1;
			rst_n <= ff1;
		end
	end
endmodule