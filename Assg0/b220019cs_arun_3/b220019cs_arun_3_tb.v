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

        a = 34;
		  b = 84;
		  operation = 1;
		  #10;
		  a = 135;
		  b = 24;
		  operation = 0;
		  #10;
		  a = 53;
		  b = 98;
		  operation = 2;
		  #10;
		  a = 0;
		  b = 2;
		  operation = 3;
		  #10;
		  a = 235;
		  b = 123;
		  operation = 2;
		  #10;
		  a = 94;
		  b = 216;
		  operation = 1;
		  #10;
		  a = 57;
		  b = 48;
		  operation = 0;
		  #10;
		  a = 106;
		  b = 220;
		  operation = 1;
		  #10;
		  a = 241;
		  b = 94;
		  operation = 3;
		  #10;
		  a = 104;
		  b = 168;
		  operation = 3;
		  #10;
		  a = 203;
		  b = 78;
		  operation = 2;
		  #10;
		  a = 106;
		  b = 175;
		  operation = 1;
		  #10;
		  a = 193;
		  b = 205;
		  operation = 0;
		  #10;
		  a = 235;
		  b = 76;
		  operation = 2;
		  #10;
		  a = 4;
		  b = 183;
		  operation = 1;
		  #10;
		  
		  for (i = 0; i < 5; i = i + 1) begin
            for (j = 0; j < 5; j = j + 1) begin
                a = $random;
                b = $random;
                operation = $random % 4; 
                #10; 
            end
        end

        $finish;
    end

endmodule
