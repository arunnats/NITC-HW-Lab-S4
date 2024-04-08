module registerQ1(
   input [15:0] write_port_1,
	input clk,
	input choice,
	input reset,
	output reg [15:0] read_port_1
);

reg [15:0] sixteenBitRegister;

always @(posedge clk or negedge reset)
begin

if(reset==0)
   begin
	
	sixteenBitRegister <= 16'b0;
	read_port_1 <= 16'b0;
	end
	
else
	begin
	
		if(choice == 0)
		begin
			sixteenBitRegister <= write_port_1;
			read_port_1 <= 16'bx;
		end
		
		else if(choice == 1)
			read_port_1 <= sixteenBitRegister;
	
	end

end
endmodule

