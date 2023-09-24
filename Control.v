module Control(
    input  [6 -1:0] OpCode   ,
    input  [6 -1:0] Funct    ,
    output [2 -1:0] PCSrc    ,
    output Branch            ,
    output RegWrite          ,
    output [2 -1:0] RegDst   ,
    output MemRead           ,
    output MemWrite          ,
    output [2 -1:0] MemtoReg ,
    output ALUSrc1           ,
    output ALUSrc2           ,
    output ExtOp             ,
    output LuOp              ,
    output [4 -1:0] ALUOp
);
    
    assign PCSrc = (OpCode == 6'h2 || OpCode == 6'h3)? 2'b01: (OpCode == 6'h0 && (Funct == 6'h8 || Funct == 6'h9))? 2'b10: 2'b00;
    assign Branch = (OpCode == 6'h1 || OpCode == 6'h4 || OpCode == 6'h5 || OpCode == 6'h6 || OpCode == 6'h7)? 1'b1: 1'b0;
    assign RegWrite = (OpCode == 6'h2b || Branch || OpCode == 6'h2 || OpCode == 6'h0 && Funct == 6'h8)? 1'b0: 1'b1;
    assign RegDst = (OpCode == 6'h3) ? 2'b10 : (OpCode == 6'h23 || OpCode == 6'hf || OpCode >= 6'h8 && OpCode <= 6'hc) ? 2'b0 : 2'b1;
    assign MemRead = OpCode == 6'h23;
    assign MemWrite = OpCode == 6'h2b;
    assign MemtoReg = (OpCode == 6'h23)? 2'b1: (OpCode == 6'h3 || OpCode == 6'h0 && Funct == 6'h9)? 2'b10: 2'b0;
    assign ALUSrc1 = (OpCode == 6'h0 && (Funct == 6'h0 || Funct == 6'h2 || Funct == 6'h3))? 1'b1: 1'b0;
    assign ALUSrc2 = !(OpCode == 6'h0 || Branch || OpCode == 6'h1c);
    assign ExtOp = OpCode != 6'hc;
    assign LuOp = OpCode == 6'hf;

    // set ALUOp
    assign ALUOp[2:0] = 
        (OpCode == 6'h00)? 3'b010: 
        (OpCode == 6'h04)? 3'b001: 
        (OpCode == 6'h0c)? 3'b100: 
        (OpCode == 6'h0a || OpCode == 6'h0b)? 3'b101: 
        3'b000;
        
    assign ALUOp[3] = OpCode[0];

    
endmodule