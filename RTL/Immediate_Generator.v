`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/10/25 21:30:34
// Design Name: 
// Module Name: Immediate_Generator
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

//Immediate Generator
module Immediate_Generator #(parameter WIDTH = 32) (
    input [WIDTH-1:0] i_instruction,
    output [WIDTH-1:0] o_immediate
);

reg [WIDTH-1:0] immediate;
wire [6:0] opcode;
wire [2:0] funct3;

always @(*) begin
    case(opcode)
        //I-type
        7'b0010011: begin
            case(funct3)
                3'b001,3'b101: immediate = {27'b0, i_instruction[24:20]};

                default: immediate = {{20{i_instruction[31]}}, i_instruction[31:20]};
                
            endcase
        end

        //load(lw, lh, lhu, lb, lbu)
        7'b0000011: immediate = {{20{i_instruction[31]}}, i_instruction[31:20]};

        //jalr
        7'b1100111: immediate ={{20{i_instruction[31]}}, i_instruction[31:20]};

        //S-type
        7'b0100011: immediate = {{20{i_instruction[31]}}, i_instruction[31:25], i_instruction[11:7]};

        //B-type
        7'b1100011: immediate = {{20{i_instruction[31]}}, i_instruction[7], i_instruction[30:25], i_instruction[11:8], 1'b0};

        //U-type
        7'b0110111, 7'b0010111: immediate = {i_instruction[31:12], 12'b0};

        //J-type
        7'b1101111: immediate ={{12{i_instruction[31]}}, i_instruction[19:12], i_instruction[20], i_instruction[30:21], 1'b0};

        default: immediate = 32'b0;

    endcase

end

assign o_immediate = immediate;
assign funct3 = i_instruction[14:12];
assign opcode = i_instruction[6:0];

endmodule