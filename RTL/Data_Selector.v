`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/10/26 18:02:40
// Design Name: 
// Module Name: Data_Selector
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

//Data Selector
module Data_Selector #(parameter WIDTH = 32)(
    input [WIDTH-1:0] i_memory_data,
    input [WIDTH-1:0] i_alu_result,
    input [WIDTH-1:0] i_pc,
    input [1:0] memtoreg,
    
    output [WIDTH-1:0] o_data
);

reg [WIDTH-1:0] data;

always @(*) begin
    case(memtoreg)
        //R-type, I-type, U-type(lui)
        2'b00: data = i_alu_result;

        //Load
        2'b01: data = i_memory_data;

        //J-type, I-type(jalr)
        2'b10: data = i_pc + 32'd4;

        default: data = data;
    endcase
end

assign o_data = data;

endmodule
