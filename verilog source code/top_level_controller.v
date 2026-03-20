
module top_level_controller(
    input clk,
    input reset,

    // Sensor inputs
    input [7:0] temp_value,
    input [7:0] light_level,
    input motion_detected,

    // Configuration inputs
    input load_config,
    input [7:0] temp_in,
    input [7:0] light_in,

    // Final outputs
    output fan_on,
    output room_lights,
    output security_leds,
    output buzzer_on
);

    // Internal wires
    wire [7:0] temp_threshold;
    wire [7:0] light_threshold;
    wire pulse_1s;
    wire blink_clk;


    // Configuration Registers

    config_registers cfg (
        .clk(clk),
        .reset(reset),
        .load(load_config),
        .temp_in(temp_in),
        .light_in(light_in),
        .temp_threshold(temp_threshold),
        .light_threshold(light_threshold)
    );


    // Temperature Fan Controller

    temp_fan_controller fan_ctrl (
        .clk(clk),
        .reset(reset),
        .temp_value(temp_value),
        .temp_threshold(temp_threshold),
        .fan_on(fan_on),
        .overheat_alarm()   
    );


    // Light Controller

    light_controller light_ctrl (
        .clk(clk),
        .reset(reset),
        .light_level(light_level),
        .light_threshold(light_threshold),
        .room_lights(room_lights)
    );


    // Intruder Alert Controller

    intruder_alert_controller intruder_ctrl (
        .clk(clk),
        .reset(reset),
        .motion_detected(motion_detected),
        .security_leds(security_leds),
        .buzzer_on(buzzer_on)
    );


    // Timer Counter (optional use)

    timer_counter timer (
        .clk(clk),
        .reset(reset),
        .pulse_1s(pulse_1s),
        .blink_clk(blink_clk)
    );

endmodule


