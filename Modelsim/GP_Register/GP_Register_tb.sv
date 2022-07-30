`timescale 1ns/1ps

module GP_Register_tb ();
	
	parameter CLK_HALF_PERIOD = 5;
	
	logic [7:0] in_d, out_q;
	logic in_clk, in_rstn, in_wr_ctrl;
	
	logic [7:0] d_data [0:5];
	logic wr_ctrl_data [0:5];
	logic [7:0] expected_q [0:5];
	
	int error_count;
	
	GP_Register DUT (.clk(in_clk), 
						  .rstn(in_rstn), 
						  .wr_ctrl(in_wr_ctrl), 
						  .d(in_d), 
						  .q(out_q)
						 );
	
	// Generate Clock signal
	initial begin
		in_clk = 1'b0;
		forever #(CLK_HALF_PERIOD) in_clk = ~in_clk;
	end
	
	// Test Async Active Low Reset
	initial begin
		in_rstn = 1'b1;
		#12 in_rstn = 1'b0;
		#15 in_rstn = 1'b1;
		#80 in_rstn = 1'b0;
	end
	
	initial begin
		error_count = 0;
		in_wr_ctrl = 1'b0;
		$readmemb("in_d.txt", d_data);
		$readmemb("in_wr_ctrl.txt", wr_ctrl_data);
		$readmemb("out_q.txt", expected_q);
		#40;
		
		for (int i = 0; i < 6; i++) begin
			in_d = d_data[i];
			in_wr_ctrl = wr_ctrl_data[i];
			#CLK_HALF_PERIOD;
			if (out_q !== expected_q[i]) begin
				error_count += 1;
				$display("At %0g ns", $time);
				$display("Error: input 'd' = %0b and input 'wr_ctrl' = %0b", in_d, in_wr_ctrl);
				$display("Output 'q' = %0b and Expected Output 'q' = %0b", out_q, expected_q[i]);
			end
			#CLK_HALF_PERIOD;
		end
	end
	
	initial begin
		$display("At %0t ns << Starting the Simulation >>", $time);
		#120;
		$display("At %0g ns", $time);
		$display("<< Simulation finishes with %0d output mismatch(es) >>", error_count);
		$finish;
		$stop;
	end
endmodule
		
		
		
	