module MEMForwardingUnit (
    input [4:0] rt_MEM,
    input [4:0] rt_WB,
    input MemWrite_MEM,
    input MemRead_WB,
    input [31:0] RFReadData2_MEM,
    input [31:0] MemReadData_WB,
    output [31: 0] out_MemoryShouldWriteData
);
    
assign out_MemoryShouldWriteData = (MemWrite_MEM && MemRead_WB && rt_MEM == rt_WB)? MemReadData_WB: RFReadData2_MEM;

endmodule