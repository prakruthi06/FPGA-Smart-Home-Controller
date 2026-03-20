`timescale 1ns / 1ps

module tb_top_level_controller;
reg clk;
    wire fan_on, room_lights, security_leds, buzzer_on;

    top_level_controller dut (
        .clk(clk),
        .fan_on(fan_on),
        .room_lights(room_lights),
        .security_leds(security_leds),
        .buzzer_on(buzzer_on)
    );

    initial clk = 0;
    always #10 clk = ~clk;

    initial begin
        #500;
        $stop;
    end
endmodule
