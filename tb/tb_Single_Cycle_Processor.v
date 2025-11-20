`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/11/05 10:48:49
// Design Name: 
// Module Name: tb_Single_Cycle_Processor
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


module tb_Single_Cycle_Processor();
localparam WIDTH = 32;

reg tb_clk, tb_a_reset_n;

wire tb_o_done;
wire [3:0] tb_o_cycle;

always #5 tb_clk = ~tb_clk;

initial begin
    tb_clk = 0; tb_a_reset_n = 1;

    #10 tb_a_reset_n = 0;

    #10 tb_a_reset_n = 1;

    #300 $finish;
end

Top_Processor DUT_Top_Processor(.clk(tb_clk),
                                .a_reset_n(tb_a_reset_n),
                                .o_done(tb_o_done),
                                .o_cycle(tb_o_cycle)
                                );
                                                  
endmodule
