`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.10.2024 07:06:32
// Design Name: 
// Module Name: processor
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


module processor(
    input clk_,
    input rst, 
    output [15:0] LED
    );
wire [31:0] IR_in;
wire [2:0] MUXPC;
wire [1:0]  MUX1, MUX2, MUXI, MUXdst,  MUXW;
wire LoadPC, ReadIM, LoadNPC, read_reg, write_reg, LoadA, LoadB;
wire LoadImm1, LoadImm2;
wire [3:0] ALUFunc;
wire LoadALUOut, enable, writeDM, LoadLMD;
wire [31:0] aout, bout, data_in;
wire [31:0]pc_out, iout;
wire [31:0] pc_in, imm1, imm2, npc_in, npc_out, a, b;
wire [31:0] mux1out, mux2out, muxiout, imm1out, imm2out, i1out, i2out, out, lmdin, lmdout;
wire [31:0] aluout, moveout, nextpc;
wire [4:0] rs, rt, rd, dest;
wire [5:0] opcode, func;
wire [9:0] addri, addrd;
wire clk;

//clockdiv cdiv(clk_, rst, clk);
assign clk = clk_;
control uut(clk,rst,opcode, func, LoadPC, ReadIM, LoadNPC, read_reg, write_reg, LoadA, LoadB, LoadImm1, LoadImm2, LoadALUOut, enable ,writeDM, LoadLMD,
ALUFunc, MUXdst, MUXI, MUX1, MUX2, MUXW, MUXPC);

register PC(clk, rst, pc_in, pc_out, LoadPC);
ROM inst(clk, ReadIM, addri, IR_in);
//ID id(IR_in, opcode, rs, rt, rd, func, imm1, imm2, iout);
inc i(pc_out, npc_in);
register npc(clk, rst, npc_in, npc_out, LoadNPC);
MUX_reg muxdst(rd, rt, rs, MUXdst, dest);
register_bank RB(clk, rs, rt, dest, data_in, rst, read_reg,write_reg, a, b, LED);
register A(clk, rst, a, aout, LoadA);
register B(clk, rst, b, bout, LoadB);
MUX mux1(npc_out, aout, 0, MUX1, mux1out);
MUX mux2(muxiout, bout, 0, MUX2, mux2out);
MUX muxi(i1out, i2out, 0 ,MUXI, muxiout);
register IMM1(clk, rst, imm1out, i1out, LoadImm1);
register IMM2(clk, rst, imm2out, i2out, LoadImm2);
SE1 se1(imm1, imm1out);
SE2 se2(imm2, imm2out);
alu ALU(mux1out,mux2out, ALUFunc, out);
register ALUout(clk, rst, out, aluout, LoadALUOut);
data_mem DM(clk, enable, writeDM, addrd, bout, lmdin);
register LMD(clk, rst, lmdin, lmdout, LoadLMD);
MUX muxw(aluout, lmdout, moveout, MUXW, data_in);
MUX muxmove(bout, aout, 0, aluout, moveout);
next_gen ng(aout, MUXPC,aluout,npc_out,nextpc);
assign addrd = aluout[9:0];
assign pc_in = nextpc;
assign addri = pc_out[9:0];
assign opcode = IR_in[31:26];
assign rs = IR_in[24:21];
assign rt = IR_in[19:16];
assign rd = IR_in[14:11];
assign func = IR_in[5:0];
assign imm1 = IR_in[15:0];
assign imm2 = IR_in[25:0];
assign iout = IR_in;

endmodule
