`timescale 1ns / 1ps

module config_registers(
    input clk,
    input reset,
    input load,
    input [7:0] temp_in,
    input [7:0] light_in,
    output reg [7:0] temp_threshold,
    output reg [7:0] light_threshold
);

always @(posedge clk) begin
    if (reset) begin
        temp_threshold <= 0;
        light_threshold <= 0;
    end else begin
        if (load) begin
            temp_threshold <= temp_in;
            light_threshold <= light_in;
        end
        // else: retain previous values
    end
end

endmodule
