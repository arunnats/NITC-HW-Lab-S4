`timescale 1ns / 1ps
module instruction_memory(
input [31:0] addr,
output [31:0] rd_data
);
reg [7:0]ram_memory[1023:0];  //BYTE ADDRESSABLE INSTRUCTION MEMORY
initial
begin
    $readmemh("memfile.dat",ram_memory);
end
assign rd_data = {ram_memory[addr],ram_memory[addr+1],ram_memory[addr+2],ram_memory[addr+3]};
endmodule