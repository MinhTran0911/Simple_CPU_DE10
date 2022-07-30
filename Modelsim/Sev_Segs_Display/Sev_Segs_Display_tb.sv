`timescale 1ns/1ps

module Sev_Segs_Display_tb ();
	
	logic [3:0] in_num;
	logic [6:0] out_sev_segs;
	
	logic [3:0] in_num_data [0:9];
	logic [6:0] sev_segs_expected [0:9];
	
	int error_count;
	
	Sev_Segs_Display DUT (.num(in_num), .sev_segs(out_sev_segs));
	
	initial begin
		error_count = 0;
		$readmemb("in_num.txt", in_num_data);
		$readmemb("expected_out_sev_segs.txt", sev_segs_expected);
		#10;
		for (int i = 0; i < 10; i++) begin
			in_num = in_num_data[i];
			#5;
			if (out_sev_segs !== sev_segs_expected[i]) begin
				error_count += 1;
				$display("At %0g ns", $time);
				$display("Error: input num = %0b", in_num);
				$display("Output = %0b and Expected Output = %0b", out_sev_segs, sev_segs_expected[i]);
			end
			#15;
		end
	end
	
	initial begin
		$display("At %0g ns << Starting the Simulation >>", $time);
		#250;
		$display("At %0g ns", $time);
		$display("<< Simulation finishes with %0d output mismatch(es) >>", error_count);
		$finish;
		$stop;
	end
	
endmodule 