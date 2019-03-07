`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:04:58 12/16/2018 
// Design Name: 
// Module Name:    CMP 
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
module CMP(
    input [31:0] mfrsd,
    input [31:0] mfrtd,
	 input [31:0] instr,
    output true
    );
	 
	 wire [5:0] op;
	 assign op[5:0]=instr[31:26];
	 wire [5:0] func;
	 assign func[5:0]=instr[5:0];
	 
	 wire beq;
	 assign beq=(op==6'b000100);
	 wire bgezal;
	 assign bgezal=(op==6'b000001);
	 
	 assign true=(beq)?(mfrsd==mfrtd):
					 (bgezal)?(~mfrsd[31]):
					 0;
	 
	 //always@(*)begin
	     //case(cmp_op)
		      //3'b000:true<=(mfrsd==mfrtd);				//beq
				//3'b001:true<=(mfrsd!=mfrtd);				//bne
				//3'b010:true<=(mfrsd==0||mfrsd[31]);		//rs<=0 blez
				//3'b011:true<=(mfrsd!=0&&~mfrsd[31]);	//rs>0 bgtz
				//3'b100:true<=mfrsd[31];						//rs<0 bltz
				//3'b101:true<=~mfrsd[31];					//rs>=0 bgez
		  //endcase
	 //end
	 //(bopal)?((mfrsd+mfrtd==32'b0)&&(mfrsd!=32'h80000000)&&(mfrtd!=32'h80000000))
endmodule
