`timescale 1ns / 1ps
module intruder_alert_controller(
    input clk,
    input reset,
    input motion_detected,
    output reg security_leds,
    output reg buzzer_on
);

// Counter 
reg [31:0] counter;

always @(posedge clk) begin
    if (reset) begin
        security_leds <= 0;
        buzzer_on <= 0;
        counter <= 0;
    end else begin
        if (motion_detected) begin
            counter <= counter + 1;

// LED blinking (slow toggle)
            if (counter[4])
                security_leds <= 1;
            else
                security_leds <= 0;

// Buzzer ON for short duration (scaled)
            if (counter < 30)
                buzzer_on <= 1;
            else
                buzzer_on <= 0;

        end else begin
            security_leds <= 0;
            buzzer_on <= 0;
            counter <= 0;
        end
    end
end
endmodule