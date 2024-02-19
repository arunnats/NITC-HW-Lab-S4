module practiseSim(
	output reg y,
	input x,
	input clk,
	input reset
);


reg [1:0] state, nextState;
parameter s0=2'b00, s1=2'b01, s2=2'b10;

always@(posedge clk, negedge reset)
begin
	if(reset==0)
		state <= s0;
	else
		state <= nextState;
end

always@(state, x)
begin
	case(state)
		s0:
		begin
			if(x)	
				nextState = s1;
			else
				nextState = s0;
		end
		
		s1:
		begin
			if(x)	
				nextState = s1;
			else
				nextState = s2;
		end
		
		s2:
		begin
			if(x)	
				nextState = s1;
			else
				nextState = s0;
		end
		
	endcase
end

always@(state,x)
begin
	case(state)
	s0,s1:y = 0;

	s2: y = x;
	endcase
end

endmodule

