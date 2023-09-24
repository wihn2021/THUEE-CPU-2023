module BranchForwardingUnit(
    input [4:0] rs_ID,
    input [4:0] rt_ID,
    input [31:0] RFReadData1_ID,
    input [31:0] RFReadData2_ID,
    input [4: 0] RegWriteAddr_MEM,
    input [31: 0] ALUOut_MEM,
    input RegWrite_MEM,
    input [4:0] RegWriteAddr_WB,
    input [31:0] RegWriteData_WB,
    input RegWrite_WB,
    output [31:0] BranchForwardingA,
    output [31:0] BranchForwardingB
);

assign BranchForwardingA = 
(rs_ID != 0 && RegWrite_MEM && (RegWriteAddr_MEM == rs_ID))? ALUOut_MEM:
                            (rs_ID != 0 && RegWrite_WB && (RegWriteAddr_WB == rs_ID))? RegWriteData_WB:
                            RFReadData1_ID;

assign BranchForwardingB = 
(rt_ID != 0 && RegWrite_MEM && (RegWriteAddr_MEM == rt_ID))? ALUOut_MEM:
                            (rt_ID != 0 && RegWrite_WB && (RegWriteAddr_WB == rt_ID))? RegWriteData_WB:
                            RFReadData2_ID;

endmodule