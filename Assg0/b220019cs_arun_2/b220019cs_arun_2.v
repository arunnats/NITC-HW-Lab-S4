module eight_bit_subtractor(
	input [7:0]a, 
	input [7:0]b, 
	output reg [7:0]difference, 
	output reg bout
);
	
	always@( a or b)
		 {difference,bout} = a - b;
		 
endmodule

