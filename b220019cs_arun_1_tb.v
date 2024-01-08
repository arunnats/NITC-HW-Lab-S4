module b220019cs_arun_1_tb;

	reg [7:0] a;
	reg [7:0] b;
	wire [7:0] sum;
   wire cout;

	eight_bit_full_adder testbench (
  	  .a(a),
  	  .b(b),
  	  .sum(sum),
     .cout(cout)
	);
    
	integer i,j;
    
	initial begin
  	  $display("a    b    cin    finalcarry    sum");
  	  $monitor("%b %b %b %b", a, b, cout, sum);
		for (i = 0; i < 256; i = i + 1) begin
			for (j = 0; j < 256; j = j + 1) begin
				a=i;
  				b=j;
  				#10;
			end
   	end

	$finish;
	end

endmodule