`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/10/26 18:33:23
// Design Name: 
// Module Name: Control_Unit
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

//Control Unit
module Control_Unit(
    input [6:0] i_opcode,
    
    // 1bit signal
    output o_regwrite,
    output o_alusrc,
    output o_memread,
    output o_memwrite,
    

    // 2bit signal
    output [1:0] o_memtoreg,
    output [1:0] o_branch,
    output [1:0] o_uidetect,

    // 3bit signal
    output [2:0] o_aluop
);

reg regwrite, alusrc, memread, memwrite, uidetect;
reg [1:0] branch, memtoreg;
reg [2:0] aluop;

always @(*) begin
    case(i_opcode)
        //R-type
        7'b0110011: begin
            regwrite = 1'b1;
            alusrc = 1'b0;
            memread = 1'b0;
            memwrite = 1'b0;
            uidetect = 2'b00;
            memtoreg = 2'b00;
            branch = 2'b00;
            aluop = 3'b000;
        end

        //I-type(Immediate)
        7'b0010011: begin
            regwrite = 1'b1;
            alusrc = 1'b1;
            memread = 1'b0;
            memwrite = 1'b0;
            uidetect = 2'b00;
            memtoreg = 2'b00;
            branch = 2'b00;
            aluop = 3'b010;
        end

        //Load(lw, lh, lb, lhu, lbu)
        7'b0000011: begin
            regwrite = 1'b1;
            alusrc = 1'b1;
            memread = 1'b1;
            memwrite = 1'b0;
            uidetect = 2'b00;
            memtoreg = 2'b01;
            branch = 2'b00;
            aluop = 3'b001;
        end

        //S-type(sw, sb, sh)
        7'b0100011: begin
            regwrite = 1'b0;
            alusrc = 1'b1;
            memread = 1'b0;
            memwrite = 1'b1;
            uidetect = 2'b00;
            memtoreg = 2'b00;
            branch = 2'b00;
            aluop = 3'b001;
        end

        //B-type
        7'b1100011: begin
            regwrite = 1'b0;
            alusrc = 1'b0;
            memread = 1'b0;
            memwrite = 1'b0;
            uidetect = 2'b00;
            memtoreg = 2'b00;
            branch = 2'b01;
            aluop = 3'b011;
        end

        //U-type(lui)
        7'b0110111: begin
            regwrite = 1'b1;
            alusrc = 1'b1;
            memread = 1'b0;
            memwrite = 1'b0;
            uidetect = 2'b10;
            memtoreg = 2'b00;
            branch = 2'b00;
            aluop = 3'b100;
        end

        //U-type(auipc)
        7'b0010111: begin
            regwrite = 1'b1;
            alusrc = 1'b1;
            memread = 1'b0;
            memwrite = 1'b0;
            uidetect = 2'b01;
            memtoreg = 2'b00;
            branch = 2'b00;
            aluop = 3'b100;
        end

        //J-type(jal)
        7'b1101111: begin
            regwrite = 1'b1;
            alusrc = 1'b1;
            memread = 1'b0;
            memwrite = 1'b0;
            uidetect = 2'b00;
            memtoreg = 2'b10;
            branch = 2'b10;
            aluop = 3'b100;
        end

        //I-type(jalr)
        7'b1100111: begin
            regwrite = 1'b1;
            alusrc = 1'b1;
            memread = 1'b0;
            memwrite = 1'b0;
            uidetect = 2'b00;
            memtoreg = 2'b10;
            branch = 2'b10;
            aluop = 3'b100;
        end

        default: begin
            regwrite = 1'b0;
            alusrc = 1'b0;
            memread = 1'b0;
            memwrite = 1'b0;
            uidetect = 2'b00;
            memtoreg = 2'b00;
            branch = 2'b00;
            aluop = 3'b000;
        end

    endcase

end

assign o_regwrite = regwrite;
assign o_alusrc = alusrc;
assign o_memtoreg = memtoreg;
assign o_memread = memread;
assign o_memwrite = memwrite;
assign o_branch = branch;
assign o_aluop = aluop;
assign o_uidetect = uidetect;

endmodule
