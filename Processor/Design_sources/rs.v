module right_shift(input [31:0] in1, input [31:0] in2, output [31:0] out);
		wire [31:0] temp [31:0];

		genvar i;
		assign temp[0] = in1;
		generate
			for(i = 1; i<32; i = i+1) begin
				assign temp[i][31-i:0] = in1[31:i];
				assign temp[i][31:31-i+1] = 0;
			end
		endgenerate

		generate
			for(i = 0; i<32; i = i+1) begin
				mux32to1 m0({temp[31][i], temp[30][i], temp[29][i], temp[28][i], temp[27][i], temp[26][i], temp[25][i], temp[24][i], temp[23][i], temp[22][i], temp[21][i], temp[20][i], temp[19][i], temp[18][i], temp[17][i], temp[16][i], temp[15][i], temp[14][i], temp[13][i], temp[12][i], temp[11][i], temp[10][i], temp[9][i], temp[8][i], temp[7][i], temp[6][i], temp[5][i], temp[4][i], temp[3][i], temp[2][i], temp[1][i], temp[0][i]}, in2[4:0], out[i]);
			end
		endgenerate

endmodule