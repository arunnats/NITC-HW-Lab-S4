module registerQ2_tb();
reg [15:0] write_port_1;
reg [15:0] write_port_2;
reg clk;
reg choice;
reg reset;
wire [15:0] read_port_1;

registerQ2 testbench(write_port_1,clk,choice,reset,read_port_1);

	initial begin
        clk = 0;
        forever #10 clk = ~clk;  
    end

    initial begin
      reset = 0;
		#20;
		reset = 1;
		write_port_1 = 0;
		write_port_2 = 74;
		choice = 1;
		#20;
		write_port_1 = 65;
		write_port_2 = 2464;
		choice = 1;
		#20;
		write_port_1 = 32;
		write_port_2 = 4;
		choice = 0;
		#20;
		write_port_1 = 241;
		write_port_2 = 924;
		choice = 0;
		#20;
		write_port_1 = 6202;
		write_port_2 = 8264;
		choice = 1;
		#20;
		write_port_1 = 1266;
		write_port_2 = 3451;
		choice = 0;
		#20;
		write_port_1 = 25;
		write_port_2 = 6831;
		choice = 0;
		#20;
		write_port_1 = 69;
		write_port_2 = 3263;
		choice = 1;
		#20;
		reset=0;
		#20;
		write_port_1 = 64;
		write_port_2 = 1034;
		choice = 0;
		#20;
		write_port_1 = 123;
		write_port_2 = 192;
		choice = 0;
		#20;
		reset=1;
		#20;
		write_port_1 = 93;
		write_port_2 = 74;
		choice = 1;
		#20;
		write_port_1 = 256;
		write_port_2 = 774;
		choice = 1;
		#20;
		write_port_1 = 198;
		write_port_2 = 474;
		choice = 0;
		#20 $finish;
	end
endmodule