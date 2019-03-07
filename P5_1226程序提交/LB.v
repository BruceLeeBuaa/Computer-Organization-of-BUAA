`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:20:26 12/17/2018 
// Design Name: 
// Module Name:    LB 
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
module LB(
    input [31:0] in,
    input [1:0] op,
    output reg [31:0] out
    );
	 
	 always@(*)begin
		case(op)
			2'b00:out<={{24{in[7]}},in[7:0]};
			2'b01:out<={{24{in[15]}},in[15:8]};
			2'b10:out<={{24{in[23]}},in[23:16]};
			2'b11:out<={{24{in[31]}},in[31:24]};
		endcase
	 end

endmodule
