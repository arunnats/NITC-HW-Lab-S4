module trafficLightThreeState(
	output reg NS_green,
	EW_green,
	NS_yellow,
	EW_yellow,
	NS_red,
	EW_red,
	input clk,
	reset
);

parameter A = 3'b000, B = 3'b001, C = 3'b010, D = 3'b011, E = 3'b100, F = 3'b101;

reg [2:0] state, nextState;


always@(posedge clk or posedge reset)
begin
	if(reset)
	state <= A;
	else
	state <= nextState;
end

always@(*)
begin
	case(state)
		A:begin
			nextState = B;
		end
		
		B:begin
			nextState = C;
		end
		
		C:begin
			nextState = D;
		end
		
		D:begin
			nextState = E;
		end
		
		E:begin
			nextState = F;
		end
		
		F:begin
			nextState = A;
		end
		
		default: nextState = A;
		
	endcase
end

always @(posedge clk) begin
    case(state)
        A: begin
            NS_green = 1;
            NS_yellow = 0;
            NS_red = 0;
            
            EW_green = 0;
            EW_yellow = 0;
            EW_red = 1;
        end
        C: begin
            NS_green = 0;
            NS_yellow = 1;
            NS_red = 0;
            
            EW_green = 0;
            EW_yellow = 1;
            EW_red = 0;
        end
        E: begin
            NS_green = 0;
            NS_yellow = 0;
            NS_red = 1;
            
            EW_green = 1;
            EW_yellow = 0;
            EW_red = 0;
        end

    endcase
end

endmodule