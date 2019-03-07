`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:14:03 12/16/2018 
// Design Name: 
// Module Name:    ALU 
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
module ALU(
    input [31:0] A,
    input [31:0] B,
    input [2:0] alu_op,
    output reg [31:0] out
    );
	 
	 always@(*)begin
		case(alu_op)
			3'b000:out<=A+B;
			3'b001:out<=A+~B+1;
			3'b010:out<=A|B;
			3'b011:begin
						out<=A&B;
					 end
			3'b100:out<={31'b0,($signed(A))<($signed(B))};
			3'b101:out<=(B<<A[4:0]);
			3'b110:out<=(($signed(B))>>>(A[4:0]));
			3'b111:begin
						if(A==32'b0)begin
							out<=32;
						end
						else begin
							out<=31-(A[1]+A[2]+A[3]+A[4]+A[5]+A[6]+A[7]+A[8]+A[9]+A[10]+A[11]+A[12]+A[13]+A[14]+A[15]+A[16]+A[17]+A[18]+A[19]+A[20]+A[21]+A[22]+A[23]+A[24]+A[25]+A[26]+A[27]+A[28]+A[29]+A[30]+A[31]);
						end
					 end
		endcase
	 end

endmodule
