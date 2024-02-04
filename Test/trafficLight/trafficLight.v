module trafficLight(output reg NS_red, NS_green, EW_red, EW_green,input clk, reset);

    parameter A = 2'b00, B = 2'b01, C = 2'b10, D = 2'b11;

    reg [1:0] state, nextstate;

    reg temp_NS, temp_EW;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= A;
        end else begin
            state <= nextstate;
        end
    end

    always @(*) begin
        case (state)
		  
            A: nextstate = B;
				
            B: nextstate = C;
				
				
            C: nextstate = A;
				
            default: nextstate = A;
				
        endcase
    end

    always @(posedge clk or posedge reset) begin
        
		  if (reset) begin
		  
            NS_green = 1;
            NS_red = 0;
				
            EW_green = 0;
            EW_red = 1;
				
        end 
		  
		  else begin
            if (state == A) begin
				
                temp_NS = NS_green;
                NS_green = NS_red;
                NS_red = temp_NS;

                temp_EW = EW_green;
                EW_green = EW_red;
                EW_red = temp_EW;
					 
            end 
        end
    end

endmodule