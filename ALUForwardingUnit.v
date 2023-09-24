module ALUForwardingUnit (
    input [4: 0] rs_EX,
    input [4: 0] rt_EX,
    input [31:0] RFReadData1_EX,
    input [31:0] RFReadData2_EX,
    input [31:0] ALUOut_MEM,
    input RegWrite_MEM,
    input [4:0] RegWriteAddr_MEM,
    input [31:0] RegWriteData_WB,
    input RegWrite_WB,
    input [4:0] RegWriteAddr_WB,
    output [31: 0] ALUInA,
    output [31: 0] ALUInB
);
    
assign ALUInA = 
(rs_EX == 0)? 32'b0:
(RegWrite_MEM && (RegWriteAddr_MEM == rs_EX))? ALUOut_MEM:
                (RegWrite_WB && (RegWriteAddr_WB == rs_EX))? RegWriteData_WB:
                RFReadData1_EX;

assign ALUInB = 
(rt_EX == 0)? 32'b0:
(RegWrite_MEM && (RegWriteAddr_MEM == rt_EX))? ALUOut_MEM:
                (RegWrite_WB && (RegWriteAddr_WB == rt_EX))? RegWriteData_WB:
                RFReadData2_EX;

endmodule