`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:27:20 11/26/2018 
// Design Name: 
// Module Name:    DM 
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
module DM(
    input [31:0] din,
    input [31:0] daddr,
	 input [31:0] pc,
    input memwrite,
    input clk,
    input reset,
    output [31:0] dout
    );
	 
	 reg [31:0] RAM [1023:0];
	 assign dout=RAM[daddr[11:2]];
	 integer i;
	 always@(posedge clk)begin
		if(reset)begin
			for(i=0;i<=1023;i=i+1)
				RAM[i]<=0;
		end
		else if(memwrite)begin
			RAM[daddr[11:2]]<=din; 
			$display("@%h: *%h <= %h",pc, daddr,din);
		end
	 end

endmodule
