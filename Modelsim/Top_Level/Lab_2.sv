// Lab 2 Simple CPU Top-Level
module Lab_2 (clk, rstn, opcode, ext_input, execute_n, seven_segs, A_bus, B_bus, C_bus, out, carry_out, zero_out);
	
	input logic [5:0] ext_input;
	input logic [3:0] opcode;
	input logic clk, rstn, execute_n; 
	
	output logic [6:0] seven_segs [0:4]; // 3 digits for output, 1 digit for carry flag and 1 digit for zero flag
	output logic [7:0] out; // Output from Reg_OUT to 7-seg
	output logic carry_out, zero_out; // Output from CF and ZF registers to 7-seg
	
	// These data buses are declared as output for verification purpose only, they are not real outputs of the system
	output logic [7:0] A_bus, B_bus, C_bus;
	
	// Internal connections
	logic [7:0] reg_B_out; // Output from Register B
	logic write_a, write_b, write_o, write_cz; // Write Control Lines
	logic [3:0] F; // ALU Control Lines
	// Store each decimal digit of the output. 8-bit output -> 0-255 -> 3 digits are needed, each digit is from 0->9 -> 4-bit
	logic [3:0] hundreds, tens, ones; 
	logic [1:0] B_sel; // B bus Select Lines
	logic [1:0] flags; // Carry (flags[1]) and Zero (flags[0]) flags from ALU
	
	
	
	// Instantiate sub-modules and connections
	
	// Control Unit
	Control_Unit CU (.clk(clk),
						  .rstn(rstn),
						  .opcode(opcode), 
						  .F(F), 
						  .B_sel(B_sel), 
						  .execute_n(execute_n), 
						  .write_a(write_a), 
						  .write_b(write_b), 
						  .write_o(write_o), 
						  .write_cz(write_cz)
						 );
	
	
	// B Bus MUX
	B_bus_selector B_MUX (.B_reg(reg_B_out), 
								 .ext_input(ext_input), 
								 .B_sel(B_sel), 
								 .B_bus(B_bus)
								);
	
	// ALU
	Arithmetic_Logic_Unit ALU (.A(A_bus),
										.B(B_bus),
										.F(F),
										.C(C_bus),
										.flags(flags)
									  );
									  
	
	// Register A
	GP_Register Reg_A (.clk(clk), .rstn(rstn), .wr_ctrl(write_a), .d(C_bus), .q(A_bus));
	// Register B
	GP_Register Reg_B (.clk(clk), .rstn(rstn), .wr_ctrl(write_b), .d(C_bus), .q(reg_B_out));
	// Output Register
	GP_Register Reg_OUT (.clk(clk), .rstn(rstn), .wr_ctrl(write_o), .d(C_bus), .q(out));
	// Register CF
	GP_Register Reg_CF (.clk(clk), .rstn(rstn), .wr_ctrl(write_cz), .d(flags[1]), .q(carry_out));
	// Register ZF
	GP_Register Reg_ZF (.clk(clk), .rstn(rstn), .wr_ctrl(write_cz), .d(flags[0]), .q(zero_out));
	
	
	// Convert value from Reg_OUT to Binary Coded Decimal format for seven-seg display
	BCD_Decoder BCD_decoder (.in(out), .hundreds(hundreds), .tens(tens), .ones(ones));
	

	// 7 segments Displays
	Sev_Segs_Display Hundreds_Display (.num(hundreds) , .sev_segs(seven_segs[2]));
	Sev_Segs_Display Tens_Display 	 (.num(tens)	  , .sev_segs(seven_segs[1]));
	Sev_Segs_Display Ones_Display 	 (.num(ones)	  , .sev_segs(seven_segs[0]));
	Sev_Segs_Display Carry_Display 	 (.num(carry_out), .sev_segs(seven_segs[4]));  
	Sev_Segs_Display Zero_Display 	 (.num(zero_out) , .sev_segs(seven_segs[3]));
										
endmodule 