module registerQ4_tb();
    reg [2:0] read_address_1;
    reg [2:0] read_address_2;
    reg [2:0] write_address;
    reg [7:0] write_data;
    reg read_enable;
    reg write_enable;
    wire [7:0] read_data_1;
    wire [7:0] read_data_2;

    registerQ4 testbench(
        .read_addressess_1(read_addressess_1),
        .read_addressess_2(read_addressess_2),
        .write_addressess(write_addressess),
        .write_data(write_data),
        .read_enable(read_enable),
        .write_enable(write_enable),
        .read_data_1(read_data_1),
        .read_data_2(read_data_2)
    );

    initial begin
        read_address_1 = 3'b000;
        read_address_2 = 3'b001;
        write_address = 3'b010;
        write_data = 8'b10101010;
        read_enable = 1;
        write_enable = 0;

        #10;
        read_enable = 0;
        #10;

        write_enable = 1;
        #10;
        write_enable = 0;
        #10 $finish;
    end
endmodule
