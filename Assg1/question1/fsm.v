module fsm (
  input wire clk,
  input wire reset,
  input wire in,
  output reg out
);

  parameter S0 = 2'b00, S1 = 2'b01, S2 = 2'b10;
  reg [1:0] state, next_state;

  always @(posedge clk or posedge reset) begin
    if (reset) state <= S0;
    else state <= next_state;
  end

  always @(state or in) begin
    case (state)
      S0: begin
        out = 0;
        if (in) next_state = S1;
        else next_state = S0;
      end
      S1: begin
        out = 0;
        if (in) next_state = S1;
        else next_state = S2;
      end
      S2: begin
        if (in) begin
          out = 1;
          next_state = S1;
        end else begin
          out = 0;
          next_state = S0;
        end
      end
    endcase
  end

endmodule
