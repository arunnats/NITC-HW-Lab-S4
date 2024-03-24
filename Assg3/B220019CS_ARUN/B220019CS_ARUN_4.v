module registerQ4(
    input [2:0] read_address_1,
    input [2:0] read_address_2,
    input [2:0] write_address,
    input [7:0] write_data,
    input read_enable,
    input write_enable,
    output reg [7:0] read_data_1,
    output reg [7:0] read_data_2
);

    reg [7:0] registers [7:0];

    always @(*) begin
        if (read_enable) begin
            read_data_1 = registers[read_address_1];
            read_data_2 = registers[read_address_2];
        end else begin
            read_data_1 = 8'bzzzzzzzz;
            read_data_2 = 8'bzzzzzzzz;
        end
    end

    always @(posedge write_enable) begin
        registers[write_address] <= write_data;
    end

endmodule
