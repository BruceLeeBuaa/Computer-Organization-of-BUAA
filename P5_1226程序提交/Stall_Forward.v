`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:36:39 12/16/2018 
// Design Name: 
// Module Name:    Stall_Forward 
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
module Stall_Forward(
    input tuse_rs0,
    input tuse_rs1,
    input tuse_rt0,
    input tuse_rt1,
    input [1:0] tnew_E,
    input [1:0] tnew_M,
    input [4:0] A1_D,
    input [4:0] A2_D,
    input [4:0] A1_E,
    input [4:0] A2_E,
	 input [4:0] A3_E,
    input [4:0] A2_M,
    input [4:0] A3_M,
    input [4:0] A3_W,
	 input regwrite_e,
    input regwrite_m,
    input regwrite_w,
	 input pc_sel_m,		//0:shunxu 1:jump;branch;
    output stall,
    output [1:0] FRSD,
    output [1:0] FRTD,
    output [1:0] FRSE,
    output [1:0] FRTE,
    output FRTM
    );
	 //Stall
	 wire stall_rs0_e1;
	 wire stall_rs0_e2;
	 wire stall_rs1_e2;
	 wire stall_rs0_m1;
	 wire stall_rt0_e1;
	 wire stall_rt0_e2;
	 wire stall_rt1_e2;
	 wire stall_rt0_m1;
	 wire stall_rs;
	 wire stall_rt;
	 
	 assign stall_rs0_e1=tuse_rs0&(tnew_E==2'b01)&(A1_D==A3_E)&regwrite_e;
	 assign stall_rs0_e2=tuse_rs0&(tnew_E==2'b10)&(A1_D==A3_E)&regwrite_e;
	 assign stall_rs1_e2=tuse_rs1&(tnew_E==2'b10)&(A1_D==A3_E)&regwrite_e;
	 assign stall_rs0_m1=tuse_rs0&(tnew_M==2'b01)&(A1_D==A3_M)&regwrite_m;
	 
	 assign stall_rt0_e1=tuse_rt0&(tnew_E==2'b01)&(A2_D==A3_E)&regwrite_e;
	 assign stall_rt0_e2=tuse_rt0&(tnew_E==2'b10)&(A2_D==A3_E)&regwrite_e;
	 assign stall_rt1_e2=tuse_rt1&(tnew_E==2'b10)&(A2_D==A3_E)&regwrite_e;
	 assign stall_rt0_m1=tuse_rt0&(tnew_M==2'b01)&(A2_D==A3_M)&regwrite_m;
	 
	 assign stall_rs=stall_rs0_e1|stall_rs0_e2|stall_rs1_e2|stall_rs0_m1;
	 assign stall_rt=stall_rt0_e1|stall_rt0_e2|stall_rt1_e2|stall_rt0_m1;
	 
	 assign stall=stall_rs|stall_rt;
	 //Forward
	 assign FRSD=((A1_D==A3_M)&(regwrite_m==1)&(tnew_M==2'b00)&(A3_M!=0)&(pc_sel_m==0))?3:
					 ((A1_D==A3_M)&(regwrite_m==1)&(tnew_M==2'b00)&(A3_M!=0)&(pc_sel_m==1))?2:
														  ((A1_D==A3_W)&(regwrite_w==1)&(A3_W!=0))?1:
																												 0;
	 assign FRTD=((A2_D==A3_M)&(regwrite_m==1)&(tnew_M==2'b00)&(A3_M!=0)&(pc_sel_m==0))?3:
					 ((A2_D==A3_M)&(regwrite_m==1)&(tnew_M==2'b00)&(A3_M!=0)&(pc_sel_m==1))?2:
														  ((A2_D==A3_W)&(regwrite_w==1)&(A3_W!=0))?1:
																												 0;
	 assign FRSE=((A1_E==A3_M)&(regwrite_m==1)&(tnew_M==2'b00)&(A3_M!=0)&(pc_sel_m==0))?3:
					 ((A1_E==A3_M)&(regwrite_m==1)&(tnew_M==2'b00)&(A3_M!=0)&(pc_sel_m==1))?2:
														  ((A1_E==A3_W)&(regwrite_w==1)&(A3_W!=0))?1:
																												 0;
	 assign FRTE=((A2_E==A3_M)&(regwrite_m==1)&(tnew_M==2'b00)&(A3_M!=0)&(pc_sel_m==0))?3:
					 ((A2_E==A3_M)&(regwrite_m==1)&(tnew_M==2'b00)&(A3_M!=0)&(pc_sel_m==1))?2:
														  ((A2_E==A3_W)&(regwrite_w==1)&(A3_W!=0))?1:
																												 0;
	 assign FRTM=((A2_M==A3_W)&(regwrite_w==1)&(A3_W!=0))?1:0;
		
endmodule
