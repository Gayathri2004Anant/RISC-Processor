`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.10.2024 04:31:14
// Design Name: 
// Module Name: decoder
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


module inst_decoder(

    input [5:0] opcode, 
    input [5:0] func,
    output [0:63] inst
    );
 
    wire [5:0] idx;
    assign idx = opcode | (func & {6{~opcode[5]}});
    
    decoder d(idx, inst);

endmodule

module decoder(
    input [5:0] in,
    output reg [0:63] out );

    always @(*) begin
        out = 64'b0;
        out[in] = 1'b1;
    end

endmodule
