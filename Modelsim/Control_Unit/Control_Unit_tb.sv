`timescale 1ns/1ps

module Control_Unit_tb ();
	// Define half period of clock
	parameter CLK_HALF_PERIOD = 10;
	
	logic [3:0] in_opcode;
	logic in_clk, in_rstn, in_execute_n;
	
	logic [3:0] out_F;
	logic [1:0] out_B_sel;
	logic out_write_a, out_write_b, out_write_o, out_write_cz;
	
	logic [3:0] opcode_data    	[0:35],
					expected_F        [0:35];
	logic [1:0] expected_B_sel    [0:35];
	logic       execute_n_data 	[0:35],
					expected_write_a  [0:35],
					expected_write_b  [0:35],
					expected_write_o  [0:35],
					expected_write_cz [0:35];
	
	// This var to count for error
	int error_count;

	// Module instantiation
	Control_Unit DUT (.clk(in_clk), 
							.rstn(in_rstn), 
							.execute_n(in_execute_n), 
							.opcode(in_opcode), 
							.F(out_F),
							.B_sel(out_B_sel),
							.write_a(out_write_a),
							.write_b(out_write_b),
							.write_o(out_write_o),
							.write_cz(out_write_cz)
						  );

	// Generate Clock signal
	initial begin
		in_clk = 1'b0;
		forever #(CLK_HALF_PERIOD) in_clk = ~in_clk;
	end

	// Test Reset
	initial begin
		in_rstn = 1'b1;
		#15 in_rstn = 1'b0;
		#10 in_rstn = 1'b1;
	end

	// Generate input stimulus
	initial begin
		error_count = 0;
		$readmemb("in_execute_n.txt", execute_n_data);
		$readmemb("in_opcode.txt", opcode_data);
		$readmemb("out_F.txt", expected_F);
		$readmemb("out_B_sel.txt", expected_B_sel);
		$readmemb("out_write_a.txt", expected_write_a);
		$readmemb("out_write_b.txt", expected_write_b);
		$readmemb("out_write_o.txt", expected_write_o);
		$readmemb("out_write_cz.txt", expected_write_cz);
		#35;
		
		for (int i = 0; i < 36; i++) begin
			in_opcode = opcode_data[i];
			in_execute_n = execute_n_data[i];
			#(2*CLK_HALF_PERIOD);
			
			// Automatic output check
			if (out_F !== expected_F[i]) begin
				error_count += 1;
				$display("At %0g ns", $time);
				$display("Error: input 'opcode' = %4b and input 'execute_n' = %0b", in_opcode, in_execute_n);
				$display("Output 'F' = %0b and Expected Output 'F' = %0b", out_F, expected_F[i]);
			end
			if (out_B_sel !== expected_B_sel[i]) begin
				error_count += 1;
				$display("At %0g ns", $time);
				$display("Error: input 'opcode' = %4b and input 'execute_n' = %0b", in_opcode, in_execute_n);
				$display("Output 'B_sel' = %0b and Expected Output 'B_sel' = %0b", out_B_sel, expected_B_sel[i]);
			end
			if (out_write_a !== expected_write_a[i]) begin
				error_count += 1;
				$display("At %0g ns", $time);
				$display("Error: input 'opcode' = %4b and input 'execute_n' = %0b", in_opcode, in_execute_n);
				$display("Output 'write_a' = %0b and Expected Output 'write_a' = %0b", out_write_a, expected_write_a[i]);
			end
			if (out_write_b !== expected_write_b[i]) begin
				error_count += 1;
				$display("At %0g ns", $time);
				$display("Error: input 'opcode' = %4b and input 'execute_n' = %0b", in_opcode, in_execute_n);
				$display("Output 'write_b' = %0b and Expected Output 'write_b' = %0b", out_write_b, expected_write_b[i]);
			end
			if (out_write_o !== expected_write_o[i]) begin
				error_count += 1;
				$display("At %0g ns", $time);
				$display("Error: input 'opcode' = %4b and input 'execute_n' = %0b", in_opcode, in_execute_n);
				$display("Output 'write_o' = %0b and Expected Output 'write_o' = %0b", out_write_o, expected_write_o[i]);
			end
			if (out_write_cz !== expected_write_cz[i]) begin
				error_count += 1;
				$display("At %0g ns", $time);
				$display("Error: input 'opcode' = %4b and input 'execute_n' = %0b", in_opcode, in_execute_n);
				$display("Output 'write_cz' = %0b and Expected Output 'write_cz' = %0b", out_write_cz, expected_write_cz[i]);
			end
			#(2*CLK_HALF_PERIOD);
		end
	end
	

	initial begin
		$display("At %0g ns << Starting the Simulation >>", $time);
		#1500;
		$display("At %0g ns", $time);
		$display("<< Simulation finishes with %0d output mismatch(es) >>", error_count);
		$finish;
		$stop;
	end
endmodule
	