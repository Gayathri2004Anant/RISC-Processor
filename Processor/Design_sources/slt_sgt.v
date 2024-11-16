module slt(
    input [31:0] A,
    input [31:0] B,
    output [31:0] slt
);

    wire [31:0] Diff;
    wire BorrowOut;

    subtractor_32_bit subtractor (
        .A(A),
        .B(B),
        .Diff(Diff),
        .BorrowOut(BorrowOut)
    );

    assign slt = {31'b0, Diff[31]};

endmodule

module sgt(
    input [31:0] A,
    input [31:0] B,
    output [31:0] sgt
);

    wire [31:0] Diff;
    wire BorrowOut;

    subtractor_32_bit subtractor (
        .A(B),
        .B(A),
        .Diff(Diff),
        .BorrowOut(BorrowOut)
    );

    assign sgt = {31'b0, Diff[31]};

endmodule