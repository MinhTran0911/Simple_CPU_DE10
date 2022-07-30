module B_bus_selector (B_reg, ext_input, B_sel, B_bus);
	
	input logic [7:0] B_reg; 
	input logic [5:0] ext_input;
	input logic [1:0] B_sel;
	
	output logic [7:0] B_bus;
	
	assign B_bus = (B_sel == 2'b00) ? B_reg :
						(B_sel == 2'b11) ? {2'b00, ext_input} : 8'b0;
						
endmodule 