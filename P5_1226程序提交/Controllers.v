`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:27:00 12/16/2018 
// Design Name: 
// Module Name:    Controllers 
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
module Controllers(
    input [31:0] Instr,
	 input Clk,
	 input Reset,
	 input True,
    output Stall,
    output [1:0] Frsd,
    output [1:0] Frtd,
    output [1:0] Frse,
    output [1:0] Frte,
    output Frtm,
    output [4:0] A3,
    output Alusrc,
    output [1:0] Memtoreg,
    output Memwrite,
    output Regwrite,
    output [1:0] Extop,
    output [1:0] Npc_sel,
    output [2:0] Aluop,
    output Pc_sel
    );
	 //D_decode_AT
	 wire [4:0] A1_D,A2_D,A3_D;
	 wire [1:0] Tnew_D_E,Tnew_D_M;
	 wire Tuse_rs0,Tuse_rs1,Tuse_rt0,Tuse_rt1;
	 
	 AT_Decoder AT(
	 .instr(Instr),
	 .A1_D(A1_D),
	 .A2_D(A2_D),
	 .A3_D(A3_D),
	 .tnew_E(Tnew_D_E),
	 .tnew_M(Tnew_D_M),
	 .tuse_rs0(Tuse_rs0),
	 .tuse_rs1(Tuse_rs1),
	 .tuse_rt0(Tuse_rt0),
	 .tuse_rt1(Tuse_rt1)
	 );
	 //E
	 wire [4:0] A1_E,A2_E,A3_E;
	 wire [1:0] Tnew_E_E,Tnew_E_M;
	 
	 pipeline_reg_5bit RegE_A1(.clk(Clk),.reset(Reset|Stall),.in(A1_D),.out(A1_E));
	 pipeline_reg_5bit RegE_A2(.clk(Clk),.reset(Reset|Stall),.in(A2_D),.out(A2_E));
	 pipeline_reg_5bit RegE_A3(.clk(Clk),.reset(Reset|Stall),.in(A3_D),.out(A3_E));
	 pipeline_reg_2bit RegE_TnewE(.clk(Clk),.reset(Reset|Stall),.in(Tnew_D_E),.out(Tnew_E_E));
	 pipeline_reg_2bit RegE_TnewM(.clk(Clk),.reset(Reset|Stall),.in(Tnew_D_M),.out(Tnew_E_M));
	 
	 //M
	 wire [4:0] A2_M,A3_M;
	 wire [1:0] Tnew_M_M;
	 
	 pipeline_reg_5bit RegM_A2(.clk(Clk),.reset(Reset),.in(A2_E),.out(A2_M));
	 pipeline_reg_5bit RegM_A3(.clk(Clk),.reset(Reset),.in(A3_E),.out(A3_M));
	 pipeline_reg_2bit RegM_TnewM(.clk(Clk),.reset(Reset),.in(Tnew_E_M),.out(Tnew_M_M));
	 
	 //W
	 pipeline_reg_5bit RegW_A3(.clk(Clk),.reset(Reset),.in(A3_M),.out(A3));
	 
	 //D_Control
	 wire Alusrc_D,Memwrite_D,Regwrite_D;
	 wire [1:0] Memtoreg_D;
	 wire [2:0] Aluop_D;
	 
	 main_controller M_Ctrl(
	 .instr(Instr),
	 .alusrc(Alusrc_D),
	 .memtoreg(Memtoreg_D),
	 .memwrite(Memwrite_D),
	 .regwrite(Regwrite_D),
	 .extop(Extop),
	 .npc_sel(Npc_sel),
	 .aluop(Aluop_D),
	 .pc_sel(Pc_sel),
	 .true(True)
	 );
	 
	 //E
	 wire Memwrite_E,Regwrite_E;
	 wire [1:0] Memtoreg_E;
	 wire pcsel_E;
	 
	 pipeline_reg_1bit RegE_Alusrc(.clk(Clk),.reset(Reset|Stall),.in(Alusrc_D),.out(Alusrc));
	 pipeline_reg_3bit RegE_Aluop(.clk(Clk),.reset(Reset|Stall),.in(Aluop_D),.out(Aluop));
	 pipeline_reg_1bit RegE_Memwrite(.clk(Clk),.reset(Reset|Stall),.in(Memwrite_D),.out(Memwrite_E));
	 pipeline_reg_1bit RegE_Regwrite(.clk(Clk),.reset(Reset|Stall),.in(Regwrite_D),.out(Regwrite_E));
	 pipeline_reg_2bit RegE_Memtoreg(.clk(Clk),.reset(Reset|Stall),.in(Memtoreg_D),.out(Memtoreg_E));
	 pipeline_reg_1bit RegE_pcsel(.clk(Clk),.reset(Reset|Stall),.in(Pc_sel),.out(pcsel_E));
	 
	 //M
	 wire Regwrite_M;
	 wire [1:0] Memtoreg_M;
	 wire pcsel_M;
	 
	 pipeline_reg_1bit RegM_Memwrite(.clk(Clk),.reset(Reset),.in(Memwrite_E),.out(Memwrite));
	 pipeline_reg_1bit RegM_Regwrite(.clk(Clk),.reset(Reset),.in(Regwrite_E),.out(Regwrite_M));
	 pipeline_reg_2bit RegM_Memtoreg(.clk(Clk),.reset(Reset),.in(Memtoreg_E),.out(Memtoreg_M));
	 pipeline_reg_1bit RegM_pcsel(.clk(Clk),.reset(Reset),.in(pcsel_E),.out(pcsel_M));
	 
	 //W
	 
	 pipeline_reg_1bit RegW_Regwrite(.clk(Clk),.reset(Reset),.in(Regwrite_M),.out(Regwrite));
	 pipeline_reg_2bit RegW_Memtoreg(.clk(Clk),.reset(Reset),.in(Memtoreg_M),.out(Memtoreg));
	 
	 //Stall_and_Forward
	 
	 Stall_Forward SF(
	 .tuse_rs0(Tuse_rs0),
	 .tuse_rs1(Tuse_rs1),
	 .tuse_rt0(Tuse_rt0),
	 .tuse_rt1(Tuse_rt1),
	 .tnew_E(Tnew_E_E),
	 .tnew_M(Tnew_M_M),
	 .A1_D(A1_D),
	 .A2_D(A2_D),
	 .A1_E(A1_E),
	 .A2_E(A2_E),
	 .A3_E(A3_E),
	 .A2_M(A2_M),
	 .A3_M(A3_M),
	 .A3_W(A3),
	 .regwrite_e(Regwrite_E),
	 .regwrite_m(Regwrite_M),
	 .regwrite_w(Regwrite),
	 .pc_sel_m(pcsel_M),
	 .stall(Stall),
	 .FRSD(Frsd),
	 .FRTD(Frtd),
	 .FRSE(Frse),
	 .FRTE(Frte),
	 .FRTM(Frtm)
	 );
	 
endmodule
