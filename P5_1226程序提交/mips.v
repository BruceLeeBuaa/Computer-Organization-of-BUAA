`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:02:45 12/08/2018 
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
	 
	 wire [31:0] INSTR;
	 wire STALL,FRTM,TRUE;
	 wire [1:0] FRSD,FRTD,FRSE,FRTE;
	 wire [4:0] A3;
	 wire ALUSRC,MEMWRITE,REGWRITE,PC_SEL;
	 wire [1:0] MEMTOREG,EXTOP,NPC_SEL;
	 wire [2:0] ALUOP;
	 
	 Controllers Ctrl_pipeline(
	 .Instr(INSTR),
	 .Clk(clk),
	 .Reset(reset),
	 .Stall(STALL),
	 .Frsd(FRSD),
	 .Frtd(FRTD),
	 .Frse(FRSE),
	 .Frte(FRTE),
	 .Frtm(FRTM),
	 .A3(A3),
	 .Alusrc(ALUSRC),
	 .Memtoreg(MEMTOREG),
	 .Memwrite(MEMWRITE),
	 .Regwrite(REGWRITE),
	 .Extop(EXTOP),
	 .Npc_sel(NPC_SEL),
	 .Aluop(ALUOP),
	 .True(TRUE),
	 .Pc_sel(PC_SEL)
	 );
	 
	 Datapath DP_pipeline(
	 .Stall(STALL),
	 .Frsd(FRSD),
	 .Frtd(FRTD),
	 .Frse(FRSE),
	 .Frte(FRTE),
	 .Frtm(FRTM),
	 .A3(A3),
	 .Alusrc(ALUSRC),
	 .Memtoreg(MEMTOREG),
	 .Memwrite(MEMWRITE),
	 .Regwrite(REGWRITE),
	 .Extop(EXTOP),
	 .Npc_sel(NPC_SEL),
	 .Aluop(ALUOP),
	 .Pc_sel(PC_SEL),
	 .True(TRUE),
	 .Clk(clk),
	 .Reset(reset),
	 .Instr(INSTR)
	 );
	 
endmodule
