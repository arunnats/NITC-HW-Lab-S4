module B220019CS_ARUN_2_tb;

    reg clk, reset;
    wire NS_red, NS_green, EW_red, EW_green;

    B220019CS_ARUN_2 testbench(.clk(clk),.reset(reset),.NS_red(NS_red),.NS_green(NS_green),.EW_red(EW_red),.EW_green(EW_green));

    initial begin 
        clk = 1'b0;
        repeat(1000)#5 clk = ~clk; 
    end

    initial begin
        #10 reset = 1'b1;
        #10 reset = 1'b0; 
		  #600 reset = 1'b1;
        #50 reset = 1'b0; 
		  #600 reset = 1'b1;
        #50 reset = 1'b0; 
    end

endmodule
