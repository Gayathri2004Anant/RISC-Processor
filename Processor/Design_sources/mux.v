`timescale 1ns / 1ps

module mux2to1(input [1:0]in, input select, output out
    );
wire t1;
wire t2;
wire t3;
not n(t3, select);
and a(t1, in[1], select);
and b(t2, in[0], t3);
or o(out, t1, t2);

endmodule

module mux4to1(input [3:0]in, input[1:0] select, output out
    );
wire t1;
wire t2;
mux2to1 a(in[3:2], select[0], t1);
mux2to1 b(in[1:0], select[0], t2);
mux2to1 c({t1,t2}, select[1], out);
endmodule

module mux8to1(input [7:0]in, input[2:0] select, output out
    );
//wire t1;
//wire t2;
//mux4to1 a(in[7:4], select[1:0], t1);
//mux4to1 b(in[3:0], select[1:0], t2);
//mux2to1 c({t1,t2}, select[2], out);
assign out = in[select];
endmodule

module mux16to1(input [15:0]in, input[3:0] select, output out
    );

wire t1;
wire t2;
mux8to1 a(in[15:8], select[2:0], t1);
mux8to1 b(in[7:0], select[2:0], t2);
mux2to1 c({t1,t2}, select[3], out);
endmodule

module mux32to1(input [31:0]in, input[4:0] select, output out
    );
wire t1;
wire t2;
mux16to1 a(in[31:16], select[3:0], t1);
mux16to1 b(in[15:0], select[3:0], t2);
mux2to1 c({t1,t2}, select[4], out);
endmodule

module MUX (input [31:0] in0, in1, in2, input[1:0] sel, output[31:0]out);
    genvar i;
    for(i = 0; i < 32; i = i+1) begin
        mux4to1 m0({0, in2[i], in1[i], in0[i]}, sel, out[i]);
    end
endmodule

module MUX_reg(input[4:0] in0, in1, in2, input[1:0] sel, output[4:0]out);
    genvar i;
    for(i = 0; i < 5; i = i+1) begin
        mux4to1 m0({0, in2[i], in1[i], in0[i]}, sel, out[i]);
    end
endmodule
