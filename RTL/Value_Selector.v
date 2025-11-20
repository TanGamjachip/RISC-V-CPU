`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/10/26 09:10:57
// Design Name: 
// Module Name: Value_Selector
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

//Value_Selector
module Value_Selector #(parameter WIDTH = 32)(
    input [WIDTH-1:0] i_immediate,
    input [WIDTH-1:0] i_register_file,
    input alusrc,

    output [WIDTH-1:0] o_data
);

reg [WIDTH-1:0] data;

always @(*) begin
    case(alusrc)
        1'b0: data = i_register_file; // ALUSrc = 0: Register_File

        1'b1: data = i_immediate; // ALUSrc = 1: Immediate
    endcase

end

assign o_data = data;

endmodule
