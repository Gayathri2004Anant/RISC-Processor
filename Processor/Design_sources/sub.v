module subtractor_32_bit(
    input [31:0] A,      
    input [31:0] B,       
    output [31:0] Diff,  
    output BorrowOut     
);

    wire [31:0] B_complement; // Two's complement of B
    wire Cin = 1'b0;        

   
    assign B_complement = ~B + 1;

    thirty_two_bit_add adder (
        .A(A),
        .B(B_complement),
        .c(Cin),
        .Sum(Diff),
        .Cout(BorrowOut)
    );

endmodule
