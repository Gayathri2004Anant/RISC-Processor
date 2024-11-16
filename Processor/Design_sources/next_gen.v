`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.10.2024 09:20:49
// Design Name: 
// Module Name: next_gen
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


module next_gen(
    input [31:0]a, input[2:0] MUXPC, input[31:0] aluout, input[31:0] npc, output[31:0] nextpc
    );
wire lt;
wire gt;
wire eq;
wire gout;
wire [1:0] sel;
wire [7:0] in;
assign in[7] = 0;
assign in[6] = 0;
assign in[5] = 0;
assign in[4] = gt;
assign in[3] = eq;
assign in[2] = lt;
assign in[1] = 1;
assign in[0] = 0;
assign sel[1] = 0;
assign sel[0] = gout;
comp c(a, lt, eq, gt);
mux8to1 m0(in, MUXPC, gout);
MUX muxpc(npc, aluout, 0, sel, nextpc); 
endmodule
