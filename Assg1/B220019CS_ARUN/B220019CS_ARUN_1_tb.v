module B220019CS_ARUN_1_tb;

	reg clk,
	reset,
	x;
	wire y;

	B220019CS_ARUN_1 testbench(.clk(clk),.reset(reset),.x(x),.y(y));

	initial begin 
		clk=1'b1;
		repeat(2000)#5 clk=~clk;
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
	always #10 x= $random;
	always #30 reset= $random;


endmodule