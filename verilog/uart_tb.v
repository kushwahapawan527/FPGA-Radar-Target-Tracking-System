`timescale 1ns/1ps

module uart_tb;

reg clk = 0;
reg start = 0;
reg [7:0] data = 8'h55;

wire tx;
wire busy;

uart_tx uut (
    .clk(clk),
    .data(data),
    .start(start),
    .tx(tx),
    .busy(busy)
);

always #5 clk = ~clk;

initial begin
    $dumpfile("wave.vcd");
    $dumpvars(0, uart_tb);

    #1000;
    start = 1;
    #100;        // IMPORTANT (pehle 10 tha, ab 100)
    start = 0;

    #20000000;   // IMPORTANT (long simulation)
    $finish;
end

endmodule
