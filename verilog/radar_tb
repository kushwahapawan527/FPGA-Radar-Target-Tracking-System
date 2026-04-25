`timescale 1ns/1ps

module radar_tb;

reg clk = 0;
reg echo = 0;

wire trig, pwm, tx;

radar_top uut(
    .clk(clk),
    .echo(echo),
    .trig(trig),
    .pwm(pwm),
    .tx(tx)
);

always #5 clk = ~clk;

initial begin
    $dumpfile("wave.vcd");
    $dumpvars(0, radar_tb);

    // fake objects
    #10000 echo = 1;
    #30000 echo = 0;

    #100000 echo = 1;
    #60000 echo = 0;

    #200000 $finish;
end

endmodule
