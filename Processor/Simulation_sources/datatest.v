`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.10.2024 04:31:54
// Design Name: 
// Module Name: datatest
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


module datatest;

reg clk;
reg rst; 
wire [15:0] out;
processor uut(clk, rst, out);

initial begin
    clk = 0;
    forever #2 clk = ~clk;  // Toggle clock every 5 ns
  end

initial begin
    rst=0; 
    #1
    rst=1;
    #2
    rst=0;
    #8000;
end
endmodule
