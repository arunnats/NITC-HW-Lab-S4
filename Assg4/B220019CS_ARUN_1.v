module RISC18(
    input wire [63:0] PCin,
    input wire clock,
    input wire reset,
    output reg [15:0] ans,
    output reg [63:0] k
);

    reg [15:0] register [7:0];
    reg [63:0] storage; 
    
    integer PCIndex = 0;
    integer returnIndex = 0;
    
    reg [15:0] PC [3:0];
    
    localparam ADD = 4'b0000;
    localparam NDU = 4'b0010;
    localparam LW = 4'b0100;
    localparam SW = 4'b0101;
    localparam BEQ = 4'b0110;
    localparam JAL = 4'b1000;

    reg C, Z;
    
    always @(posedge clock or posedge reset) 
    begin
        if(reset) 
        begin
            PCIndex <= 0;
            register[0] <= 0;
            register[1] <= 1;
            register[2] <= 1;
            register[3] <= 0;
            register[4] <= 0;
            register[5] <= 0;
            register[6] <= 0;
            register[7] <= 0;
            PC[0] = PCin[63:48];
            PC[1] = PCin[47:32];
            PC[2] = PCin[31:16];
            PC[3] = PCin[15:0];
            ans <= 0;
            C <= 0;
            Z <= 0;
            storage <= 0; 
        end
        
        else
        begin
            case(PC[PCIndex][15:12])
                ADD:
                    begin
                        register[PC[PCIndex][11:9]] <= register[PC[PCIndex][8:6]] + register[PC[PCIndex][5:3]];
                        ans <= register[2];
                        C <= (register[PC[PCIndex][11:9]] < register[PC[PCIndex][8:6]]);
                        Z <= (register[PC[PCIndex][11:9]] == register[PC[PCIndex][8:6]]);
                        PCIndex <= PCIndex + 1;
                    end
                
                NDU:
                    begin
                        register[PC[PCIndex][11:9]] <= ~(register[PC[PCIndex][8:6]] & register[PC[PCIndex][5:3]]);
                        ans <= register[2];
                        C <= 0;  
                        Z <= (register[PC[PCIndex][11:9]] == 0);
                        PCIndex <= PCIndex + 1;
                    end
                
                LW:
                    begin
                        register[PC[PCIndex][11:9]] <= storage[PC[PCIndex][8:3]] + PC[PCIndex][5:0]; 
                        ans <= register[PC[PCIndex][11:9]];
                        C <= (register[PC[PCIndex][11:9]] < 0);
                        Z <= (register[PC[PCIndex][11:9]] == 0);
                        PCIndex <= PCIndex + 1;
                    end
                
                SW:
                    begin
                        storage[PC[PCIndex][8:3]] <= register[PC[PCIndex][11:9]]; 
                        C <= 0; 
                        Z <= 0; 
                        PCIndex <= PCIndex + 1;
                    end
                
                BEQ:
                    begin
                        if (register[PC[PCIndex][11:9]] == register[PC[PCIndex][8:6]])
                            PCIndex <= PCIndex + PC[PCIndex][5:0]; 
                        else
                            PCIndex <= PCIndex + 1;
                        C <= 0; 
                        Z <= (register[PC[PCIndex][11:9]] == register[PC[PCIndex][8:6]]);
                    end
                
                JAL:
                    begin
                        register[7] <= PCIndex + 1; 
                        PCIndex <= PCIndex + PC[PCIndex][8:0]; 
                        C <= 0; 
                        Z <= 0; 
                    end
                
                default:
                    begin
                        C <= 0;
                        Z <= 0;
                        PCIndex <= PCIndex + 1;
                    end
            endcase
        end
    end
endmodule
