`timescale 1ns / 1ps

module light_controller(
    input clk,
    input reset,
    input [7:0] light_level,
    input [7:0] light_threshold,
    output reg room_lights
    );
    
// Debounce register
reg [7:0] light_reg;

always @(posedge clk) begin
    if (reset) begin
        room_lights <= 0;
        light_reg <= 0;
    end else begin
// Store current light value
        light_reg <= light_level;

// Compare with threshold
        if (light_reg < light_threshold)
            room_lights <= 1; // Lights ON
        else
            room_lights <= 0; // Lights OFF
    end
end
endmodule
