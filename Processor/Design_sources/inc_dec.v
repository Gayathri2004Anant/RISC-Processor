module inc(
    input [31:0] A,
    output [31:0] Sum
);

wire Cout;

thirty_two_bit_add adder (
    .A(A),
    .B(32'b1),
    .c(1'b0),
    .Sum(Sum),
    .Cout(Cout)
);

endmodule

module dec(
    input [31:0] A,
    output [31:0] Sum
);

wire Cout;

subtractor_32_bit subtractor (
    .A(A),
    .B(32'b1),
    .Diff(Sum),
    .BorrowOut(Cout)
);

endmodule