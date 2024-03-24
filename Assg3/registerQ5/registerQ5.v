module registerQ5(
    input [4:0] read_addr_1,
    input [4:0] read_addr_2,
    input [4:0] read_addr_3,
    input [4:0] read_addr_4,
    input [4:0] write_addr_1,
    input [4:0] write_addr_2,
    input [63:0] write_data_1,
    input [63:0] write_data_2,
    input read_enable_1,
    input read_enable_2,
    input read_enable_3,
    input read_enable_4,
    input write_enable_1,
    input write_enable_2,
    output reg [63:0] read_data_1,
    output reg [63:0] read_data_2,
    output reg [63:0] read_data_3,
    output reg [63:0] read_data_4
);

    reg [63:0] registers [31:0];

    always @(*) begin
        if (read_enable_1) read_data_1 = registers[read_addr_1];
        else read_data_1 = 64'bzzzzzzzzzzzzzzzz;

        if (read_enable_2) read_data_2 = registers[read_addr_2];
        else read_data_2 = 64'bzzzzzzzzzzzzzzzz;

        if (read_enable_3) read_data_3 = registers[read_addr_3];
        else read_data_3 = 64'bzzzzzzzzzzzzzzzz;

        if (read_enable_4) read_data_4 = registers[read_addr_4];
        else read_data_4 = 64'bzzzzzzzzzzzzzzzz;
    end

    always @(posedge write_enable_1) begin
        registers[write_addr_1] <= write_data_1;
    end

    always @(posedge write_enable_2) begin
        registers[write_addr_2] <= write_data_2;
    end

endmodule
