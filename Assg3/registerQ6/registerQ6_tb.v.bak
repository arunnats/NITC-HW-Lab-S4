module registerQ6_tb;
  parameter WIDTH = 64;
  parameter DEPTH = 32;
  
  reg [WIDTH-1:0] writeLine1;
  reg [WIDTH-1:0] writeLine2;
  reg [WIDTH-1:0] writeLine3;
  reg [WIDTH-1:0] writeLine4;
  reg readEnable;
  reg writeEnable;
  reg reset;
  reg clock;
  reg writePort1Enable;
  reg writePort2Enable;
  reg writePort3Enable;
  reg writePort4Enable;
  reg [6:0] writePortSelect;
  reg readPort1Select;
  reg readPort2Select;
  reg readPort3Select;
  reg readPort4Select;
  wire [WIDTH-1:0] readLine1;
  wire [WIDTH-1:0] readLine2;
  wire [WIDTH-1:0] readLine3;
  wire [WIDTH-1:0] readLine4;
  
  registerQ6 #(WIDTH, DEPTH) tb (
    .writeLine1(writeLine1),
    .writeLine2(writeLine2),
    .writeLine3(writeLine3),
    .writeLine4(writeLine4),
    .readEnable(readEnable),
    .writeEnable(writeEnable),
    .reset(reset),
    .clock(clock),
    .writePort1Enable(writePort1Enable),
    .writePort2Enable(writePort2Enable),
    .writePort3Enable(writePort3Enable),
    .writePort4Enable(writePort4Enable),
    .writePortSelect(writePortSelect),
    .readPort1Select(readPort1Select),
    .readPort2Select(readPort2Select),
    .readPort3Select(readPort3Select),
    .readPort4Select(readPort4Select),
    .readLine1(readLine1),
    .readLine2(readLine2),
    .readLine3(readLine3),
    .readLine4(readLine4)
  );
  
  initial begin
		reset = 0;
		clock = 0;
		#10
		reset = 1;
  end
  
  always #5 clock = ~clock;
  
  initial begin
    writeLine1 = 64'hA5A5A5A5A5A5A5A5;
    writeLine2 = 64'h123456789ABCDEF0;
    writeLine3 = 64'hAAAAAAAAAAAAAAAA;
    writeLine4 = 64'h123456789ABCDEF0;
    readEnable = 0;
    writeEnable = 1;
    reset = 1;
    writePort1Enable = 1;
    writePort2Enable = 0;
    writePort3Enable = 0;
    writePort4Enable = 0;
    writePortSelect = 0;
    readPort1Select = 0;
    readPort2Select = 1;
    readPort3Select = 2;
    readPort4Select = 3;

    // Write operations
    #10 writePort1Enable = 0;
    #10 writePort2Enable = 1;
    #10 writePortSelect = 5;
    #10 writeLine2 = 64'hFEDCCA9376543123;
	 
	 #10 writePort2Enable = 0;
    #10 writePort3Enable = 1;
    #10 writePortSelect = 7;
    #10 writeLine3 = 64'hDE3CCA93A654F1E3;

    // Read operations
    #20 writeEnable = 0;
    #10 readPort1Select = 3;
    #10 readPort2Select = 4;
    #10 readPort3Select = 5;
    #10 readPort4Select = 7;
	 
	 #10 readEnable = 1;
    #10 readPort1Select = 6;
    #10 readPort2Select = 5;
    #10 readPort3Select = 4;
    #10 readPort4Select = 7;
	 
	 #10 writeEnable = 1;
	#10 writePort1Enable = 1;
	#10 writePortSelect = 10;
	#10 writeLine1 = 64'h123456789ABCDEF0;
	
	#10 writePort1Enable = 0;
	#10 writePort2Enable = 1;
	#10 writePortSelect = 11;
	#10 writeLine2 = 64'hFEDCBA9876543210;
	
	#10 writePort2Enable = 0;
	#10 writePort3Enable = 1;
	#10 writePortSelect = 12;
	#10 writeLine3 = 64'hABCDEF1234567890;
	
	#10 writePort3Enable = 0;
	#10 writePort4Enable = 1;
	#10 writePortSelect = 13;
	#10 writeLine4 = 64'hF0E9D8C7B6A59483;
	
	// Read operations
	#10 writeEnable = 0;
	#10 readEnable = 1;
	#10 readPort1Select = 8;
	#10 readPort2Select = 9;
	#10 readPort3Select = 13;
	#10 readPort4Select = 12;
	
	#10 readPort1Select = 28;
	#10 readPort2Select = 11;
	#10 readPort3Select = 30;
	#10 readPort4Select = 10;


    #50 $finish;
  end
  
endmodule
