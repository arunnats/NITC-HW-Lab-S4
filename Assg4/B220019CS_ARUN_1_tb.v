module RISC18_tb;

    reg [63:0] PCin;
    reg clock;
    reg reset;
    wire [15:0] ans;
    wire [63:0] k;
	 
	 RISC18 RISC18_inst(
        .PCin(PCin),
        .clock(clock),
        .reset(reset),
        .ans(ans),
        .k(k)
    );
	 
	
    initial 
	 begin
		  clock = 0;
		  reset = 1;
        #5
        reset = 0;
		  
        PCin = 64'h0000_0000_0000_0000;
		  
		  #10 clock = ~clock;
		  #10 clock = ~clock;
		  #10 clock = ~clock;
		  #10 clock = ~clock;
		  #10 clock = ~clock;
		  #10 clock = ~clock;
		  #10 clock = ~clock;
		  #10 clock = ~clock;
		  
		  reset = 1;
        #5
        reset = 0;
		  
        PCin = 64'h0101_5600_0211_0000;
        
		  #10 clock = ~clock;
		  #10 clock = ~clock;
		  #10 clock = ~clock;
		  #10 clock = ~clock;
		  #10 clock = ~clock;
		  #10 clock = ~clock;
		  #10 clock = ~clock;
		  #10 clock = ~clock;
	
		  reset = 1;
        #5
        reset = 0;
		  
        PCin = 64'h0000_0000_0000_1111;
       
		  #10 clock = ~clock;
		  #10 clock = ~clock;
		  #10 clock = ~clock;
		  #10 clock = ~clock;
		  #10 clock = ~clock;
		  #10 clock = ~clock;
		  #10 clock = ~clock;
		  #10 clock = ~clock;
		 
		  reset = 1;
        #5
        reset = 0;
		  
        PCin = 64'h1111_1111_1111_1111;
        
		  #10 clock = ~clock;
		  #10 clock = ~clock;
		  #10 clock = ~clock;
		  #10 clock = ~clock;
		  #10 clock = ~clock;
		  #10 clock = ~clock;
		  #10 clock = ~clock;
		  #10 clock = ~clock;
		  
		  reset = 1;
        #5
        reset = 0;
		  
        PCin = 64'h1010_1010_1010_1010;
		  
        #10 clock = ~clock;
		  #10 clock = ~clock;
		  #10 clock = ~clock;
		  #10 clock = ~clock;
		  #10 clock = ~clock;
		  #10 clock = ~clock;
		  #10 clock = ~clock;
		  #10 clock = ~clock;
		  
		  reset = 1;
        #5
        reset = 0;
		  
        PCin = 64'h0101_0101_0101_0101;

        #10 clock = ~clock;
		  #10 clock = ~clock;
		  #10 clock = ~clock;
		  #10 clock = ~clock;
		  #10 clock = ~clock;
		  #10 clock = ~clock;
		  #10 clock = ~clock;
		  #10 clock = ~clock;
  
        $stop;
    end
    
    always @(posedge clock) begin
        $display("ans: %d", ans);
        $display("k: %h", k);
    end

endmodule
