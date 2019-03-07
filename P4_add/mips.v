`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:36:30 11/25/2018 
// Design Name: 
// Module Name:    mips 
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
module mips(
    input clk,
    input reset
    );
	 wire [31:0] INSTR;			//imm_decode
	 wire ALUSRC, REGWRITE, MEMWRITE;
	 wire [1:0] REGDST, MEMTOREG, EXTOP, NPC_SEL;
	 wire [2:0] ALUOP;
	 wire ZERO,BGEZAL_OP,IF_SB,IF_LB;
	 
	 Control Single_CPU_Controller(.instr(INSTR),.regdst(REGDST),.alusrc(ALUSRC),.memtoreg(MEMTOREG),.memwrite(MEMWRITE),.regwrite(REGWRITE),.extop(EXTOP),.aluop(ALUOP),.npc_sel(NPC_SEL),.zero(ZERO),.bgezal_op(BGEZAL_OP),.if_lb(IF_LB),.if_sb(IF_SB));
	 
	 Datapath Single_CPU_Datapath(.Instr(INSTR),.Regdst(REGDST),.Alusrc(ALUSRC),.Memtoreg(MEMTOREG),.Memwrite(MEMWRITE),.Regwrite(REGWRITE),.Extop(EXTOP),.Aluop(ALUOP),.Npc_sel(NPC_SEL),.RESET(reset),.CLK(clk),.Zero(ZERO),.Bgezal_op(BGEZAL_OP),.If_lb(IF_LB),.If_sb(IF_SB));


endmodule
