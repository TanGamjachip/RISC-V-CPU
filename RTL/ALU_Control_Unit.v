`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/10/23 14:22:15
// Design Name: 
// Module Name: ALU_Control_Unit
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

// R, I, B, S 구현 완료
module ALU_Control_Unit #(parameter WIDTH = 32)(
    input [2:0] aluop,
    input [6:0] funct7,
    input [2:0] funct3,
    output [3:0] alu_control
    );

reg [3:0] control;

always @(*) begin
    case(aluop)
        //R-type
        3'b000: begin
            case(funct3)
                //add, sub
                3'b000: begin
                    control = funct7[5] ? 4'b0010 : 4'b0001; // sub : add
                end

                //sll
                3'b001: control = 4'b0011;

                //slt
                3'b010: control = 4'b0100;

                //sltu
                3'b011: control = 4'b0101;

                //xor
                3'b100: control = 4'b0110;

                //srl, sra
                3'b101: begin
                    control = funct7[5] ? 4'b1000 : 4'b0111; // sra : srl
                end

                //or
                3'b110: control = 4'b1001;

                //and
                3'b111: control = 4'b1010;

                default: control = 4'b0000;

            endcase
        end

        //Load and Store
        3'b001: control = 4'b0001; // add

        //I-type(Immediate)
        3'b010: begin
            case(funct3)
                //addi
                3'b000: control = 4'b0001;

                //slli
                3'b001: control = 4'b0011;

                //slti
                3'b010: control = 4'b0100;

                //sltiu
                3'b011: control = 4'b0101;

                //xori
                3'b100: control = 4'b0110;

                //srli, srai
                3'b101: begin
                    control = funct7[5] ? 4'b1000 : 4'b0111; // srai : srli
                end

                //ori
                3'b110: control = 4'b1001;

                //andi
                3'b111: control = 4'b1010;

                default: control = 4'b0000;

            endcase
        end

        //B-type
        3'b011: begin
            case(funct3)
                //beq, bne
                3'b000, 3'b001: control = 4'b0010; // sub

                //blt, bge
                3'b100, 3'b101: control = 4'b0100; //slt

                //bltu, bgeu
                3'b110, 3'b111: control = 4'b0101; //sltu

                default: control = 4'b0000;
            endcase
        end

        //U-type, jalr
        3'b100: control = 4'b0001; // add

        default: control = 4'b0000;
    endcase
end

assign alu_control = control;

endmodule
