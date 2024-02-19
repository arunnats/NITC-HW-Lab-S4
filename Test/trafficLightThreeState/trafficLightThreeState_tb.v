module trafficLightThreeState_tb;

reg clk, reset;
wire NS_green, EW_green, NS_yellow, EW_yellow, NS_red, EW_red;
	
trafficLightThreeState tb(.NS_green(NS_green), .EW_green(EW_green), .NS_yellow(NS_yellow), .EW_yellow(EW_yellow), .NS_red(NS_red), .EW_red(EW_red), .reset(reset), .clk(clk) );
	
initial begin
	reset = 0;
	#5 reset = 1;
	#5 reset = 0;
	clk=0;
	repeat(2000)#10 clk = ~clk;
end	

	
endmodule