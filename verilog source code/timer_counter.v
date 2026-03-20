`timescale 1ns / 1ps

module timer_counter(
    input clk,
    input reset,
    output reg pulse_1s,
    output reg blink_clk
);

reg [31:0] counter;

always @(posedge clk) begin
    if (reset) begin
        counter <= 0;
        pulse_1s <= 0;
        blink_clk <= 0;
    end else begin
        counter <= counter + 1;

// Generate 1-second pulse 
        if (counter == 20)
            pulse_1s <= 1;
        else
            pulse_1s <= 0;

// Generate slow blinking clock
        if (counter[5])
            blink_clk <= 1;
        else
            blink_clk <= 0;

// Reset counter to avoid overflow
        if (counter == 40)
            counter <= 0;
    end
end
endmodule
