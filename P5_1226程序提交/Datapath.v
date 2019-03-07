`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:32:17 12/16/2018 
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
    input Stall,
    input [1:0] Frsd,
    input [1:0] Frtd,
    input [1:0] Frse,
    input [1:0] Frte,
    input Frtm,
    input [4:0] A3,
    input Alusrc,
    input [1:0] Memtoreg,
    input Memwrite,
    input Regwrite,
    input [1:0] Extop,
    input [1:0] Npc_sel,
    input [2:0] Aluop,
    input Pc_sel,
	 input Clk,
	 input Reset,
	 output True,
    output [31:0] Instr
    );
	 //F
	 wire [31:0] mpc_out,pc_out,IM_D,pc4_out,pc8_out;
	 wire [11:2] PC_IM;
	 wire [31:0] npc_out;//from D
	 
	 PC PC(.npc(mpc_out),.en(~Stall),.clk(Clk),.reset(Reset),.iaddr(PC_IM),.pc(pc_out));
	 IM IM(.iaddr(PC_IM),.dout(IM_D));
	 Add4 PC4_PC8(.pc(pc_out),.pc4(pc4_out),.pc8(pc8_out));
	 MUX_32bit_2to1 MPC(.in1(pc4_out),.in2(npc_out),.op(Pc_sel),.out(mpc_out));
	 
	 //D
	 wire [31:0] pc4_D,pc8_D;
	 pipeline_reg_32bit_en RegD_IR(.in(IM_D),.clk(Clk),.reset(Reset),.en(~Stall),.out(Instr));
	 pipeline_reg_32bit_en RegD_PC4(.in(pc4_out),.clk(Clk),.reset(Reset),.en(~Stall),.out(pc4_D));
	 pipeline_reg_32bit_en RegD_PC8(.in(pc8_out),.clk(Clk),.reset(Reset),.en(~Stall),.out(pc8_D));
	 
	 wire [31:0] memtoreg_mux_out;//from W
	 wire [31:0] RF_RD1,RF_RD2;
	 wire [31:0] pc8_W;//from W
	 GRF GRF(.pc(pc8_W-8),.A1(Instr[25:21]),.A2(Instr[20:16]),.A3(A3),.writedata(memtoreg_mux_out),.regwrite(Regwrite),.clk(Clk),.reset(Reset),.RD1(RF_RD1),.RD2(RF_RD2));
	 
	 wire [31:0] mfrsd_out,mfrtd_out;

	 CMP CMP(.mfrsd(mfrsd_out),.mfrtd(mfrtd_out),.instr(Instr),.true(True));
	 
	 wire [31:0] extout;
	 EXT EXT(.imm(Instr[15:0]),.extop(Extop),.out(extout));
	 NPC NPC(.pc4(pc4_D),.jump_imm(Instr[25:0]),.branch_imm(Instr[15:0]),.npc_sel(Npc_sel),.mfrsd(mfrsd_out),.mfrtd(mfrtd_out),.npc(npc_out));
	 
	 wire [31:0] pc8_M,aluout_M;//from M
	 MUX_32bit_4to1 MFRSD(.in1(RF_RD1),.in2(memtoreg_mux_out),.in3(pc8_M),.in4(aluout_M),.op(Frsd),.out(mfrsd_out));
	 MUX_32bit_4to1 MFRTD(.in1(RF_RD2),.in2(memtoreg_mux_out),.in3(pc8_M),.in4(aluout_M),.op(Frtd),.out(mfrtd_out));
	 
	 //E
	 wire [31:0] v1_E,v2_E,extout_E,pc8_E;
	 pipeline_reg_32bit RegE_V1(.in(mfrsd_out),.clk(Clk),.reset(Reset|Stall),.out(v1_E));
	 pipeline_reg_32bit RegE_V2(.in(mfrtd_out),.clk(Clk),.reset(Reset|Stall),.out(v2_E));
	 pipeline_reg_32bit RegE_extout(.in(extout),.clk(Clk),.reset(Reset|Stall),.out(extout_E));
	 pipeline_reg_32bit RegE_pc8(.in(pc8_D),.clk(Clk),.reset(Reset|Stall),.out(pc8_E));
	 
	 wire [31:0] mfrse_out,mfrte_out,alusrc_mux_out;
	 MUX_32bit_4to1 MFRSE(.in1(v1_E),.in2(memtoreg_mux_out),.in3(pc8_M),.in4(aluout_M),.op(Frse),.out(mfrse_out));
	 MUX_32bit_4to1 MFRTE(.in1(v2_E),.in2(memtoreg_mux_out),.in3(pc8_M),.in4(aluout_M),.op(Frte),.out(mfrte_out));
	 MUX_32bit_2to1 Alusrc_MUX(.in1(mfrte_out),.in2(extout_E),.op(Alusrc),.out(alusrc_mux_out));
	 
	 wire [31:0] aluout;
	 ALU ALU(.A(mfrse_out),.B(alusrc_mux_out),.alu_op(Aluop),.out(aluout));
	 
	 //M
	 wire [31:0] v2_M;
	 pipeline_reg_32bit RegM_aluout(.in(aluout),.clk(Clk),.reset(Reset),.out(aluout_M));
	 pipeline_reg_32bit RegM_V2(.in(mfrte_out),.clk(Clk),.reset(Reset),.out(v2_M));
	 pipeline_reg_32bit RegM_pc8(.in(pc8_E),.clk(Clk),.reset(Reset),.out(pc8_M));
	 
	 wire [31:0] mfrtm_out,dmout,lbout;
	 MUX_32bit_2to1 MFRTM(.in1(v2_M),.in2(memtoreg_mux_out),.op(Frtm),.out(mfrtm_out));
	 DM DM(.din(mfrtm_out),.daddr(aluout_M),.pc(pc8_M-8),.memwrite(Memwrite),.clk(Clk),.reset(Reset),.dout(dmout));
	 LB LB(.in(dmout),.op(aluout_M[1:0]),.out(lbout));
	 
	 //W
	 wire [31:0] aluout_W,dmout_W,lbout_W;
	 pipeline_reg_32bit RegW_aluout(.in(aluout_M),.clk(Clk),.reset(Reset),.out(aluout_W));
	 pipeline_reg_32bit RegW_dmout(.in(dmout),.clk(Clk),.reset(Reset),.out(dmout_W));
	 pipeline_reg_32bit RegW_pc8(.in(pc8_M),.clk(Clk),.reset(Reset),.out(pc8_W));
	 pipeline_reg_32bit RegW_lbout(.in(lbout),.clk(Clk),.reset(Reset),.out(lbout_W));
	 
	 MUX_32bit_4to1 Memtoreg_MUX(.in1(aluout_W),.in2(dmout_W),.in3(pc8_W),.in4(lbout_W),.op(Memtoreg),.out(memtoreg_mux_out));
	 
endmodule
