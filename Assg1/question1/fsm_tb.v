module fsm_tb;
reg in, 
reset, 
clk;
wire out;

fsm testbench(out, in, clk, reset);

initial 

begin
in = 0;
reset = 1;
clk = 0;	
end

always #25 {in, reset} = $random;
always #25 clk = ~clk;
endmodule
