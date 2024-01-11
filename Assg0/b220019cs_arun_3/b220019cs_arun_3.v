module alu(
    input [7:0] a,
    input [7:0] b,
    input [1:0] operation, 
    output reg [7:0] sum,
    output reg cout,
    output reg [7:0] difference,
    output reg bout,
    output reg [7:0] xor_output,
    output reg [7:0] left_shift_output
);

    always @(a or b or operation) begin
        {difference, bout, sum, cout, xor_output, left_shift_output} = 8'b0;

        if (operation == 2'b00) begin
            difference = a - b;
            bout = 0; 
        end

        if (operation == 2'b01) begin 
            sum = a + b;
            cout = 0;
        end

        if (operation == 2'b10) begin
            xor_output = a ^ b;
        end

        if (operation == 2'b11) begin
            left_shift_output = a << 1;
        end
    end

endmodule
