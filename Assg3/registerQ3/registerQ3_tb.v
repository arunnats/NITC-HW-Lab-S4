module registerQ3_tb();
    reg clk;
    reg read_enable;
    reg write_enable;
    reg [31:0] write_port_1;
    wire [31:0] read_port_1;

    registerQ3 #(.DATA_WIDTH(32)) testbench(
        .write_port_1(write_port_1),
        .clk(clk),
        .read_enable(read_enable),
        .write_enable(write_enable),
        .read_port_1(read_port_1)
    );

    initial begin
        clk = 0;
        read_enable = 0;
        write_enable = 0;
        write_port_1 = 0;

        #10;
        clk = 1;
        #10;
        clk = 0;

        write_enable = 1;
        write_port_1 = 32'hABCDE;
        #10;
        write_enable = 0;

        read_enable = 1;
        #10;
        read_enable = 0;

        write_enable = 1;
        write_port_1 = 32'h12345;
        #5;
        read_enable = 1;
        #5;
        write_enable = 0;
        #5;
        read_enable = 0;

        #10 $finish;
    end
endmodule
