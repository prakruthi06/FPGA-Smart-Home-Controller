`timescale 1ns / 1ps
module temp_fan_controller(
    input clk,  //system clock
    input reset,  //synchronous reset
    input [7:0] temp_value,  //current temp
    input [7:0] temp_threshold,  //programmable temp
    output reg fan_on,  //fan indicator
    output reg overheat_alarm   //overheat alarm
    );

// Counter for alarm timing
reg [31:0] alarm_counter;

always @(posedge clk) begin
    if (reset) begin
        fan_on <= 0;
        overheat_alarm <= 0;
        alarm_counter <= 0;
    end else begin
        if (temp_value > temp_threshold) begin
            fan_on <= 1;

// 2-second alarm (scaled for simulation)
            if (alarm_counter < 20) begin
                overheat_alarm <= 1;
                alarm_counter <= alarm_counter + 1;
            end else begin
                overheat_alarm <= 0;
            end
        end else begin
            fan_on <= 0;
            overheat_alarm <= 0;
            alarm_counter <= 0;
        end
    end
end
endmodule
