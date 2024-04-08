//top module
//memwrite is the memory signal

module test1(	input clk,reset,
					output [31:0] writedata, dataadr,
					output memwrite
);
	wire [31:0] pc, instr, readdata;
	//overall mips processor
	//inputs are clk, reset, pc, instr
	//outputs are memwrite, dataadr, writedata, readdata
	sc sc(clk, reset, instr, readdata, pc, memwrite, dataadr, writedata);
	
	//instruction memory
	//input is pc
	//output is instruction
	imem imem(pc, instr);
	
	//data memory
	//input is clk, memwrite, dataadr, writedata
	//output is readdata
	dmem dmem(clk, memwrite, dataadr, writedata, readdata);
endmodule

//data memory
//input is clk, memwrite, dataadr, writedata
//output is readdata
module dmem( 	input clk, memwrite,
					input [31:0] dataadr,
					input [31:0] writedata,
					output reg [31:0] readdata
);
	//1024 bytes
	reg [7:0] data_mem[1023:0];
	//read the data in from data_file.dat
	initial $readmemh("data_file.dat", data_mem);
	//set readdata to the corresponding value in the data memory array
	always@(*) begin
		readdata = {data_mem[dataadr],  data_mem[dataadr+1], data_mem[dataadr+2], data_mem[dataadr+3]};	
	end
	//little-endian, clock synchronized write
	always @(posedge clk) begin
		if(memwrite) begin
			data_mem[dataadr+3] <=write_data[7:0];
			data_mem[dataadr+2] <=write_data[15:8];
			data_mem[dataadr+1] <=write_data[23:16];
			data_mem[dataadr] <=write_data[31:24];			
		end
	end
endmodule

//instruction memory
//input is pc, output is instruction
module imem( input [31:0] pc, output [31:0] instr);
	reg [7:0] instr_mem[1023:0]; //byte addressable instruction memory
	//read the instructions from ins_file.dat into the instruction memory
	initial $readmemh("ins_file.dat", instr_mem);

//aren't we assuming little endian memory	
	assign instr = {ins_memory[pc], ins_memory[pc+1], ins_memory[pc+2], ins_memory[pc+3]};

endmodule


//single cycle mips module, the processor
//inputs are clk, reset, instruction, and readdata
//outputs are pc, memwrite, aluout/data address which is calculated by the alu and writedata
module sc( 	input clk, reset,
				input [31:0] instr,
				input [31:0] readdata,
				output [31:0] pc,
				output memwrite,
				output [31:0] dataadr, writedata);
	//12 control signals and zero, alucontrol
	//branch, memtoreg, pcsrc, alusrc,regwrite, jump, regdst are normal
	//spra, spregwrite, jal, jumpreg, readhilo
	wire branch, memtoreg, pcsrc,zero, spra, alusrc, regwrite, spregwrite, jump, jal, jumpreg, readhilo;
	wire [1:0] regdst;
	wire [3:0] alucontrol;
	
	//controller module
	//inputs: opcode, funct, shamt, zero from the datapath
	//outputs:
	//memwrite, pcsrc, alusrc, regwrite, spregwrite, regdst, memtoreg, jump, jal, jumpreg, alucontrol, spra, readhilo
	controller controller(instr[31:26], instr[5:0], instr[10:6], zero, memwrite, pcsrc, alusrc, regwrite, spregwrite, regdst, memtoreg, jump, jal, jumpreg, alucontrol,spra, readhilo);
	
	//datapath module
	//inputs: clk, reset, memtoreg, pcsrc, alusrc, regdst, regwrite, spregwrite, jump, jal, jumpreg, shamt, alucontrol,instruction, readdata spra, readhilo
	//outputs:
	//zero,pc, aluout, writedata, 
	datapath datapath(clk, reset, memtoreg, pcsrc,alusrc, regdst, regwrite, spregwrite, jump, jal, jumpreg, instr[10:6], alucontrol, zero, pc, instr, aluout, writedata, readdata, spra, readhilo);
	
endmodule

//controller module
//inputs: opcode, funct, shamt, zero
//outputs: memwrite, pcsrc, alusrc, regwrite, spregwrite, regdst, memtoreg, jump, jal, jumpreg, alucontrol, spra, readhilo
module controller(	input [5:0] op, funct,
							input [4:0] shamt,
							input zero,
							output memwrite,
							output pcsrc, alusrc,
							output regwrite, spregwrite,
							output [1:0] regdst,
							output memtoreg,
							output jump, jal,jumpreg,
							output [3:0] alucontrol,
							output spra, readhilo
);
	//aluop and branch are internal signals
	wire [3:0] aluop;
	wire branch;
	
	//maindecoder:
	//inputs: opcode, funct
	//outputs: memwrite,branch, alusrc, regwrite, spregwrite, regdst, memtoreg,jump, jal, aluop, spra, readhilo
	maindec main_decoder(op, funct, memwrite, branch, alusrc, regwrite, spregwrite, regdst, memtoreg, jump, jal, aluop, spra, readhilo);
	
	//aludecoder:
	//inputs: funct, shamt, aluop,
	//outputs: alucontrol, jumpreg
	aludec alu_decoder(funct, shamt, aluop, alucontrol, jumpreg);
	
	//pcsrc is just branch & zero to determine whether pc is pc + 4 or branch
	assing pcsrc = branch & zero;
endmodule

//main decoder:
//inputs:opcode, funct
//outputs: mw, b, as, rw, sprw, rd, mtr, j, jal, ao, spra, rhl
module maindec( 	input [5:0] op, funct,
						output memwrite,
						output branch, alusrc,
						output regwrite, spregwrite,
						output [1:0] regdst,
						output memtoreg,
						output jump, jal,
						output [3:0] aluop,
						output reg spra,
						output readhilo
);
reg [14:0] controls;
assign {regwrite, regdst, alusrc,branch, memwrite, memtoreg, jump, jal, aluop, spregwrite, readhilo} = controls;

//set all the control signals here
always @(*)
	case(op)
		//opcode is zero, check funct
		6'b000000:
			begin
				case(funct)
					6'b011000: controls <=15'b101000000001010; //mult
					6'b011010: controls <= 15'b101000000001010;//div
					default:
						begin
							case(funct)
								6'b010000:
									begin
										spra<=1'b1;
										controls<=15'b101000000001001;//move from high
									end
								6'b010010:
									begin
										spra<=1'b0;
										controls <=15'b101000000001001;//move from low
									end
								default: controls <=15'b101000000001000;//other r-type
							endcase
						end
				endcase
			end
		6'b100011: controls <=15'b100100100000000;//LW
		6'b101011: controls <=15'b000101000000000;//SW
		6'b000100: controls <=15'b000010000000100;//BEQ
		6'b001000: controls <=15'b100100000000000;//ADDI
		6'b000010: controls <=15'b000000010000000;//J
		6'b000011: controls <=15'b111000011000000; //JAL
		6'b001100: controls <=15'b100100000010000;//ANDI
		6'b001101: controls <=15'b100100000010100;//ORI
		6'b001010: controls <=15'b100100000011100;//SLTI
		6'b001111: controls <=15'b100100000100000;//LUI
		default:	  controls <=15'bx;//???
	endcase

endmodule

//module aludecoder
//inputs: funct, shamt, aluop
//outputs: alucontrol, jumpreg
module aludec(	input [5:0] funct,
					input [4:0] shamt,
					input [3:0] aluop,
					output reg [3:0] alucontrol,
					output jumpreg
);
	always @(*)
		case(aluop)
			4'b0000: alucontrol <= 4'b0010; //addition
			4'b0001: alucontrol <=4'b0110;//subtraction
			4'b0100: alucontrol <=4'b0000;//and
			4'b0001: alucontrol <=4'b0001; //or
			4'b0111: alucontrol <=4'b0111; //slt
			default: case(funct) //RTYPE
				6'b100000: alucontrol <=4'b0010; //ADD
				6'b100010: alucontrol <=4'b0110;//SUB
				6'b100100: alucontrol <=4'b0000; //AND
				6'b100101: alucontrol <=4'b0001;//OR
				6'b100101: alucontrol <=4'b0001; //SLT
				6'b101010: alucontrol <=4'b0111; //SLT
				default: alucontrol <=4'bx;//???
			endcase
		endcase
	assign jumpreg = (funct == 6'b001000)?1:0;
endmodule

//Module datapath
//inputs: clk,reset, memtoreg, pcsrc, alusrc, regdst, regwrite, spregwrite, jump,jal, jumpreg, shamt, alucontrol, instr, readdata, spra, readhilo
//outputs: zero, pc, aluout, writedata, 
module datapath(	input clk, reset,
						input memtoreg,
						input pcsrc,
						input alusrc,
						input [1:0] regdst,
						input regwrite, spregwrite, jump, jal, jumpreg,
						input [4:0] shamt,
						input [3:0] alucontrol,
						input [31:0] instr,
						input [31:0] readdata,
						input spra, readhilo,
						output zero,
						output [31:0] pc,
						output [31:0] aluout, writedata
);

	wire [4:0] writereg;
	wire [31:0] pcnextjr, pcnext, pcnextbr, pcplus4, pcbranch;
	wire [31:0] signimm, signimmsh;
	wire [31:0] srca, srcb, wd0, wd1, sprd;
	wire [31:0] result, resultjal, resulthilo;
	
	//FINDING THE NEXT PC
	flopr #(32) pcreg(clk, reset, pcnext,pc); //pc = pcnext
	adder pcadd1(pc, 32'b100, pcplus4);//pc+4
	sl2 immsh(signimm,signimmsh);
	
	adder pcadd2(pcplus4, signimmsh, pcbranch);
	mux2 #(32) pcbrmux(plus4, pcbranch, pcsrc, pcnextbr);//choose between pcplus 4 and pcbranch
	mux2 #(32) pcmux(pcnextbr, {pcplus4[31:28], instr[25:0], 2'b00}, jump, pcnext);//choose between pcnextbr and pcjump
	mux2 #(32) pcmuxjr(pcnext, srca, jumpreg, pcnextjr);//choose between pcnext and srca in case there is a jumpreg instruction
	
	//REGFILE
	//inputs: clk, regwrite, rs, rt, writereg, resulthilo
	//outputs: srca, writedata
	regfile reg_file(clk, regwrite, instr[25:21], instr[20:16], writereg, resulthilo, srca, writedata);//setup the register file and take srca and writedata as outputs, from read ports 1 and 2
	
	
	mux3 #(5) wrmux(instr[20:16], instr[15:11], 5'b11111, regdst, writereg);//choose between rt, rd and register 31 (ra) to find destination of write operation
	mux2 #(32) resmux(aluout, readdata, memtoreg, result);//choose between aluoutput and readdata to find result
	mux2 #(32) wrmuxjal ( result, pcplus4, jal, resultjal);//choose between the result and pcplus4 to find resultjal
	mux2 #(32) wrmuxhilo(resultjal, sprd, readhilo,resulthilo);//choose between resultjal and sprd to find resulthilo
	signext se(instr[15:0], signimm);//signextend the immediate value
	mux2 #(32) srcbmux(writedata, signimm, alusrc, srcb); //choose between writedata and signimm to find the second alu source
	
	//ALU
	//inputs: srca, srcb, shamt, alucontrol
	//outputs: aluout, wd0, wd1, zero
	alu alu(srca, srcb, shamt, alucontrol, aluout, wd0, wd1, zero);
	
	//SPECIAL REGISTER FILE
	//inputs: clk, spregwrite, spra, wd0,wd1
	//outputs: sprd, which is the data inside the requested special purpose register
	spregfile sprf(clk, spregwrite, spra, wd0, wd1, sprd);
endmodule
	
	
//module regfile:
//inputs: clk, write enable, readport1, readport2, writeport, writedata
//outputs: read data1, read data 2
module regfile(	input clk,
						input we3,
						input [4:0] ra1, ra2, wa3,
						input [31:0] wd3,
						output [31:0] rd1, rd2
);
	//32 registers of size 32 bits each
	reg [31:0] rf[31:0];
	//if write enable, then rf[write address] = write data
	always@(posedge clk)begin
		if(we3) rf[wa3] <=wd3;
	end
	//0 register is hardwired to 0
	assign rd1 = (ra1!=0) ? rf[ra1]:0;
	assign rd2 = (ra2!=0) ? rf[ra2]:0;
endmodule

);

//module spregfile
//inputs: clk, write enable, read poit, write data0, writedata1
//output: readdata
module spregfile(	input clk,
						input we, ra,
						input [31:0] wd0, wd1,
						output [31:0] rd
);
	//two special purpose registers, so 2 registers of 32 bits
	reg[31:0] rf[1:0];
	//if write enabled, then we assign high and low their values
	
	always @(posedge clk) begin
		if(we==1'b1)
			rf[1'b0] <=wd0;
			rf[1'b1] <=wd1;
		end
	//we output rd, 0 corresponds to low, 1 corresponds to high
	assign rd = (ra!= 1'b0) ? rf[1'b1]:rf[1'b0];
	
endmodule

//flopr, a flip flop register, which updates pc = pcnext
//inputs: clk, reset, pc
//outputs: pcnext
module flopr #(parameter WIDTH = 8) (	
	input clk, reset,
	input [WIDTH-1:0] d,
	output reg [WIDTH-1:0] q
);
	always @(posedge clk, posedge reset)
		if(reset) q<=0;
		else q<=d;
endmodule

//signext
module signext(input [15:0] a, output [31:0] y);
	assign y = {{16{a[15]}}, a};
endmodule

//shiftleft 2
module sl2(input [31:0] a, output [31:0] y);
	assign y = {a[29:0], 2'b00};
endmodule

//mux2
module mux2 #(paramter WIDTH = 8) (
	input [WIDTH-1:0] d0, d1, 
	input s,
	output [WIDTH-1:0] y
);
	assign y= s?d1:d0;
endmodule

//mux3, used d0,d1,d2,
	input [1:0] s,
	output [WIDTH-1:0] y
);
	assign y = (s== 2'b00) ? d0: ((s==2'b01)?d1:d2);
endmodule to select between rt, rd and ra in jr
//the values for regdest are 00 for rt, 01 for rd, 11 for ra
module mux3 #(parameter WIDTH = 8) (
	input [WIDTH-1:0]
);

module adder(input [31:0] a, b, output [31:0] y);
	assign y = a+b;
endmodule

//alu:
//inputs: a,b,shamt,alu_control
//outputs: result, wd0, wd1, zero
//working: precompute the results, then just assign result, wd0, wd1 and zero
module alu (	input [31:0] a,b,
					input [4:0] shamt,
					input [3:0] alu_control,
					output reg [31:0] result, wd0, wd1,
					output zero 
);
	
	wire [31:0] b2, sum, slt, sra_sign, sra_aux;
	wire [63:0] product, quotient, remainder;
	//if alu control[2] is 1, then it's subtraction
	assign b2 = alu_control[2]?~b:b;
	//sum is just the result of addition or subtraction
	assign sum = a + b2 + alu_control[2];
	//slt is just the MSB of the sum
	assign slt = sum[31];
	//most significant shamt bits are set to 1, rest to 0
	assign sra_sign = 32'b1111111111111111 <<(32-shamt);
	//b is right shifted s times
	assign sra_aux = b>>shamt;
	assign product = a*b;
	assign quotient = a/b;
	assign remainder = a%b;
	
	
	
	
	
	
	always@(*) 
		case(alu_control[3:0])
			4'b0000: result <=a&b;// and
			4'b0001: result <=a |b;//or
			4'b0010: result<=sum;//addition
			4'b0011: result <=b <<shamt;// leftshifting b by shamt
			4'b1011: result<=b<<a;//leftshifting b by a
			4'b0100: result<=b>>shamt;//rightshifting b by shamt
			4'b1100:result <= b>>a;//rightshifting b by a 
			4'b0101: result<=sra_sign | sra_aux;// if shift amount is 0 to 16, then i
			4'b0110: result <=sum; // subtraction
			4'b0111: result <=slt; //set less than
			4'b1010:
				begin
					result <=product[31:0];
					wd0<=product[31:0];
					wd1<=product[63:32];
				end
			4'b1110:
				begin
					result <=quotient;
					wd0<=quotient;
					wd1<=remaineder;
				end
			4'b1000: result <=b <<5'd16;
		endcase
		assign zero = (result ==32'd0);
endmodule
					