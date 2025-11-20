`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/10/23 11:35:02
// Design Name: 
// Module Name: ALU
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


/*
MAPPING
Add     0001
Sub     0010
Sll     0011
slt     0100
sltu    0101
xor     0110
srl     0111
sra     1000
or      1001
and     1010
*/

//ALU

module ALU #(parameter WIDTH = 32)(
    input [WIDTH-1:0] i_data1,
    input [WIDTH-1:0] i_data2,
    input [3:0] alu_control,

    output [WIDTH-1:0] o_data,
    output zero_flag
);

reg [WIDTH-1:0] data;

always @(*) begin
    case(alu_control)
        // add
        4'b0001: data = i_data1 + i_data2;
        
        //sub
        4'b0010: data = i_data1 - i_data2;

        //sll
        4'b0011: data = i_data1 << i_data2;

        //slt
        4'b0100:  data = $signed(i_data1) <  $signed(i_data2) ? 1 : 0;

        //sltu
        4'b0101: data = i_data1 <  i_data2 ? 32'b1 : 32'b0;

        //xor
        4'b0110: data = i_data1 ^ i_data2;

        //srl
        4'b0111: data = i_data1 >> i_data2;

        //sra
        4'b1000: data = i_data1 >>> i_data2;

        //or
        4'b1001: data = i_data1 | i_data2;

        //and
        4'b1010: data = i_data1 & i_data2;

        default: data = 32'b0;
    endcase
end

assign o_data = data;

//zero flag
assign zero_flag = (data == 32'b0) ? 1'b1 : 1'b0;

endmodule
