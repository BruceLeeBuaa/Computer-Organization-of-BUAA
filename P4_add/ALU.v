`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:45:19 11/26/2018 
// Design Name: 
// Module Name:    ALU 
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
module ALU(
    input [31:0] A,
    input [31:0] B,
    input [2:0] aluop,
	 input [4:0] shift,
    output [31:0] alu_out,
    output zero,
	 output bgezal_op
    );
	 assign alu_out=(aluop==3'b000)?(A+B):
						 (aluop==3'b001)?(A+~B+1):
						 (aluop==3'b010)?(A|B):
						 (aluop==3'b011)?(A&B):
						 (aluop==3'b100)?{31'b0,($signed(A))<($signed(B))}:
						 (aluop==3'b101)?(B<<A[4:0]):
						 (aluop==3'b110)?(B<<shift):
						 (($signed(B))>>>A[4:0]);
	 assign zero=(alu_out==32'b0)?1'b1:1'b0;
	 assign bgezal_op=~A[31];
				
	 //bne=(A!=B);					//bne
	 //blez=(A==0||A[31]);		//rs<=0 blez
	 //bgtz=(A!=0&&~A[31]);	//rs>0 bgtz
	 //bltz=A[31];					//rs<0 bltz
	 
endmodule
