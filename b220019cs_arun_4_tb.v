module d_Latch_tb();
reg [7:0] d;
reg enable;
reg reset;
wire [7:0] q;

d_Latch testbench(.d(d),.enable(enable),.reset(reset),.q(q));
 
initial begin  
 enable=1;
 reset=1;
 d <= 7;
 #20;
 d <= 34;
 #20;
 d <= 83;
 #20;
 reset=0;
 reset=1;
 #20;
 d <= 125;
 #20;
 enable=0;
 #20;
 d <=210;
 #20;
 d <=98;
 enable=1;
 #20;
 d <= 73;
 #20;
 d <= 21;
 #20 $finish;
end
endmodule