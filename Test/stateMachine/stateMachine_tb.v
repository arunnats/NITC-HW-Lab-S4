module stateMachine_tb;
    reg x_in, reset, clk;
    wire y_out;

    stateMachine testbench(y_out, x_in, clk, reset);

    initial begin
        x_in = 0;
        reset = 1;
        #10
        reset = 0;
        clk = 0;	
    end

    always #25 {x_in} <= $random;
    always #25 clk <= ~clk;
endmodule