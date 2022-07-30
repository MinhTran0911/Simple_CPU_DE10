`timescale 1ns/1ps

module BCD_Decoder_tb ();
	
	logic [7:0] in_in;
	logic [7:0] in_data [0:255];
	
	logic [3:0] out_hundreds, out_tens, out_ones;
	logic [3:0] hundreds_expected [0:255], 
					tens_expected [0:255], 
					ones_expected [0:255];
	
	int error_count;
	
	BCD_Decoder DUT (.in(in_in), 
						  .hundreds(out_hundreds), 
						  .tens(out_tens), 
						  .ones(out_ones)
						 );
	
	initial begin
		error_count = 0;
		$readmemb("in_in.txt", in_data);
		$readmemb("out_hundreds.txt", hundreds_expected);
		$readmemb("out_tens.txt", tens_expected);
		$readmemb("out_ones.txt", ones_expected);
		#10;
		for (int i = 0; i < 256; i++) begin
			in_in = in_data[i];
			#5;
			if (out_hundreds !== hundreds_expected[i]) begin
				error_count += 1;
				$display("At %0g ns", $time);
				$display("Error: input 'in' = %0b", in_in);
				$display("Output 'hundreds' = %0b and Expected Output 'hundreds' = %0b", out_hundreds, hundreds_expected[i]);
			end
			if (out_tens !== tens_expected[i]) begin
				error_count += 1;
				$display("At %0g ns", $time);
				$display("Error: input 'in' = %0b", in_in);
				$display("Output 'tens' = %0b and Expected Output 'tens' = %0b", out_tens, tens_expected[i]);
			end
			if (out_ones !== ones_expected[i]) begin
				error_count += 1;
				$display("At %0g ns", $time);
				$display("Error: input 'in' = %0b", in_in);
				$display("Output 'ones' = %0b and Expected Output 'ones' = %0b", out_ones, ones_expected[i]);
			end
			#15;
		end
	end
		
	initial begin
		$display("At %0g ns << Starting the Simulation >>", $time);
		#5150;
		$display("At %0g ns", $time);
		$display("<< Simulation finishes with %0d output mismatch(es) >>", error_count);
		$finish;
		$stop;
	end 
	
endmodule 