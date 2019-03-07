`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:11:52 11/27/2018 
// Design Name: 
// Module Name:    GRF 
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
module GRF(
	 input [31:0] pc,
    input [4:0] A1,
    input [4:0] A2,
    input [4:0] A3,
    input [31:0] writedata,
    input regwrite,
    input clk,
    input reset,
    output [31:0] RD1,
    output [31:0] RD2
    );
	 
	 reg [31:0] register [31:0];
	 integer i;
	 assign RD1=register[A1];
	 assign RD2=register[A2];
	 
	 initial begin
		for(i=0;i<32;i=i+1)begin
			register[i]=0;
		end
	 end
	 
	 always@(posedge clk)begin
		if(reset)begin
			for(i=1;i<32;i=i+1)begin
				register[i]=0;
			end	
		end
		else if(regwrite)begin
			if(A3!=5'b0)begin
				register[A3]<=writedata;
				$display("@%h: $%d <= %h", pc, A3,writedata);
			end
		end
	 end

endmodule
