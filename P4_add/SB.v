`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:40:10 12/11/2018 
// Design Name: 
// Module Name:    SB 
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
module SB(
    input [31:0] origin,
    input [7:0] new_byte,
    input [1:0] op,
    output reg [31:0] new_word
    );
	 
	 always@(*)begin
		case(op)
			2'b00:new_word<={origin[31:8],new_byte[7:0]};
			2'b01:new_word<={origin[31:16],new_byte[7:0],origin[7:0]};
			2'b10:new_word<={origin[31:24],new_byte[7:0],origin[15:0]};
			2'b11:new_word<={new_byte[7:0],origin[23:0]};
		endcase
	 end

endmodule
