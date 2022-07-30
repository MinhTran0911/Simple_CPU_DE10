module Arithmetic_Logic_Unit (A, B, F, C, flags);

	input logic [7:0] A, B;
	input logic [3:0] F;
	
	output logic [7:0] C;
	output logic [1:0] flags;
	
	// Operations of the ALU
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
										
	// Define operations of the Arithmetic Logic Unit (ALU)
	always_comb begin
		case (F)
			OUT_A: C = A; // Output A
			OUT_B: C = B; // Output B
			INCREMENT_A: C = A + 8'b1; // Increment Register A
			INCREMENT_B: C = B + 8'b1; // Increment Register B 
			A_PLUS_B: C = A + B; // Add A and B
			A_SUB_B: C = A - B; // Subtract B from A
			A_AND_B: C = A & B; // Bitwise A AND B 
			A_OR_B: C = A | B; // Bitwise A OR B
			SHIFT_R_A: C = A >> 1; // Shift Right A 1 bit 
			SHIFT_L_A: C = A << 1; // Shift Left A 1 bit
			default: C = 8'b0;
		endcase
	end
	
	// Set carry_flag if overflow happens
	// A + B >= A. Therefore, only when the result is overflown and truncated does (A + B) < A
	assign flags[1] = ((F == INCREMENT_A) && (C < A)) ? 1'b1
							((F == INCREMENT_B) && (C < B)) ? 1'b1 :
							((F == A_PLUS_B) && (C < A))	  ? 1'b1 :
							((F == SHIFT_L_A) && (C < A))   ? 1'b1 :
							((F == A_SUB_B) && (B > A))	  ? 1'b1 : 1'b0;
	
	// When output from ALU is 0, set zero flag
	assign flags[0] = (C == 8'b0) ? 1'b1 : 1'b0;
	
endmodule
