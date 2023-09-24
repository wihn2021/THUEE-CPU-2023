`timescale 1ns/1ps

module LEDControl (
    input clk,
    input rst,
    input [31: 0] addr,
    input [31: 0] data_in,
    output [6: 0] led_out,
    output [3: 0] an_out,
);
    reg [11:0] data;
    assign led_out = data[11:5];
    assign an_out = data[3:0];
always @ (posedge clk) begin
    if (rst) begin
        data <= 12'h0;
    end
    else begin
        data <= data_in[11:0];
    end
end
endmodule