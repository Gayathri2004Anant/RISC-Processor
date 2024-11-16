`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.10.2024 04:17:36
// Design Name: 
// Module Name: counter
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module counter(
    input clk,
    input reset,
    output reg [0:4] step
    );
    
reg slowclk;
always @(posedge clk or posedge reset) begin
    if(reset) begin
        slowclk <= 0;
    end
    else begin
    slowclk <= ~slowclk;
    end
end

always @(posedge slowclk) begin
    if(reset) step <= 5'd1;
    else begin
        case(step)
            5'd1: step <= 5'd2;
            5'd2: step <= 5'd4;
            5'd4: step <= 5'd8;
            5'd8: step <= 5'd16;
            5'd16: step <= 5'd1;
            default step <= 5'd1;
        endcase
    end
end

endmodule
