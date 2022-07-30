`timescale 1ns/1ps

module Lab_2_tb ();

	parameter CLK_HALF_PERIOD = 10;
	
	logic in_clk, in_rstn, in_execute_n;
	logic [5:0] in_ext_input;
	logic [3:0] in_opcode;
	logic [6:0] out_seven_segs [0:4];	
	logic [7:0] out_A_bus, out_B_bus, out_C_bus, out_out;
	logic out_carry_out, out_zero_out;
	
	logic execute_n_data [0:125];
	logic [5:0] ext_input_data [0:125];
	logic [3:0] opcode_data [0:125];
	logic [6:0] expected_seven_segs [0:4] [0:125];
	logic [7:0] expected_out [0:125];
	logic expected_carry_out [0:125];
	logic expected_zero_out [0:125];
	
	int error_count;
	
	Lab_2 DUT (.clk(in_clk), 
				  .rstn(in_rstn), 
				  .opcode(in_opcode), 
				  .ext_input(in_ext_input), 
				  .execute_n(in_execute_n), 
				  .seven_segs(out_seven_segs),
				  .A_bus(out_A_bus),
				  .B_bus(out_B_bus),
				  .C_bus(out_C_bus),
				  .out(out_out),
				  .carry_out(out_carry_out),
				  .zero_out(out_zero_out)
				 );
			
	// Generate Clock signal
	initial begin
		in_clk = 1'b0;
		forever #(CLK_HALF_PERIOD) in_clk = ~in_clk;
	end
	
	// Test Async Active Low Reset
	initial begin
		in_rstn = 1'b1;
		#15 in_rstn = 1'b0;
		#10 in_rstn = 1'b1;
	end
	
	// Generate input stimulus
	initial begin
		in_execute_n = 1'b1;
		
		$readmemb("in_execute_n.txt", execute_n_data);
		$readmemb("in_ext_input.txt", ext_input_data);
		$readmemb("in_opcode.txt", opcode_data);
		$readmemb("out_seven_segs_2.txt", expected_seven_segs[2]);
		$readmemb("out_seven_segs_1.txt", expected_seven_segs[1]);
		$readmemb("out_seven_segs_0.txt", expected_seven_segs[0]);
		$readmemb("out_seven_segs_4.txt", expected_seven_segs[4]);
		$readmemb("out_seven_segs_3.txt", expected_seven_segs[3]);
		$readmemb("out_out.txt", expected_out);
		$readmemb("out_carry_out.txt", expected_carry_out);
		$readmemb("out_zero_out.txt", expected_zero_out);
		#35;
		
		for (int i = 0; i < 126; i++) begin
			in_execute_n = execute_n_data[i];
			in_ext_input = ext_input_data[i];
			in_opcode = opcode_data[i];
			#(3*CLK_HALF_PERIOD);
			for (int j = 0; j < 5; j++) begin
				if (out_seven_segs[j] !== expected_seven_segs[j][i]) begin
					error_count += 1;
					$display("At %0g ns", $time);
					$display("Error: input 'ext_input' = %6b and input 'opcode' = %4b", in_ext_input, in_opcode);
					$display("Error: input 'execute_n' = %0b", in_execute_n);
					$display("Output 'seven_segs[%0d]' = %7b and Expected Output 'seven_segs[%0d]' = %7b", j, out_seven_segs[j], j, expected_seven_segs[j][i]);
				end
			end
			
			if (out_out !== expected_out[i]) begin
					error_count += 1;
					$display("At %0g ns", $time);
					$display("Error: input 'ext_input' = %6b and input 'opcode' = %4b", in_ext_input, in_opcode);
					$display("Error: input 'execute_n' = %0b", in_execute_n);
					$display("Output 'out' = %8b and Expected Output 'out' = %8b", out_out, expected_out[i]);
				end
				
			if (out_carry_out !== expected_carry_out[i]) begin
					error_count += 1;
					$display("At %0g ns", $time);
					$display("Error: input 'ext_input' = %6b and input 'opcode' = %4b", in_ext_input, in_opcode);
					$display("Error: input 'execute_n' = %0b", in_execute_n);
					$display("Output 'carry_outout' = %8b and Expected Output 'carry_outout' = %8b", out_carry_out, expected_carry_out[i]);
			end
				
			if (out_zero_out !== expected_zero_out[i]) begin
					error_count += 1;
					$display("At %0g ns", $time);
					$display("Error: input 'ext_input' = %6b and input 'opcode' = %4b", in_ext_input, in_opcode);
					$display("Error: input 'execute_n' = %0b", in_execute_n);
					$display("Output 'zero_out' = %8b and Expected Output 'zero_out' = %8b", out_zero_out, expected_zero_out[i]);
			end
			#CLK_HALF_PERIOD;
		end
	end
	
	initial begin
		$display("At %0g ns << Starting the Simulation >>", $time);
		#5200;
		$display("At %0g ns", $time);
		$display("<< Simulation finishes with %0d output mismatch(es) >>", error_count);
		$finish;
		$stop;
	end

endmodule 