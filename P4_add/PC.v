`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:11:07 11/28/2018 
// Design Name: 
// Module Name:    PC 
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
module PC(
    input [31:0] npc,
    input clk,
    input reset,
	 output [11:2] iaddr,
    output reg [31:0] pc
    );
	 
	 assign iaddr=pc[11:2];
	 initial begin
		pc<=32'h0000_3000;
	 end
	 always@(posedge clk)begin
		if(reset)begin
			pc<=32'h0000_3000;
		end
		else begin
			pc<=npc;
		end
	 end

endmodule
