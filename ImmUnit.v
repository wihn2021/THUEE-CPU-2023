module ImmUnit (
    input ExtOp,
    input [15: 0] Imm16,
    output [31: 0] Imm32
);
    
assign Imm32 = {ExtOp? {16{Imm16[15]}} : 16'b0, Imm16};

endmodule