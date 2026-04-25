module servo_controller(
    input clk,
    input [7:0] angle,
    output reg pwm
);

reg [21:0] counter = 0;
reg [21:0] pulse_width;

// 20 ms period
always @(posedge clk) begin
    if(counter >= 2000000)
        counter <= 0;
    else
        counter <= counter + 1;
end

// angle → pulse width
always @(*) begin
    pulse_width = 100000 + (angle * 555);
end

// PWM output
always @(posedge clk) begin
    if(counter < pulse_width)
        pwm <= 1;
    else
        pwm <= 0;
end

endmodule
