module CPU (
    input sysclk,
    input rst,
    output [6: 0] led,
    output [3: 0] an
);

/* ----- Variables ----- */

// global start
wire [31: 0] Instruction;
wire [31: 0] PC;
// only IF needs flush
reg [4:0] flush;
reg stall;

wire [31:0] PC_should_be;


// global end

// ID start

wire [5:0] Opcode_ID;
wire [5:0] Funct_ID;
wire [4:0] rs_ID;
wire [4:0] rt_ID;
wire [4:0] rd_ID;
wire [15:0] Imm16_ID;
wire [4:0] Shamt_ID;

wire [31:0] PC_plus4;


wire [31: 0] PC_ID;
wire [31:0] Branch_PC;

// Control signals
wire [2 -1:0] PCSrc_ID    ;
wire Branch_ID            ;
wire RegWrite_ID          ;
wire [1:0] RegDst_ID   ;
wire MemRead_ID           ;
wire MemWrite_ID          ;
wire [2 -1:0] MemtoReg_ID ;
wire ALUSrc1_ID           ;
wire ALUSrc2_ID           ;
wire ExtOp_ID             ;
wire LuOp_ID              ;
wire [4 -1:0] ALUOp_ID    ;
wire [31:0] BranchForwardingA_ID;
wire [31:0] BranchForwardingB_ID;

wire [31: 0] RFReadData1_ID;
wire [31: 0] RFReadData2_ID;
wire [31: 0] Imm32_ID;
wire [31: 0] Imm32Shift_ID;

wire BranchResult_ID;
// ID end

// EX start

wire [31: 0] PC_EX;
wire Branch_EX;
wire [4: 0] rs_EX;
wire [4: 0] rt_EX;
wire [4: 0] rd_EX;
wire [5: 0] Funct_EX;
wire [31: 0] RFReadData1_EX;
wire [31: 0] RFReadData2_EX;
wire [31: 0] Imm32_EX;
wire ALUSrc1_EX;
wire ALUSrc2_EX;
wire [3:0] ALUOp_EX;
wire [1:0] RegDst_EX;
wire [4:0] Shamt_EX;
wire [4:0] RegWriteAddr_EX;

wire [31:0] ForwardingA_EX;
wire [31:0] ForwardingB_EX;
wire [31:0] ALUIn1_EX;
wire [31: 0] ALUIn2_EX;

wire [31: 0] ALUOut_EX;
wire Zero_EX;

wire [4: 0] ALUCtl_EX;
wire Sign_EX;

wire [1: 0] PCSrc_EX;
wire RegWrite_EX;
wire MemRead_EX;
wire MemWrite_EX;
wire [1:0] MemtoReg_EX;
wire ExtOp_EX;
wire LuOp_EX;

// EX end

// MEM start

wire [31: 0] ALUOut_MEM;
wire [31: 0] RFReadData2_MEM;
wire MemRead_MEM;
wire MemWrite_MEM;
wire [31: 0] MemReadData_MEM;
wire Zero_MEM;
wire [1:0] MemtoReg_MEM;
wire RegWrite_MEM;

wire [4: 0] RegWriteAddr_MEM;

wire [4:0] rt_MEM;
wire [31:0] MEMForwardingA;
wire [31:0] PC_MEM;

wire [31:0] WrapperDataMemoryAddr;
wire [31:0] WrapperDataMemoryDataIn;
wire [31:0] WrapperDataMemoryDataOut;
wire WrapperDataMemoryWr;
wire WrapperDataMemoryRd;

wire [31:0] WrapperLEDMemoryAddr;
wire [31:0] WrapperLEDMemoryDataIn;
wire [31:0] WrapperLEDMemoryDataOut;
wire WrapperLEDMemoryWr;
wire WrapperLEDMemoryRd;


// MEM end

// WB start

wire [4:0] RegWriteAddr_WB;
wire [31:0] PC_WB;
wire [31: 0] MemReadData_WB;
wire [1: 0] MemtoReg_WB;
wire RegWrite_WB;
wire [31:0] ALUOut_WB;

wire [31:0] RegWriteData_WB;
wire [4:0] rt_WB;
wire MemRead_WB;

// WB end

InstructionMemory CPUInstructionMemory(
    .clk(sysclk),
    .rst(rst),
    .PC(PC),
    .Instruction(Instruction)
);

assign PC_plus4 = PC + 4;

PCRegister CPUProgramCounter(
    .clk(sysclk),
    .rst(rst),
    .stall(stall),
    .newPC(PC_should_be),
    .PC(PC)
);


wire [31:0] in_IF_ID_PC_plus4;
wire [31:0] in_IF_ID_Instruction;

assign in_IF_ID_PC_plus4 = flush[0] ? 32'b0 : PC_plus4;
assign in_IF_ID_Instruction = flush[0] ? 32'b0 : Instruction;

Reg_IF_ID IF_ID(
    .clk(sysclk),
    .rst(rst),
    .stall(stall),
    .out_Opcode(Opcode_ID),
    .out_Funct(Funct_ID),
    .in_PC(in_IF_ID_PC_plus4),
    .in_Instruction(in_IF_ID_Instruction),
    .out_PC(PC_ID),
    .out_rs(rs_ID),
    .out_rt(rt_ID),
    .out_rd(rd_ID),
    .out_Imm16(Imm16_ID),
    .out_shamt(Shamt_ID)
);

BranchForwardingUnit CPUBranchForwarding(
    .rs_ID(rs_ID),
    .rt_ID(rt_ID),
    .RFReadData1_ID(RFReadData1_ID),
    .RFReadData2_ID(RFReadData2_ID),
    .RegWriteAddr_MEM(RegWriteAddr_MEM),
    .ALUOut_MEM(ALUOut_MEM),
    .RegWrite_MEM(RegWrite_MEM),
    .RegWriteData_WB(RegWriteData_WB),
    .RegWrite_WB(RegWrite_WB),
    .RegWriteAddr_WB(RegWriteAddr_WB),
    .BranchForwardingA(BranchForwardingA_ID),
    .BranchForwardingB(BranchForwardingB_ID)
);

BranchUnit CPUBranch(
    .OpCode(Opcode_ID),
    .arg1(BranchForwardingA_ID),
    .arg2(BranchForwardingB_ID),
    .result(BranchResult_ID)
);

assign Branch_PC = (Branch_ID && BranchResult_ID) ? PC_ID + Imm32Shift_ID : PC_plus4;
assign PC_should_be = (PCSrc_ID == 2'b00) ? Branch_PC : (PCSrc_ID == 2'b01) ? {PC_ID[31:28], rs_ID, rt_ID, rd_ID, Shamt_ID, Funct_ID, 2'b00} : {RFReadData1_ID};

Control CPUControl(
    .OpCode(Opcode_ID),
    .Funct(Funct_ID),
    .PCSrc(PCSrc_ID),
    .Branch(Branch_ID),
    .RegWrite(RegWrite_ID),
    .RegDst(RegDst_ID),
    .MemRead(MemRead_ID),
    .MemWrite(MemWrite_ID),
    .MemtoReg(MemtoReg_ID),
    .ALUSrc1(ALUSrc1_ID),
    .ALUSrc2(ALUSrc2_ID),
    .ExtOp(ExtOp_ID),
    .LuOp(LuOp_ID),
    .ALUOp(ALUOp_ID)
);

RegisterFile CPURF(
    .rst(rst),
    .clk(sysclk),
    .RegWrite(RegWrite_WB),
    .Read_register1(rs_ID),
    .Read_register2(rt_ID),
    .Write_register(RegWriteAddr_WB),
    .Write_data(RegWriteData_WB),
    .Read_data1(RFReadData1_ID),
    .Read_data2(RFReadData2_ID)
);

ImmUnit CPUImmUnit(
    .ExtOp(ExtOp_ID),
    .Imm16(Imm16_ID),
    .Imm32(Imm32_ID)
);

assign RegWriteAddr_EX = (RegDst_EX == 2'b10)? 5'd31: (RegDst_EX == 2'b1)? rd_EX : rt_EX;

Reg_ID_EX ID_EX(
    sysclk,
    rst,
    flush[1],
    PCSrc_ID,
    Branch_ID,
    RegWrite_ID,
    RegDst_ID,
    MemRead_ID,
    MemWrite_ID,
    MemtoReg_ID ,
    ALUSrc1_ID,
    ALUSrc2_ID,
    ExtOp_ID,
    LuOp_ID,
    ALUOp_ID,
    RFReadData1_ID,
    RFReadData2_ID,
    Imm32_ID,
    rs_ID,
    rt_ID,
    rd_ID,
    Funct_ID,
    Shamt_ID,
    PC_ID,
    PCSrc_EX,
    Branch_EX,
    RegWrite_EX,
    RegDst_EX,
    MemRead_EX,
    MemWrite_EX,
    MemtoReg_EX,
    ALUSrc1_EX,
    ALUSrc2_EX,
    ExtOp_EX,
    LuOp_EX,
    ALUOp_EX,
    RFReadData1_EX,
    RFReadData2_EX,
    Imm32_EX,
    rs_EX,
    rt_EX,
    rd_EX,
    Funct_EX,
    Shamt_EX,
    PC_EX
);

Shift2Unit CPUShift2Unit(
    .Imm32(Imm32_ID),
    .Imm32Shift(Imm32Shift_ID)
);

ALUForwardingUnit CPUALUForwarding(
    .rs_EX(rs_EX),
    .rt_EX(rt_EX),
    .RFReadData1_EX(RFReadData1_EX),
    .RFReadData2_EX(RFReadData2_EX),
    .ALUOut_MEM(ALUOut_MEM),
    .RegWrite_MEM(RegWrite_MEM),
    .RegWriteAddr_MEM(RegWriteAddr_MEM),
    .RegWriteData_WB(RegWriteData_WB),
    .RegWrite_WB(RegWrite_WB),
    .RegWriteAddr_WB(RegWriteAddr_WB),
    .ALUInA(ForwardingA_EX),
    .ALUInB(ForwardingB_EX)
);

assign ALUIn2_EX = ALUSrc2_EX ? Imm32_EX : ForwardingB_EX;

ALUControl CPUALUControl(
    .ALUOp(ALUOp_EX),
    .Funct(Funct_EX),
    .ALUCtl(ALUCtl_EX),
    .Sign(Sign_EX)
);

assign ALUIn1_EX = ALUSrc1_EX ? {27'h0, Shamt_EX} : ForwardingA_EX;

ALU CPUALU(
    .in1(ALUIn1_EX),
    .in2(ALUIn2_EX),
    .ALUCtl(ALUCtl_EX),
    .Sign(Sign_EX),
    .out(ALUOut_EX),
    .zero(Zero_EX)
);

Reg_EX_MEM EX_MEM(
    sysclk,
    rst,
    RegWrite_EX,
    MemRead_EX,
    MemWrite_EX,
    MemtoReg_EX,
    ALUOut_EX,
    RegWriteAddr_EX,
    ForwardingB_EX,
    rt_EX,
    PC_EX,
    RegWrite_MEM,
    MemRead_MEM,
    MemWrite_MEM,
    MemtoReg_MEM,
    ALUOut_MEM,
    RegWriteAddr_MEM,
    RFReadData2_MEM,
    rt_MEM,
    PC_MEM
);

MEMForwardingUnit CPUMEMForwarding(
    rt_MEM,
    rt_WB,
    MemWrite_MEM,
    MemRead_WB,
    RFReadData2_MEM,
    MemReadData_WB,
    MEMForwardingA
);

DataMemory CPUDataMemory(
    .clk(sysclk),
    .rst(rst),
    .DataMemoryRd(WrapperDataMemoryRd),
    .DataMemoryWr(WrapperDataMemoryWr),
    .addr(WrapperDataMemoryAddr),
    .data_in(WrapperDataMemoryDataIn),
    .data_out(WrapperDataMemoryDataOut)
);

LEDMemory CPULEDMemory(
    .clk(sysclk),
    .rst(rst),
    .addr(WrapperLEDMemoryAddr),
    .data_in(WrapperLEDMemoryDataIn),
    .data_out(WrapperLEDMemoryDataOut),
    .LEDMemoryRd(WrapperLEDMemoryRd),
    .LEDMemoryWr(WrapperLEDMemoryWr),
    .led_out(led),
    .an_out(an)
);

MemoryWrapper CPUMemoryControl(
    .addr(ALUOut_MEM),
    .data_in(MEMForwardingA),
    .data_out(MemReadData_MEM),
    .MemoryWr(MemWrite_MEM),
    .MemoryRd(MemRead_MEM),

    .DataMemoryaddr(WrapperDataMemoryAddr),
    .DataMemorydatain(WrapperDataMemoryDataIn),
    .DataMemorydataout(WrapperDataMemoryDataOut),
    .DataMemoryWr(WrapperDataMemoryWr),
    .DataMemoryRd(WrapperDataMemoryRd),

    .LEDMemoryaddr(WrapperLEDMemoryAddr),
    .LEDMemorydatain(WrapperLEDMemoryDataIn),
    .LEDMemorydataout(WrapperLEDMemoryDataOut),
    .LEDMemoryWr(WrapperLEDMemoryWr),
    .LEDMemoryRd(WrapperLEDMemoryRd)
);

Reg_MEM_WB MEM_WB(
    sysclk,
    rst,
    MemReadData_MEM,
    MemtoReg_MEM,
    RegWrite_MEM,
    ALUOut_MEM,
    RegWriteAddr_MEM,
    rt_MEM,
    MemRead_MEM,
    PC_MEM,
    MemReadData_WB,
    MemtoReg_WB,
    RegWrite_WB,
    ALUOut_WB,
    RegWriteAddr_WB,
    rt_WB,
    MemRead_WB,
    PC_WB
);

assign RegWriteData_WB = (MemtoReg_WB == 2'b1) ? MemReadData_WB: (MemtoReg_WB == 2'b0)? ALUOut_WB: PC_WB;

/*
always @ (posedge sysclk) begin
    if (rst) begin
        flush <= 5'b0;
        stall <= 1'b0;
    end
end
*/

always @ (*) begin
    if (Branch_ID && 
    (
        (RegWrite_EX && 
            (RegWriteAddr_EX == rs_ID || RegWriteAddr_EX == rt_ID)
        ) || 
        (MemRead_MEM && 
            (RegWriteAddr_MEM == rs_ID || RegWriteAddr_MEM == rt_ID)
        )
    )
    )
    begin
        stall <= 1'b1;
    end
    else
    begin
        stall <= 1'b0;
    end
end

always @ (*) begin
    flush[1] = 1'b0;
end

always @ (*) begin
    if (PCSrc_ID != 2'b00 || Branch_ID && BranchResult_ID) begin
        flush[0] = 1;
    end
    else
    begin
        flush[0] = 0;
    end
    // flush[1] = stall[0];
end

endmodule