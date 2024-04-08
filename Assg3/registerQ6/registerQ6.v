module registerQ6 #(parameter WIDTH = 8, DEPTH = 4)
(	
	input [WIDTH-1:0] writeLine1,
	input [WIDTH-1:0] writeLine2,
	input [WIDTH-1:0] writeLine3,
	input [WIDTH-1:0] writeLine4,
	
	input readEnable,
	input writeEnable,
	
	input reset,
	input clock,
	
	input writePort1Enable,
	input writePort2Enable,
	input writePort3Enable,
	input writePort4Enable,
	
	input [6:0] writePortSelect,
	
	input readPort1Select,
	input readPort2Select,
	input readPort3Select,
	input readPort4Select,
	
	output reg [WIDTH-1:0] readLine1,
	output reg [WIDTH-1:0] readLine2,
	output reg [WIDTH-1:0] readLine3,
	output reg [WIDTH-1:0] readLine4
);

reg [WIDTH-1:0] register [0:DEPTH-1];
integer i;

initial
begin
	for(i = 0; i < DEPTH; i=i+1)
	begin
		register[i] = 0;
	end
	
	readLine1 <= 64'b0;
	readLine2 <= 64'b0;
	readLine3 <= 64'b0;
	readLine4 <= 64'b0;
end

always@(posedge clock)
begin
	
	if(reset == 0)
	begin
		for(i = 0; i < DEPTH; i=i+1)
		begin
			register[i] = 0;
		end
		
		readLine1 <= 64'b0;
		readLine2 <= 64'b0;
		readLine3 <= 64'b0;
		readLine4 <= 64'b0;
	end
	
	else if(reset == 1 && writeEnable == 1 )
	begin
		
		if(writePort1Enable == 1)
		begin
			register[writePortSelect] <= writeLine1;
		end
		
		else if(writePort2Enable == 1)
		begin
			register[writePortSelect] <= writeLine2;
		end
		
		else if(writePort3Enable == 1)
		begin
			register[writePortSelect] <= writeLine3;
		end
		
		else if(writePort4Enable == 1)
		begin
			register[writePortSelect] <= writeLine4;
		end
		
	end
	
	else if(reset == 1 && readEnable == 1 && writeEnable != 1)
	begin
	
		readLine1 <= register[readPort1Select];
		readLine2 <= register[readPort2Select];
		readLine3 <= register[readPort3Select];
		readLine4 <= register[readPort4Select];
	end
	
end


endmodule