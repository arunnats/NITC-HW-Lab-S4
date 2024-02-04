module alarmSystem(output reg [2:0] selsw, input x, clk, reset);

    reg [2:0] state, next_state;
    reg [3:0] delay_counter;

    parameter s0 = 3'b000, s1 = 3'b001, s2 = 3'b010, s3 = 3'b011,unlock = 3'b100, wrong = 3'b101;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= s0;
            delay_counter <= 4'b0;
        end 
		  else begin
            state <= next_state;
            if (state == unlock) begin
                if (delay_counter < 4'd9) 
                    delay_counter <= delay_counter + 1'b1;
                else 
                    delay_counter <= 4'b0;
            end 
				else begin
                delay_counter <= 4'b0;
            end
        end
    end

    always @(*) begin
        case (state)
            s0: 
                if (x) next_state = wrong; 
                else next_state = s1;

            s1: 
                if (x) next_state = wrong;
                else next_state = s2;

            s2: 
                if (x) next_state = wrong; 
                else next_state = s3;

            s3: 
                if (x) next_state = wrong;
                else next_state = unlock;

            unlock: 
                if (delay_counter < 4'd9) next_state = unlock;
                else next_state = s0;

            wrong: 
                next_state = wrong;

            default: 
                next_state = s0;
        endcase
    end

    always @(*) begin
        case (state)
            wrong, unlock, s0: selsw = 0;
            s1: 
                if (x) selsw = 0;
                else selsw = 3'b001;
            s2: 
                if (x) selsw = 0;
                else selsw = 3'b010;
            s3: 
                if (x) selsw = 0;
                else selsw = 3'b011;
            default: selsw = 0;
        endcase
    end
endmodule
