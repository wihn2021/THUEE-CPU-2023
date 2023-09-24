module PCRegister (
    input clk,
    input rst,
    input stall,
    input [31:0] newPC,
    output reg [31:0] PC
);

always @ (posedge clk)
begin
    if (rst)
    begin
        PC <= 32'b0;
    end
    else
    if (stall)
    begin
        PC <= PC;
    end
    else
    begin
        PC <= newPC;
    end
end
    
endmodule