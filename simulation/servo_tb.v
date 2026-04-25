`timescale 1ns/1ps

module servo_tb;

reg clk = 0;
reg [7:0] angle = 0;
wire pwm;

// DUT (Device Under Test)
servo_controller uut (
    .clk(clk),
    .angle(angle),
    .pwm(pwm)
);

// 100 MHz clock (10ns period)
always #5 clk = ~clk;

initial begin
    // Dump waveform
    $dumpfile("wave.vcd");
    $dumpvars(0, servo_tb);

    // Test sequence (IMPORTANT: long time)
    angle = 0;
    #20000000;   // 20 ms

    angle = 90;
    #20000000;   // 20 ms

    angle = 180;
    #20000000;   // 20 ms

    $finish;
end

endmodule
