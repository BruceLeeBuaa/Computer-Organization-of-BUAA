`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:46:22 11/27/2018 
// Design Name: 
// Module Name:    EXT 
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
module EXT(
    input [15:0] imm,
    input [1:0] extop,
    output [31:0] ext_out
    );
	 
	 assign ext_out=(extop==2'b00)?({16'b0,imm}):
			    (extop==2'b01)?({{16{imm[15]}},imm}):
				 (extop==2'b10)?({imm,16'b0}):
				 32'b0;

endmodule
