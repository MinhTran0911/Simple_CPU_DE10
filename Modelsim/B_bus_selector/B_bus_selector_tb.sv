`timescale 1ns/1ps

module B_bus_selector_tb ();
	
	logic [7:0] in_B_reg; 
	logic [5:0] in_ext_input;
	logic [1:0] in_B_sel;
	logic [7:0] out_B_bus;
	
	logic [7:0] B_reg_data [0:3];
	logic	[5:0] ext_input_data [0:3];
	logic [1:0] B_sel_data [0:3];
	logic [7:0] expected_B_bus [0:3];

	// This var to count for error
	int error_count;

	// Module instantiation
	B_bus_selector DUT (.B_reg(in_B_reg), 
							  .ext_input(in_ext_input), 
							  .B_sel(in_B_sel), 
							  .B_bus(out_B_bus)
							 );


	// Generate input stimulus
	initial begin
		error_count = 0;
		$readmemb("in_B_reg.txt", B_reg_data);
		$readmemb("in_ext_input.txt", ext_input_data);
		$readmemb("in_B_sel.txt", B_sel_data);
		$readmemb("out_B_bus.txt", expected_B_bus);
		#10;
		
		for (int i = 0; i < 4; i++) begin
			in_B_reg = B_reg_data[i];
			in_ext_input = ext_input_data[i];
			in_B_sel = B_sel_data[i];
			#10;
			
			if (out_B_bus !== expected_B_bus[i]) begin
				error_count += 1;
				$display("At %0g ns", $time);
				$display("Error: input 'B_reg' = %8b, input 'ext_input' = %8b and input 'B_sel' = %2b", in_B_reg, in_ext_input, in_B_sel);
				$display("Output 'B_bus' = %8b and Expected Output 'B_bus' = %8b", out_B_bus, expected_B_bus[i]);
			end
			#10;
		end
	end
	
	
	initial begin
		$display("At %g ns << Starting the Simulation >>", $time);
		#110;
		$display("At %0g ns", $time);
		$display("<< Simulation finishes with %0d output mismatch(es) >>", error_count);
		$finish;
		$stop;
	end
endmodule
