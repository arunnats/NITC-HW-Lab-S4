module d_Latch (
   input [7:0]d,
   input enable,
	input reset,
   output reg [7:0] q
);
   always @ (reset or enable or d)
      if (enable)
         q <= d;
		else if (!reset)
         q <= 0; 			
endmodule
