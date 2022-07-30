`timescale 1ns/1ps

module Arithmetic_Logic_Unit_tb ();

	parameter TEST_CASES = 26;
	
	logic [7:0] in_A, in_B;
	logic [3:0] in_F;
	
	logic [7:0] out_C;
	logic [1:0] out_flags;
	
	// Arrays to store data
	logic [7:0] A_data [0:25];
	logic [7:0] B_data [0:25];
	logic [3:0] F_data [0:25];
	logic [7:0] expected_C [0:25];
	logic [1:0] expected_flags [0:25];
	
	// This var to count for error
	int error_count;

	// Module instantiation
	Arithmetic_Logic_Unit DUT (
			 .A(in_A), 
		 	 .B(in_B), 
			 .F(in_F),
		 	 .C(out_C), 
		 	 .flags(out_flags)
			);
			
	// Generate input stimulus
	initial begin
		error_count = 0;
		$readmemb("in_A.txt", A_data);
		$readmemb("in_B.txt", B_data);
		$readmemb("in_F.txt", F_data);
		$readmemb("out_C.txt", expected_C);
		$readmemb("out_flags.txt", expected_flags);
		#10;
		
		for (int i = 0; i < TEST_CASES; i++) begin
			in_A = A_data[i];
			in_B = B_data[i];
			in_F = F_data[i];
			#5;
			
			// Copy this if block for each output
			if (out_C !== expected_C[i]) begin
				error_count += 1;
				$display("At %0g ns", $time);
				$display("Error: input 'A' = %8b, input 'B' = %8b and input 'F' = %4b", in_A, in_B, in_F);
				$display("Output 'C' = %8b and Expected Output 'C' = %8b", out_C, expected_C[i]);
			end
			
			if (out_flags !== expected_flags[i]) begin
				error_count += 1;
				$display("At %0g ns", $time);
				$display("Error: input 'A' = %8b, input 'B' = %8b and input 'F' = %4b", in_A, in_B, in_F);
				$display("Output 'flags' = %2b and Expected Output 'flags' = %2b", out_flags, expected_flags[i]);
			end
			#5;
		end
	end	
	
	initial begin
		$display("At %0g ns << Starting the Simulation >>", $time);
		#300;
		$display("At %0g ns", $time);
		$display("<< Simulation finishes with %0d output mismatch(es) >>", error_count);
		$finish;
		$stop;
	end
endmodule
