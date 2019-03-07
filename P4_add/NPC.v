`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:06:20 11/28/2018 
// Design Name: 
// Module Name:    NPC 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module NPC(
    input [31:0] pc,
    input [25:0] jump_imm,
    input [1:0] npc_sel,
    input [15:0] branch_imm,
    input [31:0] rs_rd1,
    output [31:0] jal_ra,
    output reg [31:0] npc
    );
	 
	 assign jal_ra=pc+4;
	 wire [31:0] branch_signimm;
	 assign branch_signimm=$signed(branch_imm);
	 always@(*)begin
	     case(npc_sel)
		      2'b00:npc<=pc+4;
				2'b01:npc<=pc+4+$signed(branch_signimm<<2);
				2'b10:npc<={pc[31:28],jump_imm,2'b0};
				2'b11:npc<=rs_rd1;
		  endcase
	 end
	 
endmodule
