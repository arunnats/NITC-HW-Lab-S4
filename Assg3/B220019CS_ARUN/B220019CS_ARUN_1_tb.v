module registerQ1_tb();
reg [15:0] write_port_1;
reg clk;
reg choice;
reg reset;
wire [15:0] read_port_1;

registerQ1 testbench(write_port_1,clk,choice,reset,read_port_1);

	initial begin
        clk = 0;
        forever #10 clk = ~clk;  
    end

    initial begin
      reset = 0;
		#20;
		reset = 1;
		write_port_1 = 0;
		choice = 1;
		#20;
		write_port_1 = 65;
		choice = 1;
		#20;
		write_port_1 = 32;
		choice = 0;
		#20;
		write_port_1 = 241;
		choice = 0;
		#20;
		write_port_1 = 73;
		choice = 1;
		#20;
		write_port_1 = 16;
		choice = 0;
		#20;
		write_port_1 = 25;
		choice = 0;
		#20;
		write_port_1 = 69;
		choice = 1;
		#20;
		reset=0;
		#20;
		write_port_1 = 64;
		choice = 0;
		#20;
		write_port_1 = 123;
		choice = 0;
		#20;
		reset=1;
		#20;
		write_port_1 = 93;
		choice = 1;
		#20;
		write_port_1 = 256;
		choice = 1;
		#20;
		write_port_1 = 198;
		choice = 0;
		#20 $finish;
	end
endmodule