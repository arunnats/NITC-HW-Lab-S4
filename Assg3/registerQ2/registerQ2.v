module registerQ2
(
   input [15:0] write_port_1,
	input [15:0] write_port_2,
	input clk,
	input choice,
	input reset,
	output reg [15:0] read_port_1
);

reg [15:0] sixteenBitRegister;
reg portChoice;

always @(posedge clk or negedge reset)
begin

	if(reset==1'b0)
		begin
		
		sixteenBitRegister <= 16'b0;
		portChoice <= 1'b0;
		
		end
		
	else
	begin
		
		if(choice == 0)
		begin
			
			if(portChoice == 0)
			begin
				sixteenBitRegister <= write_port_1;
				read_port_1 <= 16'bx;
				portChoice <= 1'b1;
			end
			else if(portChoice == 1)
			begin
				sixteenBitRegister <= write_port_2;
				read_port_1 <= 16'bx;
				portChoice <= 1'b0;
			end
			
		end
		
		else if(choice == 1)
		begin				
				read_port_1 <= sixteenBitRegister;
		end
		
	end

end
endmodule