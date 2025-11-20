`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/10/21 19:29:04
// Design Name: 
// Module Name: Register_File
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

//Register_File x0 ~ x31
module Register_File #(parameter WIDTH = 32)(
    input clk,
    input a_reset_n,
    input regwrite,
    input [4:0] i_rs1,
    input [4:0] i_rs2,
    input [4:0] i_rd,
    input [WIDTH-1:0] i_write_data,

    output [WIDTH-1:0] o_data1,
    output [WIDTH-1:0] o_data2
    );

reg [WIDTH-1:0] register [0:WIDTH-1]; //x0 ~ x31

integer i;

always @(posedge clk or negedge a_reset_n) begin
    if(!a_reset_n) begin
        for(i=0; i<32; i=i+1) begin
            register[i] <= 32'd0;
        end
    end

    else if((regwrite == 1) && (i_rd != 0)) begin
        register[i_rd] <= i_write_data;
    end

    else begin
        register[i_rd] <= register[i_rd];
    end
end

assign o_data1 = register[i_rs1];
assign o_data2 = register[i_rs2];

endmodule
