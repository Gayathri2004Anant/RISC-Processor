`timescale 1ns / 1ps

module cla_4_bit_augmented (
    input [3:0] A,        // 4-bit input A
    input [3:0] B,        // 4-bit input B
    input Cin,            // Carry-in
    output [3:0] Sum,    // 4-bit sum output
    output P_block,
    output G_block
);

    wire [3:0] P;   // Propagate signals
    wire [3:0] G;   // Generate signals
    wire [4:0] C;   // Carry signals (extra bit for C4)

    // Generate and Propagate signals
    assign P = A ^ B;
    assign G = A & B;

    assign P_block = P[0]&P[1]&P[2]&P[3];
    assign G_block = G[3] | (G[2]&P[3]) | (G[1]&P[2]&P[3]) | (G[0]&P[1]&P[2]&P[3]);

    // Carry signals
    assign C[0] = Cin;
    assign C[1] = G[0] | (P[0] & C[0]);
    assign C[2] = G[1] | (P[1] & C[1]);
    assign C[3] = G[2] | (P[2] & C[2]);
    assign C[4] = G[3] | (P[3] & C[3]);

    // Sum outputs
    assign Sum = P ^ C[3:0];

endmodule

`timescale 1ns / 1ps

module cla_16_bit(
    input [15:0] A,
    input [15:0] B,
    input c,
    output [15:0] Sum,
    output Cout,
    output p_out,
    output g_out
);

wire [4:0] Cin;
wire [3:0] P;
wire [3:0] G;


LCU l (
    .P(P),
    .G(G),
    .c(c),
    .C(Cin),
    .P_out(p_out),
    .G_out(g_out)
);

cla_4_bit_augmented c1 (
    .A(A[3:0]),
    .B(B[3:0]),
    .Cin(c),
    .Sum(Sum[3:0]),
    .P_block(P[0]),
    .G_block(G[0])
);

cla_4_bit_augmented c2 (
    .A(A[7:4]),
    .B(B[7:4]),
    .Cin(Cin[1]),
    .Sum(Sum[7:4]),
    .P_block(P[1]),
    .G_block(G[1])
);

cla_4_bit_augmented c3 (
    .A(A[11:8]),
    .B(B[11:8]),
    .Cin(Cin[2]),
    .Sum(Sum[11:8]),
    .P_block(P[2]),
    .G_block(G[2])
);

cla_4_bit_augmented c4 (
    .A(A[15:12]),
    .B(B[15:12]),
    .Cin(Cin[3]),
    .Sum(Sum[15:12]),
    .P_block(P[3]),
    .G_block(G[3])
);

assign Cout = Cin[4];

endmodule

`timescale 1ns / 1ps

module LCU (
    input [3:0] P,
    input [3:0] G,
    input c,
    output [4:0] C,
    output P_out,
    output G_out
);
    assign C[0] = c;

    assign C[1] = G[0] | (P[0] & C[0]);
    assign C[2] = G[1] | (P[1] & C[1]);
    assign C[3] = G[2] | (P[2] & C[2]);
    assign C[4] = G[3] | (P[3] & C[3]);

    assign P_out = P[3] & P[2] & P[1] & P[0];
	assign G_out = G[3] | (P[3] & G[2]) | (P[3] & P[2] & G[1]) | (P[3] & P[2] & P[1] & G[0]);

endmodule

module thirty_two_bit_add(

	input [31:0] A,
	input [31:0] B,
	input c,
	output [31:0] Sum,
	output Cout
	);
	
	wire [1:0] Cin_m;
	wire [1:0] p_out;
    wire [1:0] g_out;
	assign Cin_m[0] = c;
			
	cla_16_bit sixteen_a (
		.A(A[15:0]),
		.B(B[15:0]),
		.c(Cin_m[0]),
		.Cout(Cin_m[1]),
		.Sum(Sum[15:0]),
        .p_out(p_out[0]),
        .g_out(g_out[0])
	);
			
	cla_16_bit sixteen_b (
		.A(A[31:16]),
		.B(B[31:16]),
		.c(Cin_m[1]),
		.Cout(Cout),
		.Sum(Sum[31:16]),
        .p_out(p_out[1]),
        .g_out(g_out[1])
	);
			

endmodule

