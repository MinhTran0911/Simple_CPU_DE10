module BCD_Decoder (in, hundreds, tens, ones);
	
	input logic [7:0] in;
	
	output logic [3:0] hundreds, tens, ones; 
	
	// 8-bit Output -> 0-255 -> 3 digits needed
	// Separate each output digit for seven-seg display
	assign hundreds = in / 100;
	assign tens = (in - hundreds * 100) / 10;
	assign ones = in % 10;
	
endmodule 