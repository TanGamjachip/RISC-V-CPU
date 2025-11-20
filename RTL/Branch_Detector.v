`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/10/26 18:16:30
// Design Name: 
// Module Name: Branch_Detector
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

//Branch Detector
module Branch_Detector #(parameter WIDTH = 32)(
    input [1:0] branch,
    input [2:0] i_funct3,
    input i_zero_flag,
    output [1:0] o_pcsrc
);

reg [1:0] pcsrc;

always @(*) begin
    case(branch)
        // B-type
        2'b01: begin
            case(i_funct3)
                //beq
                3'b000: pcsrc = i_zero_flag ? 2'b01 : 2'b00;

                //bne
                3'b001: pcsrc = i_zero_flag ? 2'b00 : 2'b01;

                //blt
                3'b100: pcsrc = i_zero_flag ? 2'b01 : 2'b00;

                //bge
                3'b101: pcsrc = i_zero_flag ? 2'b00 : 2'b01;

                //bltu
                3'b110: pcsrc = i_zero_flag ? 2'b01 : 2'b00;

                //bgeu
                3'b111: pcsrc = i_zero_flag ? 2'b00 : 2'b01;

                default: pcsrc = 2'b00;

            endcase
        end

        //J-type
        2'b10: begin
            pcsrc = 2'b10;
        end

        //I-type(Jalr)
        2'b11: begin
            pcsrc = 2'b11;
        end

        default: pcsrc = 2'b00;

    endcase

end

assign o_pcsrc = pcsrc;

endmodule
