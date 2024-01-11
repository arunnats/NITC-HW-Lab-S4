module b220019cs_arun_3_tb;

    reg [7:0] a;
    reg [7:0] b;
    reg [1:0] operation; 
    wire [7:0] sum;
    wire cout;
    wire [7:0] difference;
    wire bout;
    wire [7:0] xor_output;
    wire [7:0] left_shift_output;

    alu testbench (
        .a(a),
        .b(b),
        .operation(operation),
        .sum(sum),
        .cout(cout),
        .difference(difference),
        .bout(bout),
        .xor_output(xor_output),
        .left_shift_output(left_shift_output)
    );

    integer i, j, op;

    initial begin
        $monitor("%b %b %b %b %b %b %b %b", a, b, operation, cout, sum, difference, bout, xor_output, left_shift_output);

        for (i = 0; i < 10; i = i + 1) begin
            for (j = 0; j < 10; j = j + 1) begin
                a = $random;
                b = $random;
                operation = $random % 4; 
                #10; 
                $display("a=%b, b=%b, operation=%b, result=%b", a, b, operation, sum);
            end
        end

        $finish;
    end

endmodule
