module practiseSim_tb;

wire y;
reg x;
reg clk;
reg reset;

practiseSim testbench(.x(x),.y(y),.clk(clk),.reset(reset));

initial begin
	clk = 1'b1;
	repeat(1000) #5 clk=~clk;
	#5000 $finish;
end

initial begin
	
		#5 reset=0;
		#5 reset=1;
		#10 x=0;
		#10 x=1;
		#10 x=0;
		#10 x=1;
		#10 x=0;
		#10 x=1;
		#10 x=1;
		#5 reset=0;
		#10 x=0;
		#10 x=1;
		#10 x=0;
		#10 x=1;
		#10 x=0;
		#10 x=1;
		#5 reset=1;
		#10 x=1;
		#10 x=0;
		#10 x=1;
		#10 x=1;

end

always #10 x = $random;

endmodule