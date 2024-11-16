`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.10.2024 06:50:33
// Design Name: 
// Module Name: reg
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


module register(
    input clk,
    input reset,
    input [31:0] in,
    output reg [31:0] out,
    input load
    );
    
always @(posedge clk or posedge reset) begin
    if (reset) begin
        out <= 32'b0; 
    end else if (load) begin
        out <= in; 
    end
end

endmodule
