`timescale 1ns/1ps
module tb_CPU (
);


reg sysclk;
reg rst;
wire [6:0] led;
wire [3:0] an;

CPU CPU (
    .sysclk(sysclk),
    .rst(rst),
    .led(led),
    .an(an)
);

always #5 sysclk = ~sysclk;

initial begin
    rst = 1'b0;
    sysclk = 1'b0;
    #10 rst = 1'b1;
    #10 rst = 1'b0;
    #1000000000 $finish;
end
endmodule