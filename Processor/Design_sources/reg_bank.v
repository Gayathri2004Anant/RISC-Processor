`timescale 1ns / 1ps

module register_bank(
	input clk,
	input [3:0]src1,
	input [3:0]src2,
	input [3:0]dst,
	input [31:0] Z,
	input reset,
    input read_strobe,
    input write_strobe,
	output reg[31:0]A,
	output reg[31:0]B,
	output reg[15:0] out
    );
    
    reg [31:0]rout[0:15];
	always @(posedge clk or posedge reset) begin
	     if(reset) begin
				rout[0]  <= 32'd0;  
                rout[1]  <= 32'd0; 
                rout[2]  <= 32'd0; 
                rout[3]  <= 32'd0; 
                rout[4]  <= 32'd0;  
                rout[5]  <= 32'd0; 
                rout[6]  <= 32'd0; 
                rout[7]  <= 32'd0; 
                rout[8]  <= 32'd0;  
                rout[9]  <= 32'd0; 
                rout[10]  <= 32'd0; 
                rout[11]  <= 32'd0; 
                rout[12]  <= 32'd0;  
                rout[13]  <= 32'd0; 
                rout[14]  <= 32'd0; 
                rout[15]  <= 32'd0;  
			end
        else if(read_strobe) begin
            case(src1)
            4'b0000: A <= rout[0];
            4'b0001:  A <= rout[1];
            4'b0010:  A <= rout[2];
            4'b0011:  A <= rout[3];
            4'b0100:  A <= rout[4];
            4'b0101:  A <= rout[5];
            4'b0110:  A <= rout[6];
            4'b0111:  A <= rout[7];
            4'b1000:  A <= rout[8];
            4'b1001:  A <= rout[9];
            4'b1010:  A <= rout[10];
            4'b1011:  A <= rout[11];
            4'b1100:  A <= rout[12];
            4'b1101:  A <= rout[13];
            4'b1110:  A <= rout[14];
            4'b1111:  A <= rout[15];
            
            default: A <= 32'b0;
            endcase
            case(src2)
            4'b0000: B <= rout[0];
            4'b0001:  B <= rout[1];
            4'b0010:  B <= rout[2];
            4'b0011:  B <= rout[3];
            4'b0100:  B <= rout[4];
            4'b0101:  B <= rout[5];
            4'b0110:  B <= rout[6];
            4'b0111:  B <= rout[7];
            4'b1000:  B <= rout[8];
            4'b1001:  B <= rout[9];
            4'b1010:  B <= rout[10];
            4'b1011:  B <= rout[11];
            4'b1100:  B <= rout[12];
            4'b1101:  B <= rout[13];
            4'b1110:  B <= rout[14];
            4'b1111:  B <= rout[15];
            
            default: B <= 32'b0;
            endcase
        end
        else if(write_strobe) begin
            
            case(dst)
            4'b0000: rout[0] <= 32'd0;
            4'b0001: begin
            rout[1] <= Z;
            out <= Z[15:0];
            end
            4'b0010: rout[2] <= Z;
            4'b0011: rout[3] <= Z;
            4'b0100: rout[4] <= Z;
            4'b0101: rout[5] <= Z;
            4'b0110: rout[6] <= Z;
            4'b0111: rout[7] <= Z;
            4'b1000: rout[8] <= Z;
            4'b1001: rout[9] <= Z;
            4'b1010: rout[10] <= Z;
            4'b1011: rout[11] <= Z;
            4'b1100: rout[12] <= Z;
            4'b1101: rout[13] <= Z;
            4'b1110: rout[14] <= Z;
            4'b1111: rout[15] <= Z;
            endcase
        end
        else begin
        end
	end

endmodule