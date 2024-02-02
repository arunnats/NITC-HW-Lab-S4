//`timescale 1ns / 1ps

module tb_traffic;
    reg clk, rst_n;
    wire NS_green, NS_red, EW_green, EW_red;

    trafficLight u1 (
        .NS_green(NS_green), 
        .NS_red(NS_red), 
        .EW_green(EW_green), 
        .EW_red(EW_red), 
        .clk(clk), 
        .rst_n(rst_n)
    );

    initial begin
        clk = 0;
        rst_n = 0;

        #10 rst_n = 1;

        #1000 rst_n = 0;

        $finish;
    end

    always #5 clk = ~clk;
endmodule
