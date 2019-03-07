`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:09:59 12/16/2018 
// Design Name: 
// Module Name:    Add4 
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
module Add4(
    input [31:0] pc,
    output [31:0] pc4,
    output [31:0] pc8
    );
	 
	 assign pc4=pc+4;
	 assign pc8=pc+8;

endmodule
