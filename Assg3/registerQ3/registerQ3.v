module registerQ3 #(parameter DATA_WIDTH = 8)
(
    input [(DATA_WIDTH-1):0] write_port_1,
    input clk,
    input read_enable,
    input write_enable,
    output reg [(DATA_WIDTH-1):0] read_port_1
);

    reg [(DATA_WIDTH-1):0] reg_data;

    always @(posedge clk) begin
        if (write_enable) begin
            reg_data <= write_port_1;
        end
    end

    always @(*) begin
        if (read_enable && !write_enable) begin
            read_port_1 = reg_data;
        end
    end

endmodule
