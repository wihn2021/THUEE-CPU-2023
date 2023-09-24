`timescale 1ns/1ps

module DataMemory (
    input clk,
    input rst,
    input [31: 0] addr,
    input [31: 0] data_in,
    output [31: 0] data_out,
    input DataMemoryWr,
    input DataMemoryRd
);
    parameter DataMemorySize = 512;
    reg [31: 0] DataMemoryData [DataMemorySize - 1 : 0];
    assign data_out = DataMemoryRd ? DataMemoryData[addr[10:2]] : 32'h0;
    always @(posedge clk) begin

            if (DataMemoryWr) begin
                DataMemoryData[addr[10:2]] <= data_in;
            end

    end
endmodule