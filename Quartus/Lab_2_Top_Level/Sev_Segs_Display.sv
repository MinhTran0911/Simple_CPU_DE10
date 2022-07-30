module Sev_Segs_Display(num, sev_segs);
	
	input logic [3:0] num; // number to display on a seven segments digit
	output logic [6:0] sev_segs;
	
	// Seven segments patterns
	localparam ZERO = 7'b1000000;
	localparam ONE = 7'b1111001;
	localparam TWO = 7'b0100100;
	localparam THREE = 7'b0110000;
	localparam FOUR = 7'b0011001;
	localparam FIVE = 7'b0010010;
	localparam SIX = 7'b0000010;
	localparam SEVEN = 7'b1111000;
	localparam EIGHT = 7'b0000000;
	localparam NINE = 7'b0010000;
	localparam DASH = 7'b0111111;
	
	// Assign each digit to its correponding seven-seg pattern
	always_comb begin
		case (num)
			4'd0: sev_segs = ZERO;
			4'd1:	sev_segs = ONE;
			4'd2: sev_segs = TWO;
			4'd3:	sev_segs = THREE;
			4'd4: sev_segs = FOUR;
			4'd5:	sev_segs = FIVE;
			4'd6: sev_segs = SIX;
			4'd7:	sev_segs = SEVEN;
			4'd8: sev_segs = EIGHT;
			4'd9: sev_segs = NINE;
			default: sev_segs = DASH; // A dash indicates an error
		endcase
	end
			
endmodule 