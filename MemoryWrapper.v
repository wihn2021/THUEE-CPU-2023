module MemoryWrapper (
    input [31: 0] addr,
    input [31: 0] data_in,
    output reg [31: 0] data_out,
    input MemoryWr,
    input MemoryRd,

    output reg [31: 0] DataMemoryaddr,
    output reg [31: 0] DataMemorydatain,
    input [31: 0] DataMemorydataout,
    output reg DataMemoryWr,
    output reg DataMemoryRd,

    output reg [31: 0] LEDMemoryaddr,
    output reg [31: 0] LEDMemorydatain,
    input [31: 0] LEDMemorydataout,
    output reg LEDMemoryWr,
    output reg LEDMemoryRd
);
    
always @ (*) begin
    if (addr < 32'h40000000)
    begin
        DataMemoryaddr <= addr;
        DataMemorydatain <= data_in;
        DataMemoryWr <= MemoryWr;
        DataMemoryRd <= MemoryRd;
        data_out <= DataMemorydataout;

        LEDMemoryWr <= 1'b0;
    end
    else
    begin
        if (addr == 32'h40000010)
        begin
            LEDMemoryaddr <= addr;
            LEDMemorydatain <= data_in;
            LEDMemoryWr <= MemoryWr;
            LEDMemoryRd <= MemoryRd;
            data_out <= LEDMemorydataout;

            DataMemoryWr <= 1'b0;
        end
    end
end

endmodule