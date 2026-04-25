module uart_tx(
    input clk,
    input [7:0] data,
    input start,
    output reg tx = 1,     // idle HIGH
    output reg busy = 0
);

parameter CLK_PER_BIT = 10416;

reg [13:0] clk_count = 0;
reg [3:0] bit_index = 0;
reg [9:0] tx_data = 10'b1111111111;

always @(posedge clk) begin

    if(start && !busy) begin
        busy <= 1;
        tx_data <= {1'b1, data, 1'b0};
        bit_index <= 0;
        clk_count <= 0;
    end

    if(busy) begin
        clk_count <= clk_count + 1;

        if(clk_count >= CLK_PER_BIT) begin
            clk_count <= 0;
            tx <= tx_data[bit_index];
            bit_index <= bit_index + 1;

            if(bit_index == 9) begin
                busy <= 0;
                tx <= 1; // back to idle
            end
        end
    end
end

endmodule
