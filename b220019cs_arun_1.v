module eight_bit_full_adder(
	input [7:0]a, 
	input [7:0]b, 
	output reg [7:0]sum, 
	output reg cout
);
	
	always@( a or b)
		 {cout,sum} = a + b;
		 
endmodule

