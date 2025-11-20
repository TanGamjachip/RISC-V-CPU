`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/10/26 18:10:42
// Design Name: 
// Module Name: Address_Selector
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

//Address Selector
module Address_Selector #(parameter WIDTH = 32)(
    input [WIDTH-1:0] i_pc_address,
    input [WIDTH-1:0] i_branch_address,
    input [WIDTH-1:0] i_jalr_address,
    input [1:0] pcsrc,
    
    output [WIDTH-1:0] o_address,
    output [WIDTH-1:0] o_mem_address
);

reg [WIDTH-1:0] address;

always @(*) begin
    case(pcsrc)
        //no branch: PC + 4
        2'b00: address = i_pc_address + 32'd4;
        
        //B-type, J-type: PC + immediate
        2'b01, 2'b10: address = i_branch_address;
        
        //I-type(jalr): rs1 + immediate
        2'b10: address = i_jalr_address;

    endcase

end

assign o_address = address;
assign o_mem_address = address >> 2;

endmodule
