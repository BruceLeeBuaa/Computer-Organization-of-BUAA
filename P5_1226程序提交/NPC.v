`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:36:37 12/16/2018 
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
    input [31:0] pc4,
    input [25:0] jump_imm,
    input [15:0] branch_imm,
    input [1:0] npc_sel,
    input [31:0] mfrsd,
	 input [31:0] mfrtd,
    output reg [31:0] npc
    );
	 
	 wire [31:0] branch_signimm;
	 assign branch_signimm=$signed(branch_imm);
	 always@(*)begin
	     case(npc_sel)
		      2'b00:npc<=mfrtd;
				2'b01:npc<=pc4+$signed(branch_signimm<<2);
				2'b10:npc<={pc4[31:28],jump_imm,2'b0};
				2'b11:npc<=mfrsd;
		  endcase
	 end

endmodule
