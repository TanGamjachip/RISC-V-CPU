`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/10/27 16:24:29
// Design Name: 
// Module Name: Jal_Detector
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

//Upper Detector
module Upper_Detector #(parameter WIDTH = 32)(
    input [WIDTH-1:0] i_pc,
    input [WIDTH-1:0] i_register,
    input [1:0] uidetect,

    output [WIDTH-1:0] o_data
);

reg [WIDTH-1:0] data;

always @(*) begin
    case(uidetect)
        //Normal
        2'b00: data = i_register;

        //U-type(auipc)
        2'b01: data = i_pc;

        //U-type(lui)
        2'b10: data = 32'b0;

        default: data = 32'b0;
    endcase
end

assign o_data = data;

endmodule
