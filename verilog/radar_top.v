module radar_top(
    input clk,
    input echo,
    output trig,
    output pwm,
    output tx
);

wire [15:0] distance;
reg [7:0] angle = 0;
reg start = 0;
wire busy;

// Servo
servo_controller servo(
    .clk(clk),
    .angle(angle),
    .pwm(pwm)
);

// Ultrasonic
ultrasonic us(
    .clk(clk),
    .echo(echo),
    .trig(trig),
    .distance(distance)
);

// UART
uart_tx uart(
    .clk(clk),
    .data(distance[7:0]),
    .start(start),
    .tx(tx),
    .busy(busy)
);

// Angle sweep
reg [25:0] counter = 0;

always @(posedge clk) begin
    counter <= counter + 1;

    if(counter == 50000000) begin
        counter <= 0;
        angle <= angle + 10;
        start <= 1;
    end else begin
        start <= 0;
    end
end

endmodule
