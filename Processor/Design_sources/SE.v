`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.10.2024 07:41:21
// Design Name: 
// Module Name: SE
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


module SE1(input [15:0] in, output [31:0] out);
    assign out[15:0] = in[15:0];           
    assign out[31:16] = {16{in[15]}};     
endmodule


module SE2(input [25:0] in, output [31:0] out);
    assign out[25:0] = in[25:0];           
    assign out[31:26] = {6{in[15]}};     
endmodule   
