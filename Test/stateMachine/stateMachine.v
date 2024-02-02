module stateMachine(
	output reg y_out,
	input x_in,clk,reset);
reg [1:0] state,next_state;
parameter A = 2'b00, B = 2'b01, C = 2'b10;

always@(posedge clk)
begin
	if (reset==1) state = A;
	else state=next_state;
	

		case (state)
			A:
				if (x_in)
				begin
					next_state = B;
					y_out = 0;
				end
				else
				begin
					next_state = A;
					y_out = 0;
				end
				
			B:
				if (x_in) 
				begin
					next_state = B;
					y_out = 0;
				end
				else 
				begin
					next_state = C;
					y_out = 0;
				end
			C:
				if (x_in) 
				begin
					next_state = B;
					y_out = 1;
				end
				else 
				begin
					next_state = A;
					y_out = 1;
				end
	endcase
end
endmodule
