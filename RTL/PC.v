`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/10/21 15:22:39
// Design Name: 
// Module Name: PC
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

// Program Counter 

module PC #(parameter WIDTH = 32)(
    input clk,
    input a_reset_n,
    input [WIDTH-1:0] i_address,
    output [WIDTH-1:0] o_address
);



reg [WIDTH-1:0] address;

always @(posedge clk or negedge a_reset_n) begin
    if(!a_reset_n) begin
        address <= 32'b0;
    end

    else begin
        address <= i_address;
    end
end

assign o_address = address;

endmodule
