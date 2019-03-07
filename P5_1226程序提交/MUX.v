`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:12:39 12/17/2018 
// Design Name: 
// Module Name:    MUX 
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
module MUX_32bit_2to1(
    input [31:0] in1,
    input [31:0] in2,
    input op,
    output [31:0] out
    );
	 assign out=(op==0)?in1:in2;

endmodule

module MUX_32bit_4to1(
    input [31:0] in1,
    input [31:0] in2,
	 input [31:0] in3,
	 input [31:0] in4,
    input [1:0] op,
    output [31:0] out
    );
	 assign out=(op==2'b00)?in1:
			      (op==2'b01)?in2:
					(op==2'b10)?in3:
					            in4;

endmodule

