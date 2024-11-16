`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.10.2024 09:56:14
// Design Name: 
// Module Name: control
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


module control(
input clk, reset,
input [5:0]opcode, input[5:0] func, output LoadPC,ReadIM,LoadNPC,ReadReg, WriteReg, LoadA, LoadB, 
LoadImm1, LoadImm2, LoadALUout, enableDM, WriteDM, LoadLMD,
output [3:0] ALUFunc,
output[1:0] MUXdst, MUXI, MUX1, MUX2, MUXW,
output [2:0] MUXPC ) 
    ;

wire [0:63] inst; 
wire [0:4] step;

counter c(clk, reset, step);
inst_decoder id(opcode, func, inst);
 
wire add_, sub_, and_, or_, xor_, nor_, not_, sl_, srl_, sra_,
inc_, dec_, slt_, sgt_, ham_, move_, cmove_,
addi_, subi_, andi_, ori_, xori_, nori_, noti_, sli_, srli_, srai_,
slti_, sgti_, lui_, hami_,
ld_, st_, bmi_, bpl_, bz_, br_, nop_, halt_;

wire t1, t2, t3, t4, t5;

    assign add_   = inst[0];
    assign sub_   = inst[1];
    assign and_   = inst[2];
    assign or_    = inst[3];
    assign xor_   = inst[4];
    assign nor_   = inst[5];
    assign not_   = inst[6];
    assign sl_    = inst[7];
    assign srl_   = inst[8];
    assign sra_   = inst[9];
    assign inc_   = inst[10];
    assign dec_   = inst[11];
    assign slt_   = inst[12];
    assign sgt_   = inst[13];
    assign ham_   = inst[15];
    assign move_  = inst[16];
    assign cmove_ = inst[17];

    assign addi_  = inst[48];
    assign subi_  = inst[49];
    assign andi_  = inst[50];
    assign ori_   = inst[51];
    assign xori_  = inst[52];
    assign nori_  = inst[53];
    assign noti_  = inst[54];
    assign sli_   = inst[55];
    assign srli_  = inst[56];
    assign srai_  = inst[57];
    assign slti_  = inst[60];
    assign sgti_  = inst[61];
    assign lui_   = inst[62];
    assign hami_  = inst[63];

    assign ld_    = inst[32];
    assign st_    = inst[33];
    assign bmi_   = inst[34];
    assign bpl_   = inst[35];
    assign bz_    = inst[36];
    assign br_    = inst[37];
    assign nop_   = inst[38];
    assign halt_  = inst[39];

    assign t1 = step[4];
    assign t2 = step[3];
    assign t3 = step[2];
    assign t4 = step[1];
    assign t5 = step[0];
    
assign ReadIM = t1;
assign LoadNPC = t1;
assign ReadReg = t2;
assign WriteReg = t5 && !(st_ || bmi_ || bpl_ || bz_ || nop_ || halt_);
assign LoadA = t2;
assign LoadB = t2;
assign LoadImm1 = t2;
assign LoadImm2 = t2;
assign MUXI[0] = t2  && br_;
assign MUXI[1] = 0;
assign MUX1[0] = t3 && ~(bmi_ || bpl_ || bz_ || br_);
assign MUX1[1] = 0;
assign MUX2[1]=0;
assign MUX2[0] = t3 && (add_ || sub_ || and_ || or_ || xor_ || nor_ || not_ || sl_ || srl_ || sra_ || inc_ || dec_ || slt_ || sgt_ || ham_);
genvar i;
for(i = 0; i < 2; i = i+1) begin
    assign ALUFunc[i] = (func[i] && (add_ || sub_ || and_ || or_ || xor_ || nor_ || not_ || sl_ || srl_ || sra_ || inc_ || dec_ || slt_ || sgt_ || ham_)) || 
    (opcode[i] && (addi_ || subi_ || andi_ || ori_ || xori_ || nori_ || noti_ || sli_ || srli_ || srai_ || sgti_ || slti_ || hami_ || lui_))
    ;
end
for(i = 2; i < 4; i = i+1) begin
    assign ALUFunc[i] = (func[i] && (add_ || sub_ || and_ || or_ || xor_ || nor_ || not_ || sl_ || srl_ || sra_ || inc_ || dec_ || slt_ || sgt_ || ham_)) || 
    (opcode[i] && (addi_ || subi_ || andi_ || ori_ || xori_ || nori_ || noti_ || sli_ || srli_ || srai_ || sgti_ || slti_ || hami_ || lui_)) || cmove_
    ;
end 
assign LoadPC = t4;
assign MUXPC[2] = bpl_;
assign MUXPC[1] = bmi_ || bz_;
assign MUXPC[0] = br_ || bz_;
assign LoadALUout = t3;
assign enableDM = t4 && (ld_ || st_);
assign WriteDM = t4&&st_;
assign LoadLMD = t4&&ld_;
assign MUXW[1] = cmove_;
assign MUXW[0] = ld_;
assign MUXdst[1] = t5&&(inc_ || dec_ );
assign MUXdst[0] = (addi_ || subi_ || andi_ || ori_ || xori_ || nori_ || noti_ || sli_ || srli_ || srai_ || sgti_ || slti_ || hami_ || lui_ || ld_) && t5;

endmodule
