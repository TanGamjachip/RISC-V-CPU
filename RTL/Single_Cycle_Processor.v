`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/11/04 18:19:11
// Design Name: 
// Module Name: Single_Cycle_Processor
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


module Single_Cycle_Processor #(parameter WIDTH = 32)(
    input clk,
    input a_reset_n,

    //instruction
    input [WIDTH-1:0] sc_i_instruction,
    
    //address
    output [WIDTH-1:0] sc_o_address
);

//PC module Instanciation
wire [WIDTH-1:0] sc_pc_o_address, sc_pc_i_address;

PC SC_PC(
        .clk(clk), 
        .a_reset_n(a_reset_n), 
        .i_address(sc_pc_i_address), 
        .o_address(sc_pc_o_address)
        );

//Control_Unit module Instanciation
wire sc_o_regwrite, sc_o_alusrc, sc_o_memread, sc_o_memwrite;
wire [1:0] sc_o_memtoreg, sc_o_branch, sc_o_uidetect;
wire [2:0] sc_o_aluop;

Control_Unit SC_Control_Unit(
                            .i_opcode(sc_i_instruction[6:0]),
                            .o_regwrite(sc_o_regwrite),
                            .o_alusrc(sc_o_alusrc),
                            .o_memread(sc_o_memread),
                            .o_memwrite(sc_o_memwrite),
                            .o_memtoreg(sc_o_memtoreg),
                            .o_branch(sc_o_branch),
                            .o_uidetect(sc_o_uidetect),
                            .o_aluop(sc_o_aluop)
                            );

//Register_File module Instanciation
wire [WIDTH-1:0] sc_rf_i_write_data;
wire [WIDTH-1:0] sc_rf_o_data1, sc_rf_o_data2;

Register_File SC_Register_File(.clk(clk),
                               .a_reset_n(a_reset_n),
                               .regwrite(sc_o_regwrite),
                               .i_rs1(sc_i_instruction[19:15]),
                               .i_rs2(sc_i_instruction[24:20]),
                               .i_rd(sc_i_instruction[11:7]),
                               .i_write_data(sc_rf_i_write_data),
                               .o_data1(sc_rf_o_data1),
                               .o_data2(sc_rf_o_data2)
                               );

//Immediate_Generator module Instanciation
wire [WIDTH-1:0] sc_ig_o_immediate;

Immediate_Generator SC_Immediate_Generator(
                                           .i_instruction(sc_i_instruction),
                                           .o_immediate(sc_ig_o_immediate)
                                           );
                                           

//Upper_Selector module Instanciation
wire [WIDTH-1:0] sc_ud_o_data;

Upper_Detector SC_Upper_Detector(.i_pc(sc_pc_o_address),
                                 .i_register(sc_rf_o_data1),
                                 .uidetect(sc_o_uidetect),
                                 .o_data(sc_ud_o_data)
                                 );

//Value_Selector module Instanciation
wire [WIDTH-1:0] sc_vs_o_data;

Value_Selector SC_Value_Selector(.i_immediate(sc_ig_o_immediate),
                                 .i_register_file(sc_rf_o_data2),
                                 .alusrc(sc_o_alusrc),
                                 .o_data(sc_vs_o_data)
                                 );

//Branch_Adder module Instanciation
wire [WIDTH-1:0] sc_ba_o_address;

Branch_Adder SC_Branch_Adder(.i_pc(sc_pc_o_address),
                             .i_immediate(sc_ig_o_immediate),
                             .o_address_sum(sc_ba_o_address)
                             );

//ALU_Control_Unit module Instanciation
wire [3:0] sc_acu_alu_control;

ALU_Control_Unit SC_ALU_Control_Unit(.aluop(sc_o_aluop),
                 .funct3(sc_i_instruction[14:12]),
                 .funct7(sc_i_instruction[31:25]),
                 .alu_control(sc_acu_alu_control)
                 );

//ALU module Instanciation
wire [WIDTH-1:0] sc_alu_o_data;
wire sc_alu_zero_flag;

ALU SC_ALU(.i_data1(sc_ud_o_data),
           .i_data2(sc_vs_o_data),
           .alu_control(sc_acu_alu_control),
           .o_data(sc_alu_o_data),
           .zero_flag(sc_alu_zero_flag)
           );

//Branch_Detector module Instanciation
wire [1:0] sc_bd_o_pcsrc;

Branch_Detector SC_Branch_Detector(.branch(sc_o_branch),
                .i_funct3(sc_i_instruction[14:12]),
                .i_zero_flag(sc_alu_zero_flag),
                .o_pcsrc(sc_bd_o_pcsrc)
                );

//Data_Memory module Instanciation
wire [WIDTH-1:0] sc_dm_o_data;

Data_Memory SC_Data_Memory(.clk(clk),
                           .a_reset_n(a_reset_n),
                           .i_address(sc_alu_o_data),
                           .i_data(sc_rf_o_data2),
                           .memread(sc_o_memread),
                           .memwrite(sc_o_memwrite),
                           .funct3(sc_i_instruction[14:12]),
                           .o_data(sc_dm_o_data)
                           );

//Data_Selector module Instanciation
wire[WIDTH-1:0] sc_ds_o_data;

Data_Selector SC_Data_Selector(.i_memory_data(sc_dm_o_data),
                               .i_alu_result(sc_alu_o_data),
                               .i_pc(sc_pc_o_address),
                               .memtoreg(sc_o_memtoreg),
                               .o_data(sc_ds_o_data)
                               );

//Address_Selector module Instanciation
Address_Selector SC_Address_Selector(.i_pc_address(sc_pc_o_address),
                                     .i_branch_address(sc_ba_o_address),
                                     .i_jalr_address(sc_alu_o_data),
                                     .pcsrc(sc_bd_o_pcsrc),
                                     .o_address(sc_pc_i_address),
                                     .o_mem_address(sc_o_address)
                                     );


assign read_enable = 1'b1;

endmodule
