`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/10/26 09:39:02
// Design Name: 
// Module Name: Branch_Adder
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

//Branch_Adder
module Branch_Adder #(parameter WIDTH = 32)(
    input [WIDTH-1:0] i_pc,
    input [WIDTH-1:0] i_immediate,
    
    output [WIDTH-1:0] o_address_sum
);

//PC + immediate
assign o_address_sum = i_pc + i_immediate;

endmodule