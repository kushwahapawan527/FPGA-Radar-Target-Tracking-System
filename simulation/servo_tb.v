`timescale 1ns/1ps

module servo_tb;

reg clk = 0;
reg [7:0] angle = 0;
wire pwm;

// Instantiate module
servo_controller uut (
    .clk(clk),
    .angle(angle),
    .pwm(pwm)
);

// 100 MHz clock
always #5 clk = ~clk;

initial begin
    // Test different angles
    #1000 angle = 0;
    #1000000 angle = 90;
    #1000000 angle = 180;
    #1000000 $stop;
end

endmodule
