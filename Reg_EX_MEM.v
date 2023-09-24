module Reg_EX_MEM (
    input clk,
    input rst,
    input in_RegWrite,
    input in_MemRead,
    input in_MemWrite,
    input [1:0] in_MemtoReg,
    input [31:0] in_ALUOut,
    input [4:0] in_RegWriteAddr,
    input [31:0] in_RFReadData2,
    input [4:0] in_rt,
    input [31:0] in_PC,
    output reg out_RegWrite,
    output reg out_MemRead,
    output reg out_MemWrite,
    output reg [1:0] out_MemtoReg,
    output reg [31:0] out_ALUOut,
    output reg [4:0] out_RegWriteAddr,
    output reg [31:0] out_RFReadData2,
    output reg [4:0] out_rt,
    output reg [31:0] out_PC
);

always @ (posedge clk)
begin
    if (rst)
    begin
        out_RegWrite <= 1'b0;
        out_MemRead <= 1'b0;
        out_MemWrite <= 1'b0;
        out_MemtoReg <= 2'b0;
        out_ALUOut <= 32'b0;
        out_RegWriteAddr <= 5'b0;
        out_RFReadData2 <= 32'b0;
        out_rt <= 5'b0;
        out_PC <= 32'b0;
    end
    else
    begin
        out_RegWrite <= in_RegWrite;
        out_MemRead <= in_MemRead;
        out_MemWrite <= in_MemWrite;
        out_MemtoReg <= in_MemtoReg;
        out_ALUOut <= in_ALUOut;
        out_RegWriteAddr <= in_RegWriteAddr;
        out_RFReadData2 <= in_RFReadData2;
        out_rt <= in_rt;
        out_PC <= in_PC;
    end
end
    
endmodule