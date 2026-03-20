`timescale 1ns/1ps
module tb_light_controller;

    reg clk;
    reg reset;
    reg [7:0] light_level;
    reg [7:0] light_threshold;
    wire room_lights;

// Instantiate DUT
    light_controller dut (
        .clk(clk),
        .reset(reset),
        .light_level(light_level),
        .light_threshold(light_threshold),
        .room_lights(room_lights)
    );

// Clock generation 50 MHz
    initial clk = 0;
    always #10 clk = ~clk;

// Test stimulus
    initial begin
        reset = 1;
        light_level = 8'd100;
        light_threshold = 8'd45;
        #50 reset = 0;

// Daylight scenario
        light_level = 8'd62;
        #100;

// Darkness scenario
        light_level = 8'd35;
        #200;

// Back to bright
        light_level = 8'd62;
        #100;

        $stop;
    end

endmodule

