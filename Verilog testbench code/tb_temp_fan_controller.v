`timescale 1ns / 1ps
//Signals
module tb_temp_fan_controller;
// Signals
    reg clk;
    reg reset;
    reg [7:0] temp_value;
    reg [7:0] temp_threshold;
    wire fan_on;
    wire overheat_alarm;

// Instantiate DUT
    temp_fan_controller dut (
        .clk(clk),
        .reset(reset),
        .temp_value(temp_value),
        .temp_threshold(temp_threshold),
        .fan_on(fan_on),
        .overheat_alarm(overheat_alarm)
    );

// Clock generation: 50 MHz
    initial clk = 0;
// period = 20 ns i.e 50 MHz
    always #10 clk = ~clk; 

// Test stimulus
    initial begin
// Initialize signals
        reset = 1;
        temp_value = 8'd0;
        temp_threshold = 8'd40;
// release reset       
        #50 reset = 0; 

// Normal temperature
        #50 temp_value = 8'd30;
        #100;

// Overheat condition
        temp_value = 8'd45;
        #500;

// Back to normal
        temp_value = 8'd35;
        #200;
        
// End simulation
        $stop; 
    end
endmodule
