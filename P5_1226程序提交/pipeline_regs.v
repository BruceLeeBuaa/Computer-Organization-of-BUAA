`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:00:37 12/16/2018 
// Design Name: 
// Module Name:    pipeline_regs 
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
module pipeline_reg_1bit(
    input clk,
    input reset,
    input in,
    output reg out
    );
	 
	 always@(posedge clk)begin
	    if(reset) out<=0;
		 else out<=in;
	 end

endmodule

module pipeline_reg_2bit(
    input clk,
    input reset,
    input [1:0] in,
    output reg [1:0] out
    );
	 
	 always@(posedge clk)begin
	    if(reset) out<=0;
		 else out<=in;
	 end

endmodule

module pipeline_reg_3bit(
    input clk,
    input reset,
    input [2:0] in,
    output reg [2:0] out
    );
	 
	 always@(posedge clk)begin
	    if(reset) out<=0;
		 else out<=in;
	 end

endmodule

module pipeline_reg_5bit(
    input clk,
    input reset,
    input [4:0] in,
    output reg [4:0] out
    );
	 
	 always@(posedge clk)begin
	    if(reset) out<=0;
		 else out<=in;
	 end

endmodule

module pipeline_reg_32bit_en(
	input [31:0] in,
	input clk,
	input reset,
	input en,
	output reg [31:0] out
	);
	
	always@(posedge clk)begin
		if(reset) out<=0;
		else if(en) out<=in;
	end
	
endmodule//D 
	
module pipeline_reg_32bit(
	input [31:0] in,
	input clk,
	input reset,
	output reg [31:0] out
	);
	
	always@(posedge clk)begin
		if(reset) out<=0;
		else out<=in;
	end
	
endmodule 