module BranchUnit (
    input [5: 0] OpCode,
    input [31: 0] arg1,
    input [31: 0] arg2,
    output result
);

wire eq, ne, lt, le, gt, ge;


assign eq = arg1 == arg2;
assign ne = !eq;
assign lt = (arg1[31] ^ arg2[31])? arg1[31] : arg1 < arg2;
assign le = !gt;
assign gt = (arg1[31] ^ arg2[31])? arg2[31] : arg1 > arg2;
assign ge = !lt;

/*
always @(*)
begin
    eq <= arg1 == arg2;
    ne <= !eq;
    lt <= arg1 < arg2;
    le <= !gt;
    gt <= arg1 > arg2;
end
*/

assign result = (OpCode == 6'h4)? eq: (OpCode == 6'h6)? le: (OpCode == 6'h7)? gt: (OpCode == 6'h5)? ne: (OpCode == 6'h1)? lt: 1'b0;

/*
always @(*)
begin
    case (OpCode)
        6'h4: result = eq;
        6'h6: result = le;
        6'h7: result = gt;
        6'h5: result = ne;
        6'h1: result = lt;
        default: result = 1'b0;
    endcase
end

*/
    
endmodule