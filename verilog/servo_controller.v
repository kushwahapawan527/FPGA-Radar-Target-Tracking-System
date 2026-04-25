module servo_controller(
    input clk,              // 100 MHz clock
    input [7:0] angle,      // 0 to 180 degree
    output reg pwm          // PWM output to servo
);

// 20ms period counter (100 MHz clock)
reg [20:0] counter = 0;

// Pulse width (1ms to 2ms)
reg [20:0] pulse_width;

always @(posedge clk) begin
    if(counter >= 2000000)
        counter <= 0;
    else
        counter <= counter + 1;
end

// Convert angle to pulse width
always @(*) begin
    // 1ms = 100000 counts
    // 2ms = 200000 counts
    pulse_width = 100000 + (angle * 555);
end

// PWM generation
always @(posedge clk) begin
    if(counter < pulse_width)
        pwm <= 1;
    else
        pwm <= 0;
end

endmodule
