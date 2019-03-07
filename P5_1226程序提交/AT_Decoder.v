`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:01:31 12/16/2018 
// Design Name: 
// Module Name:    AT_Decoder 
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
module AT_Decoder(
    input [31:0] instr,
    output [4:0] A1_D,
    output [4:0] A2_D,
    output [4:0] A3_D,
    output [1:0] tnew_E,
	 output [1:0] tnew_M,
    output tuse_rs0,
	 output tuse_rs1,
	 output tuse_rt0,
	 output tuse_rt1
    );
	 
	 wire [5:0] op;
	 assign op[5:0]=instr[31:26];
	 wire [5:0] func;
	 assign func[5:0]=instr[5:0];
	 
	 wire addu;
	 assign addu=((op==6'b000000)&&(func==6'b100001));
	 wire subu;
	 assign subu=((op==6'b000000)&&(func==6'b100011));
	 wire jr;
	 assign jr=((op==6'b000000)&&(func==6'b001000));
	 wire ori;
	 assign ori=(op==6'b001101);
	 wire lw;
	 assign lw=(op==6'b100011);
	 wire sw;
	 assign sw=(op==6'b101011);
	 wire beq;
	 assign beq=(op==6'b000100);
	 wire lui;
	 assign lui=(op==6'b001111);
	 wire jal;
	 assign jal=(op==6'b000011);
	 wire j;
	 assign j=(op==6'b000010);
	 wire jalr;
	 assign jalr=((op==6'b000000)&&(func==6'b001001));
	 wire lb;
	 assign lb=(op==6'b100000);
	 wire bgezal;
	 assign bgezal=(op==6'b000001);
	 //wire bgezalr
	 //assign
	 
	 assign A1_D=instr[25:21];
	 assign A2_D=instr[20:16];
	 assign A3_D=(ori|lw|lui|lb)?(instr[20:16]):			//rt
					  (addu|subu|jalr)?(instr[15:11]):		//rd   |bgezalr
													  31;
	 assign tuse_rs0=(beq|jr|jalr|bgezal);//|bgezalr
	 assign tuse_rs1=(addu|subu|ori|lw|sw|lb);
	 assign tuse_rt0=beq;//|bgezalr
	 assign tuse_rt1=(addu|subu);
  //assign tuse_rt2=sw;
	 
	 assign tnew_E=(lw|lb)?2:(addu|subu|ori|lui)?1:0;
	 assign tnew_M=(lw|lb)?1:0;
	 
endmodule
