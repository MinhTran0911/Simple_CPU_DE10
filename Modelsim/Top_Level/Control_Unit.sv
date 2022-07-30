module Control_Unit (clk, rstn, opcode, F, B_sel, execute_n, write_a, write_b, write_o, write_cz);
	
	input logic [3:0] opcode;
	input logic clk, rstn, execute_n;
	
	output logic [1:0] B_sel;
	output logic [3:0] F;
	output logic write_a, write_b, write_o, write_cz;
	
	logic [3:0] instruction;
	logic current_state, next_state, prev_btn_state;
	
	// States of the Control Unit
	typedef enum logic {IDLE, EXECUTE} State;
	
	// Instruction Set of the Control Unit
	typedef enum logic [3:0] { NOP 		= 4'b0000,
										INPUT 	= 4'b0001,
										OUTPUT 	= 4'b0010,
										INC_A 	= 4'b0011,
										INC_B 	= 4'b0100,
										MOV_B_A 	= 4'b0101,
										ADD_A_B 	= 4'b0110,
										SUB_A_B 	= 4'b0111,
										AND_A_B 	= 4'b1000,
										OR_A_B	= 4'b1001,
										SHL 		= 4'b1010,
										SHR 		= 4'b1011 } Instruction_Set;
	// Available operations of the ALU
	typedef enum logic [3:0] { OUT_A 		= 4'b0000,
										OUT_B 		= 4'b0001,
										INCREMENT_A = 4'b0010,
										INCREMENT_B = 4'b0011,
										A_PLUS_B 	= 4'b0100,
										A_SUB_B 		= 4'b0101,
										A_AND_B 		= 4'b0110,
										A_OR_B 		= 4'b0111,
										SHIFT_R_A 	= 4'b1000,
										SHIFT_L_A 	= 4'b1001 } ALU_Op;
	// B bus MUX
	typedef enum logic [1:0] { NON			= 2'bxx,
										B_REG 		= 2'b00,
										EXT_INPUT 	= 2'b11 } B_Bus_Selector;
	
	
	// Control Unit state machine.
	// The Control Unit changes state at the falling edge of the clock to prepare for writing to registers at the next rising edge
	always_ff @(negedge clk, negedge rstn) begin
		if (!rstn) current_state <= IDLE;
		else begin
			current_state <= next_state;
			// Update the previous state of the execute button
			if (execute_n) prev_btn_state <= 1;
			else if (prev_btn_state) prev_btn_state <= 0;
		end
	end
	
	// Combinational Block to determine the next state
	always_comb begin
		case (current_state)
			IDLE: begin
						// When execute button is pressed, only update the state once, until the button is released and pressed again
						if ((!execute_n) && prev_btn_state) next_state = EXECUTE;
						else next_state = IDLE;
					end
			// Always cycle back to the IDLE state to clear the registers' write control lines
			EXECUTE: next_state = IDLE;
			default: next_state = IDLE;
		endcase
	end
	
	// Combinational block to determine the output of each state
	always_comb begin
		case (current_state)
			// In IDLE state, CPU does nothing
			IDLE: instruction = NOP;
			// In EXECUTE state, CPU runs instruction according to the input opcode
			EXECUTE: instruction = opcode;
			default: instruction = NOP;
		endcase
	end
	
	// Combinational block to set the registers's control lines (write_), B bus MUX (B_sel), and ALU control lines (F)
	always_comb begin
		case (instruction)
			// Do nothing
			NOP:		begin
							B_sel = NON;
							F = OUT_A;
							write_a = 1'b0;
							write_b = 1'b0;
							write_o = 1'b0;
							write_cz = 1'b0;
						end
			// Load External Input into Reg A
			INPUT:	begin
							B_sel = EXT_INPUT;
							F = OUT_B;
							write_a = 1'b1;
							write_b = 1'b0;
							write_o = 1'b0;
							write_cz = 1'b1;
						end
			// Move Reg A to Reg OUT	
			OUTPUT:	begin
							B_sel = NON;
							F = OUT_A;
							write_a = 1'b0;
							write_b = 1'b0;
							write_o = 1'b1;
							write_cz = 1'b1;
						end
			// Increment Reg A by 1
			INC_A:	begin
							B_sel = NON;
							F <= INCREMENT_A;
							write_a = 1'b1;
							write_b = 1'b0;
							write_o = 1'b0;
							write_cz = 1'b1;
						end
			// Increment Reg B by 1
			INC_B:	begin
							B_sel = B_REG;
							F = INCREMENT_B;
							write_a = 1'b0;
							write_b = 1'b1;
							write_o = 1'b0;
							write_cz = 1'b1;
						end
			// Move value from Reg A to Reg B
			MOV_B_A:	begin
							B_sel = NON;
							F = OUT_A;
							write_a = 1'b0;
							write_b = 1'b1;
							write_o = 1'b0;
							write_cz = 1'b1;
						end
			// A <= A + B
			ADD_A_B:	begin
							B_sel = B_REG;
							F = A_PLUS_B;
							write_a = 1'b1;
							write_b = 1'b0;
							write_o = 1'b0;
							write_cz = 1'b1;
						end
			// A <= A - B
			SUB_A_B:	begin
							B_sel = B_REG;
							F = A_SUB_B;
							write_a = 1'b1;
							write_b = 1'b0;
							write_o = 1'b0;
							write_cz = 1'b1;
						end
			// A <= A & B
			AND_A_B:	begin
							B_sel = B_REG;
							F = A_AND_B;
							write_a = 1'b1;
							write_b = 1'b0;
							write_o = 1'b0;
							write_cz = 1'b1;
						end
			// A <= A | B
			OR_A_B:	begin
							B_sel = B_REG;
							F = A_OR_B;
							write_a = 1'b1;
							write_b = 1'b0;
							write_o = 1'b0;
							write_cz = 1'b1;
						end
			// A <= A << 1
			SHL:		begin
							B_sel = NON;
							F = SHIFT_L_A;
							write_a = 1'b1;
							write_b = 1'b0;
							write_o = 1'b0;
							write_cz = 1'b1;
						end
			// A <= A >> 1
			SHR:		begin
							B_sel = NON;
							F = SHIFT_R_A;
							write_a = 1'b1;
							write_b = 1'b0;
							write_o = 1'b0;
							write_cz = 1'b1;
						end
			default: begin
							B_sel = NON;
							F = OUT_A;
							write_a = 1'b0;
							write_b <= 1'b0;
							write_o <= 1'b0;
							write_cz <= 1'b0;
						end
		endcase
	end

endmodule	