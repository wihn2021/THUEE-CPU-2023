module Shift2Unit (
    input [31: 0] Imm32,
    output [31: 0] Imm32Shift
);
    
assign Imm32Shift = {Imm32[29:0], 2'b00};

endmodule