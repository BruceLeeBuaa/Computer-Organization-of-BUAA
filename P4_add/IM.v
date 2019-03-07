`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:40:06 11/26/2018 
// Design Name: 
// Module Name:    IM 
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
module IM(
    input [11:2] iaddr,
    output reg [31:0] dout
    );
	 reg [31:0] ROM [1023:0];
	 initial begin
		$readmemh("code.txt",ROM);
	 end
	 always@(iaddr)begin
		dout<=ROM[iaddr];
	 end
	 
endmodule
