module fsm (
  input clk,
  input reset,
  input in,
  output reg out
);

  parameter A = 2'b00, B = 2'b01, C = 2'b10;
  reg [1:0] state, next_state;

	always@(posedge clk)
	begin
		if (reset==1) state = A;
		else state=next_state;
		
		
			case (state)
				A:
					if (in)
					begin
						next_state = B;
						out = 0;
					end
					else
					begin
						next_state = A;
						out = 0;
					end
					
				B:
					if (in) 
					begin
						next_state = B;
						out = 1;
					end
					else 
					begin
						next_state = C;
						out = 0;
					end
				C:
					if (in) 
					begin
						next_state = B;
						out = 1;
					end
					else 
					begin
						next_state = A;
						out = 1;
					end
		endcase
	end
endmodule
