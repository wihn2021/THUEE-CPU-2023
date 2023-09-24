module Reg_MEM_WB (
    input clk,
    input rst,
    input [31:0] in_MemReadData,
    input [1:0] in_MemtoReg,
    input in_RegWrite,
    input [31:0] in_ALUOut,
    input [4:0] in_RegWriteAddr,
    input [4:0] in_rt,
    input in_MemRead,
    input [31:0] in_PC,
    output reg [31:0] out_MemReadData,
    output reg [1:0] out_MemtoReg,
    output reg out_RegWrite,
    output reg [31:0] out_ALUOut,
    output reg [4:0] out_RegWriteAddr,
    output reg [4:0] out_rt,
    output reg out_MemRead,
    output reg [31:0] out_PC
);

always @ (posedge clk)
begin
    if (rst)
    begin
        out_MemReadData <= 32'b0;
        out_MemtoReg <= 2'b0;
        out_RegWrite <= 1'b0;
        out_ALUOut <= 32'b0;
        out_RegWriteAddr <= 5'b0;
        out_rt <= 5'b0;
        out_MemRead <= 1'b0;
        out_PC <= 32'b0;
    end
    else
    begin
        out_MemReadData <= in_MemReadData;
        out_MemtoReg <= in_MemtoReg;
        out_RegWrite <= in_RegWrite;
        out_ALUOut <= in_ALUOut;
        out_RegWriteAddr <= in_RegWriteAddr;
        out_rt <= in_rt;
        out_MemRead <= in_MemRead;
        out_PC <= in_PC;
    end
end
    
endmodule