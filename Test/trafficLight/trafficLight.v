module trafficLight(NS_green, 
	NS_red, 
	EW_green, 
	EW_red, 
	clk, 
	rst_n
);

  parameter NS_GREEN = 1'b1, EW_GREEN = 1'b1;
  
  input clk, rst_n;
  output reg NS_green, NS_red, EW_green, EW_red;
  
  reg state, next_state;

  always @(posedge clk or negedge rst_n) begin
  
    if (~rst_n)
      state <= NS_GREEN;
    else
      state <= next_state;
		
  end
  
  always @(clk) begin
  
    case (state)
      NS_GREEN: begin
        NS_green = 1; NS_red = 0; EW_green = 0; EW_red = 1;
        next_state <= EW_GREEN;
      end
      EW_GREEN: begin
        NS_green = 0; NS_red = 1; EW_green = 1; EW_red = 0;
        next_state <= NS_GREEN;
      end
    endcase
	 
  end

endmodule
