module alarmSystem_tb;

    reg x;
    reg clk;
    reg reset;
    wire [2:0] selsw;

   alarmSystem ut (.selsw(selsw),.x(x),.clk(clk),.reset(reset));

    initial begin
        clk = 0;
       repeat(500)#10 clk = ~clk; 
		 #5000 $finish;
    end

    initial begin

        x=0;
        reset = 0;
        #25;
		  
        x = 0;
		  #20;
        x = 0;
		  #20;
        x = 0;
		  #20;
        x = 0; 
		  #20;
		  
        x = 0; 
		  #20;
        reset = 0;
		  #20;
        x = 0;
		  #20;
        x = 0;
		  #20;
		   x = 0;
		  #20;
        x = 0;
		  #20;
		   x = 0;
		  #20;
        x = 0;
		  #20;
		   x = 0;
			#20;
		   x = 0;
		  #20;
        x = 0;
		  #20;
		   x = 0;
		  #20;
        x = 0;
		  #20;
		   x = 0;
		  #20;
        x = 0;
		  #20;
		   x = 0;
		  #20;
		  #20;
        x = 0;
		  #20;
		   x = 0;
		  #20;
        x = 0;
		  #20;
        reset = 0;
		   x = 0;
		  #20;
        x = 0;
		  #20;
		   x = 1;
		  #20;
        x = 0;
		  #20;
    end
	 always #20 x = $random;

endmodule
