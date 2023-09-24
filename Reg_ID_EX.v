module Reg_ID_EX (
    input clk,
    input rst,
    input flush,
    input [2 -1:0] in_PCSrc    ,
    input in_Branch            ,
    input in_RegWrite          ,
    input [1:0] in_RegDst   ,
    input in_MemRead           ,
    input in_MemWrite          ,
    input [2 -1:0] in_MemtoReg ,
    input in_ALUSrc1           ,
    input in_ALUSrc2           ,
    input in_ExtOp             ,
    input in_LuOp              ,
    input [4 -1:0] in_ALUOp    ,
    input [31: 0] in_RFReadData1,
    input [31: 0] in_RFReadData2,
    input [31: 0] in_Imm32     ,
    input [4:0] in_rs,
    input [4:0] in_rt,
    input [4:0] in_rd,
    input [5:0] in_Funct,
    input [4:0] in_Shamt,
    input [31:0] in_PC,
    output reg [2 -1:0] out_PCSrc    ,
    output reg out_Branch            ,
    output reg out_RegWrite          ,
    output reg [1:0] out_RegDst   ,
    output reg out_MemRead           ,
    output reg out_MemWrite          ,
    output reg [2 -1:0] out_MemtoReg ,
    output reg out_ALUSrc1           ,
    output reg out_ALUSrc2           ,
    output reg out_ExtOp             ,
    output reg out_LuOp              ,
    output reg [4 -1:0] out_ALUOp    ,
    output reg [31: 0] out_RFReadData1,
    output reg [31: 0] out_RFReadData2,
    output reg [31: 0] out_Imm32,
    output reg [4:0] out_rs,
    output reg [4:0] out_rt,
    output reg [4:0] out_rd,
    output reg [5:0] out_Funct,
    output reg [4:0] out_Shamt,
    output reg [31:0] out_PC
);

always @ (posedge clk)
begin
    if (rst || flush)
    begin
        out_PCSrc <= 3'b0;
        out_Branch <= 1'b0;
        out_RegWrite <= 1'b0;
        out_RegDst <= 2'b0;
        out_MemRead <= 1'b0;
        out_MemWrite <= 1'b0;
        out_MemtoReg <= 2'b0;
        out_ALUSrc1 <= 1'b0;
        out_ALUSrc2 <= 1'b0;
        out_ExtOp <= 1'b0;
        out_LuOp <= 1'b0;
        out_ALUOp <= 5'b0;
        out_RFReadData1 <= 32'b0;
        out_RFReadData2 <= 32'b0;
        out_Imm32 <= 32'b0;
        out_rs <= 5'b0;
        out_rt <= 5'b0;
        out_rd <= 5'b0;
        out_Funct <= 6'b0;
        out_Shamt <= 5'b0;
        out_PC <= 32'b0;
    end
    else
    begin
        out_PCSrc <= in_PCSrc;
        out_Branch <= in_Branch;
        out_RegWrite <= in_RegWrite;
        out_RegDst <= in_RegDst;
        out_MemRead <= in_MemRead;
        out_MemWrite <= in_MemWrite;
        out_MemtoReg <= in_MemtoReg;
        out_ALUSrc1 <= in_ALUSrc1;
        out_ALUSrc2 <= in_ALUSrc2;
        out_ExtOp <= in_ExtOp;
        out_LuOp <= in_LuOp;
        out_ALUOp <= in_ALUOp;
        out_RFReadData1 <= in_RFReadData1;
        out_RFReadData2 <= in_RFReadData2;
        out_Imm32 <= in_Imm32;
        out_rs <= in_rs;
        out_rt <= in_rt;
        out_rd <= in_rd;
        out_Funct <= in_Funct;
        out_Shamt <= in_Shamt;
        out_PC <= in_PC;
    end
end
    
endmodule