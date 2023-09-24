module Reg_IF_ID (
    input clk,
    input rst,
    input stall,
    output reg [5: 0] out_Opcode,
    output reg [5: 0] out_Funct,
    input [31: 0] in_PC,
    input [31: 0] in_Instruction,
    output reg [31: 0] out_PC,
    output reg [4: 0] out_rs,
    output reg [4: 0] out_rt,
    output reg [4: 0] out_rd,
    output reg [15: 0] out_Imm16,
    output reg [4: 0] out_shamt
);

always @ (posedge clk)
begin
    if (rst)
    begin
        out_Opcode <= 6'b0;
        out_Funct <= 6'b0;
        out_PC <= 32'b0;
        out_rs <= 5'b0;
        out_rt <= 5'b0;
        out_rd <= 5'b0;
        out_Imm16 <= 16'b0;
        out_shamt <= 5'b0;
    end
    else
    begin
        if (!stall)
        begin
            out_Opcode <= in_Instruction[31:26];
            out_Funct <= in_Instruction[5:0];
            out_PC <= in_PC;
            out_rs <= in_Instruction[25:21];
            out_rt <= in_Instruction[20:16];
            out_rd <= in_Instruction[15:11];
            out_Imm16 <= in_Instruction[15:0];
            out_shamt <= in_Instruction[10:6];
        end
    end
end
    
endmodule