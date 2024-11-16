`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.10.2024 07:11:29
// Design Name: 
// Module Name: ID
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


module ID(input [31:0]inst ,output[5:0]opcode, output [4:0]rs, output[4:0]rt, output[4:0]rd, output[5:0]func, output[15:0]imm1,output[25:0]imm2, output [31:0] iout);
assign opcode = inst[31:26];
assign rs = inst[25:21];
assign rt = inst[20:16];
assign rd = inst[15:11];
assign func = inst[5:0];
assign imm1 = inst[15:0];
assign imm2 = inst[25:0];
assign iout = inst;
endmodule
