`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/11/05 11:19:49
// Design Name: 
// Module Name: Top_Processor
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


module Top_Processor #(parameter WIDTH = 32)(
    input clk,
    input a_reset_n,
    output o_done,
    output [3:0] o_cycle  // cycle / 1000
);

reg [15:0] cycle;
wire [WIDTH-1:0] top_instruction, top_address;

//clock cycle counter
always @(posedge clk or negedge a_reset_n) begin
    if(!a_reset_n) begin
        cycle <= 0;
    end

    else if(o_done) begin
        cycle <= cycle;
    end

    else cycle <= cycle + 1'b1;
end

Single_Cycle_Processor Top_SCP(.clk(clk),
                               .a_reset_n(a_reset_n),
                               .sc_i_instruction(top_instruction),
                               .sc_o_address(top_address)
                               );

Instruction_Memory_async Top_IM(.i_address(top_address),
                                .o_instruction(top_instruction)
                                );

assign o_cycle = cycle[3:0];
assign o_done = (top_instruction == 32'h0000_0000) ? 1'b1: 1'b0;

endmodule
