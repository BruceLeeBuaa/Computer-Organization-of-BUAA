`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:20:47 11/26/2018 
// Design Name: 
// Module Name:    Datapath 
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
module Datapath(
	 input CLK,
	 input RESET,
    input [1:0] Regdst,
    input Alusrc,
    input [1:0] Memtoreg,
    input Memwrite,
    input Regwrite,
    input [1:0] Extop,
    input [1:0] Npc_sel,
    input [2:0] Aluop,
	 input If_lb,
	 input If_sb,
    output [31:0] Instr,
	 output Zero,
	 output Bgezal_op
    );
	 
	 wire [11:2] PC_IM;
	 wire [31:0] PC_PC4;
    wire [31:0] NPC_PC;
	 wire [31:0] PC_NPC;
	 wire [31:0] RS_RD1;
	 wire [31:0] EXT_ALUSRCMUX;
	 wire [31:0] RD2_ALUSRCMUX_DM;
	 wire [31:0] ALUSRCMUX_ALU;
	 wire [31:0] ALU_MEMTOREGMUX_DM;//[1:0]=lb_op&sb_op
	 wire [31:0] DM_MEMTOREGMUX_LB;
	 wire [31:0] MEMTOREGMUX_LBMUX;
	 wire [31:0] LBMUX_GRF;
	 wire [31:0] SBMUX_DM;
	 wire [31:0] LB_LBMUX;
	 wire [31:0] SB_SBMUX;
	 wire [4:0] REGDSTMUX_GRF;
	 wire [31:0] RD1_NPC_ALU;
	 
	 PC PC(.clk(CLK),.reset(RESET),.npc(NPC_PC),.iaddr(PC_IM),.pc(PC_NPC));	
	 NPC NPC(.pc(PC_NPC),.jump_imm(Instr[25:0]),.npc_sel(Npc_sel),.branch_imm(Instr[15:0]),.rs_rd1(RD1_NPC_ALU),.jal_ra(PC_PC4),.npc(NPC_PC));
	 IM im_4k(.iaddr(PC_IM),.dout(Instr));	 
	 EXT EXT_3choice(.imm(Instr[15:0]),.extop(Extop),.ext_out(EXT_ALUSRCMUX));
	 MUX_2to1_alusrc MUX1(.in1(RD2_ALUSRCMUX_DM),.in2(EXT_ALUSRCMUX),.op(Alusrc),.out(ALUSRCMUX_ALU));
	 MUX_3to1_memtoreg MUX2(.in1(ALU_MEMTOREGMUX_DM),.in2(DM_MEMTOREGMUX_LB),.in3(PC_PC4),.op(Memtoreg),.out(MEMTOREGMUX_LBMUX));
	 MUX_3to1_regdst MUX3(.in1(Instr[20:16]),.in2(Instr[15:11]),.op(Regdst),.out(REGDSTMUX_GRF));
	 MUX_2to1_lb MUX4(.in1(MEMTOREGMUX_LBMUX),.in2(LB_LBMUX),.op(If_lb),.out(LBMUX_GRF));
	 MUX_2to1_sb MUX5(.in1(RD2_ALUSRCMUX_DM),.in2(SB_SBMUX),.op(If_sb),.out(SBMUX_DM));
	 LB LB(.in(DM_MEMTOREGMUX_LB),.op(ALU_MEMTOREGMUX_DM[1:0]),.out(LB_LBMUX));
	 SB SB(.origin(DM_MEMTOREGMUX_LB),.new_byte(RD2_ALUSRCMUX_DM[7:0]),.op(ALU_MEMTOREGMUX_DM[1:0]),.new_word(SB_SBMUX));
	 GRF GRF(.pc(PC_NPC),.A1(Instr[25:21]),.A2(Instr[20:16]),.A3(REGDSTMUX_GRF),.writedata(LBMUX_GRF),.regwrite(Regwrite),.clk(CLK),.reset(RESET),.RD1(RD1_NPC_ALU),.RD2(RD2_ALUSRCMUX_DM));
	 ALU ALU(.A(RD1_NPC_ALU),.B(ALUSRCMUX_ALU),.aluop(Aluop),.alu_out(ALU_MEMTOREGMUX_DM),.zero(Zero),.shift(Instr[10:6]),.bgezal_op(Bgezal_op));
	 DM DM_4k(.pc(PC_NPC),.din(SBMUX_DM),.daddr(ALU_MEMTOREGMUX_DM),.clk(CLK),.reset(RESET),.memwrite(Memwrite),.dout(DM_MEMTOREGMUX_LB));

endmodule
