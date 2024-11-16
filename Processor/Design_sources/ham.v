module two_bit_rca(

	input [1:0] A_n,
	input [1:0] B_n,
	input c,
	output [1:0] Sum_n,
	output Cout_n

	);
	
	wire [2:0] Cin_n;
	
	assign Cin_n[0] = c;
			
	full_adder_struct fa0 (
		.A(A_n[0]),
		.B(B_n[0]),
		.Cin(Cin_n[0]),
		.Cout(Cin_n[1]),
		.Sum(Sum_n[0])
	);
			
	full_adder_struct fa1 (
		.A(A_n[1]),
		.B(B_n[1]),
		.Cin(Cin_n[1]),
		.Cout(Cin_n[2]),
		.Sum(Sum_n[1])
	);
	assign Cout_n = Cin_n[2];
		
endmodule

module three_bit_rca(

	input [2:0] A_n,
	input [2:0] B_n,
	input c,
	output [2:0] Sum_n,
	output Cout_n

	);
	
	wire [3:0] Cin_n;
	
	assign Cin_n[0] = c;
			
	full_adder_struct fa0 (
		.A(A_n[0]),
		.B(B_n[0]),
		.Cin(Cin_n[0]),
		.Cout(Cin_n[1]),
		.Sum(Sum_n[0])
	);
			
	full_adder_struct fa1 (
		.A(A_n[1]),
		.B(B_n[1]),
		.Cin(Cin_n[1]),
		.Cout(Cin_n[2]),
		.Sum(Sum_n[1])
	);

    full_adder_struct fa2 (
		.A(A_n[2]),
		.B(B_n[2]),
		.Cin(Cin_n[2]),
		.Cout(Cin_n[3]),
		.Sum(Sum_n[2])
	);
	assign Cout_n = Cin_n[3];
		
endmodule

module full_adder_struct (
    input A,       
    input B,       
    input Cin,     
    output Sum,    
    output Cout    
);
    wire sum1, carry1, carry2;

    half_adder_struct HA1 (
        .A(A),
        .B(B),
        .Sum(sum1),
        .Carry(carry1)
    );

    half_adder_struct HA2 (
        .A(sum1),
        .B(Cin),
        .Sum(Sum),
        .Carry(carry2)
    );

    or o(Cout, carry1, carry2);

endmodule

module half_adder_struct (
    input A,
    input B,
    output Sum,
    output Carry
);

    wire and_out, xor_out;

    and a(and_out, A, B);   // AND gate for Carry
    xor x(xor_out, A, B);   // XOR gate for Sum

    assign Carry = and_out;
    assign Sum = xor_out;

endmodule

module ham_8_bit(
    input [7:0] A,
    output [7:0] out
);

wire [1:0] fa1_out;
wire [1:0] fa2_out;

wire [2:0] two_bit_rca_out;

assign out[7:4] = 4'b0;

full_adder_struct fa1(
    .A(A[7]),
    .B(A[6]),
    .Cin(A[5]),
    .Sum(fa1_out[0]),
    .Cout(fa1_out[1])
);

full_adder_struct fa2(
    .A(A[4]),
    .B(A[3]),
    .Cin(A[2]),
    .Sum(fa2_out[0]),
    .Cout(fa2_out[1])
);

two_bit_rca two_bit_rca(
    .A_n({fa1_out[1], fa1_out[0]}),
    .B_n({fa2_out[1], fa2_out[0]}),
    .c(A[1]),
    .Sum_n(two_bit_rca_out[1:0]),
    .Cout_n(two_bit_rca_out[2])
);

three_bit_rca three_bit_rca(
    .A_n({two_bit_rca_out[2], two_bit_rca_out[1], two_bit_rca_out[0]}),
    .B_n({1'b0, 1'b0, 1'b0}),
    .c(A[0]),
    .Sum_n(out[2:0]),
    .Cout_n(out[3])
);

endmodule

module ham_32_bit(
    input [31:0] A,
    output [31:0] out
);

wire [7:0] ham_8_bit_out1;
wire [7:0] ham_8_bit_out2;
wire [7:0] ham_8_bit_out3;
wire [7:0] ham_8_bit_out4;

ham_8_bit ham_8_bit1(
    .A(A[31:24]),
    .out(ham_8_bit_out1)
);

ham_8_bit ham_8_bit2(
    .A(A[23:16]),
    .out(ham_8_bit_out2)
);

ham_8_bit ham_8_bit3(
    .A(A[15:8]),
    .out(ham_8_bit_out3)
);

ham_8_bit ham_8_bit4(
    .A(A[7:0]),
    .out(ham_8_bit_out4)
);

wire [31:0] sum1;
wire [31:0] sum2;
wire cout1;
wire cout2;

thirty_two_bit_add adder1(
    .A({24'b0, ham_8_bit_out1}),
    .B({24'b0, ham_8_bit_out2}),
    .c(1'b0),
    .Sum(sum1),
    .Cout(cout1)
);

thirty_two_bit_add adder2(
    .A({24'b0, ham_8_bit_out3}),
    .B({24'b0, ham_8_bit_out4}),
    .c(cout1),
    .Sum(sum2),
    .Cout(cout2)
);

wire cout;

thirty_two_bit_add adder3(
    .A(sum1),
    .B(sum2),
    .c(cout2),
    .Sum(out),
    .Cout(cout)
);

endmodule