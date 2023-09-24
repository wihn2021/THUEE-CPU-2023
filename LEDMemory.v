module LEDMemory (
    input clk,
    input rst,
    input [31: 0] addr,
    input [31: 0] data_in,
    output [31: 0] data_out,
    input LEDMemoryWr,
    input LEDMemoryRd,
    output [6: 0] led_out,
    output [3: 0] an_out
);
    
    reg [11:0] data;
    assign led_out = data[11:5];
    assign an_out = data[3:0];
    assign data_out = LEDMemoryRd ? {20'h0, data} : 32'h0;
always @ (posedge clk) begin
    if (rst) begin
        data <= 12'h0;
    end
    else begin
        if (LEDMemoryWr) begin
            data <= data_in[11:0];
        end
    end
end

endmodule