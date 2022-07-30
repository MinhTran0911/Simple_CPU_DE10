module GP_Register (clk, rstn, wr_ctrl, d, q);

	input logic clk, rstn, wr_ctrl;
	input logic [7:0] d;
	
	output logic [7:0] q;
	
	
	// General Purpose Register, Rising Edge DFF, Async Reset
	always_ff @(posedge clk, negedge rstn) begin
		if (!rstn) q <= 0;
		else q <= wr_ctrl ? d : q;
	end
	

endmodule 