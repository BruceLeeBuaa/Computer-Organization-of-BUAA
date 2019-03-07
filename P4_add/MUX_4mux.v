`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:41:08 11/28/2018 
// Design Name: 
// Module Name:    MUX_4mux 
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
module MUX_3to1_regdst(
    input [4:0] in1,
    input [4:0] in2,
    input [1:0] op,
    output [4:0] out
    );
	 assign out=(op==2'b00)?in1:
			      (op==2'b01)?in2:
					(op==2'b10)?5'b11111:
					5'b0;
endmodule

module MUX_2to1_alusrc(
    input [31:0] in1,
    input [31:0] in2,
    input op,
    output [31:0] out
    );
	 assign out=(op==0)?in1:in2;

endmodule

module MUX_3to1_memtoreg(
    input [31:0] in1,
    input [31:0] in2,
    input [31:0] in3,
    input [1:0] op,
    output [31:0] out
    );
	 assign out=(op==2'b00)?in1:
			      (op==2'b01)?in2:
					(op==2'b10)?in3:
					32'b0;
endmodule

module MUX_2to1_lb(
    input [31:0] in1,
    input [31:0] in2,
    input op,
    output [31:0] out
    );
	 assign out=(op==0)?in1:in2;

endmodule

module MUX_2to1_sb(
    input [31:0] in1,
    input [31:0] in2,
    input op,
    output [31:0] out
    );
	 assign out=(op==0)?in1:in2;

endmodule
