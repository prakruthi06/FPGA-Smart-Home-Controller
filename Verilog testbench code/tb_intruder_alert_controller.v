`timescale 1ns / 1ps
module tb_intruder_alert_controller;
 reg clk;
    reg reset;
    reg motion_detected;
    wire security_leds;
    wire buzzer_on;

// DUT 
    intruder_alert_controller dut (
        .clk(clk),
        .reset(reset),
        .motion_detected(motion_detected),
        .security_leds(security_leds),
        .buzzer_on(buzzer_on)
    );

// Clock  (50 MHz)
    initial clk = 0;
    always #10 clk = ~clk;

    initial begin
// Initial state
        reset = 1;
        motion_detected = 0;
        #50 reset = 0;

// No motion
        #100;

// Motion detected
        motion_detected = 1;
        #600;

// Motion cleared
        motion_detected = 0;
        #200;

        $stop;
    end

endmodule
