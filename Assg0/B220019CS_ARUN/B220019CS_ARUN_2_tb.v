module b220019cs_arun_2_tb;

	reg [7:0] a;
	reg [7:0] b;
	wire [7:0] difference;
   wire bout;

	eight_bit_full_subtractor testbench (
  	  .a(a),
  	  .b(b),
  	  .difference(difference),
     .bout(bout)
	);
    
	integer i,j;
    
	initial begin
  	  $display("a    b    cin    finalborrow    difference");
  	  $monitor("%b %b %b %b", a, b, bout, difference);
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