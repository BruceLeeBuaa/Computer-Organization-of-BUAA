`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:08:52 11/26/2018 
// Design Name: 
// Module Name:    Control 
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
module Control(
	 input [31:0] instr,
	 input zero,
	 input bgezal_op,
    output reg [1:0] regdst,
    output reg alusrc,
    output reg [1:0] memtoreg,
    output reg memwrite,
    output reg regwrite,
    output reg [1:0] extop,
    output reg [1:0] npc_sel,
    output reg [2:0] aluop,
	 output reg if_lb,
	 output reg if_sb
	 );
	 
	 `define R_type 6'b000000
	 `define addu 6'b100001
	 `define subu 6'b100011
	 `define jr 6'b001000
	 `define ori 6'b001101
	 `define lw 6'b100011
	 `define sw 6'b101011
	 `define beq 6'b000100
	 `define lui 6'b001111
	 `define jal 6'b000011
	 `define bgezal 6'b000001
	 `define slti 6'b001010
	 `define lb 6'b100000
	 `define sb 6'b101000
	 
	 wire [5:0] op;
	 assign op[5:0]=instr[31:26];
	 wire [5:0] func;
	 assign func[5:0]=instr[5:0];
	 
	 initial begin
		regdst<=2'b00;
		alusrc<=0;
		memtoreg<=2'b00;
		memwrite<=0;
		regwrite<=0;
		extop<=2'b00;
		npc_sel<=2'b00;
		aluop<=3'b000;
		if_lb<=0;
		if_sb<=0;
	 end
	 always@(op,func,zero,bgezal_op)begin
	     case(op)
			   `R_type:begin
							 case(func)
				            `addu:begin
										   regdst<=2'b01;
										   alusrc<=0;
											memtoreg<=2'b00;
											memwrite<=0;
											regwrite<=1;
											extop<=2'b00;
										   npc_sel<=2'b00;
										   aluop<=3'b000;
											if_lb<=0;
											if_sb<=0;
										end
								`subu:begin
											regdst<=2'b01;
											alusrc<=0;
											memtoreg<=2'b00;
											memwrite<=0;
											regwrite<=1;
											extop<=2'b00;
										   npc_sel<=2'b00;
										   aluop<=3'b001;
											if_lb<=0;
											if_sb<=0;
										end
								  `jr:begin
											regdst<=2'b00;
											alusrc<=0;
											memtoreg<=2'b00;
											memwrite<=0;
											regwrite<=0;
											extop<=2'b00;
										   npc_sel<=2'b11;
										   aluop<=3'b000;
											if_lb<=0;
											if_sb<=0;
										end
							     	default:begin//nop
												 regdst<=2'b00;
												 alusrc<=0;
												 memtoreg<=2'b00;
												 memwrite<=0;
												 regwrite<=0;
												 extop<=2'b00;
												 npc_sel<=2'b00;
												 aluop<=3'b000;
												 if_lb<=0;
												 if_sb<=0;
											  end	  
							endcase
						 end
					  `ori:begin
							     regdst<=2'b00;
								  alusrc<=1;
				   			  memtoreg<=2'b00;
								  memwrite<=0;
								  regwrite<=1;
								  extop<=2'b00;
								  npc_sel<=2'b00;
								  aluop<=3'b010;
								  if_lb<=0;
								  if_sb<=0;
							 end
						`lw:begin
				             regdst<=2'b00;
								 alusrc<=1;
				   			 memtoreg<=2'b01;
								 memwrite<=0;
								 regwrite<=1;
								 extop<=2'b01;
								 npc_sel<=2'b00;
								 aluop<=3'b000;
								 if_lb<=0;
								 if_sb<=0;
							 end
						`sw:begin
				             regdst<=2'b00;
								 alusrc<=1;
								 memtoreg<=2'b00;
								 memwrite<=1;
								 regwrite<=0;
							    extop<=2'b01;
								 npc_sel<=2'b00;
								 aluop<=3'b000;
								 if_lb<=0;
								 if_sb<=0;
							 end
					  `beq:begin
				              regdst<=2'b00;
								  alusrc<=0;
								  memtoreg<=2'b00;
								  memwrite<=0;
								  regwrite<=0;
								  extop<=2'b00;
								  aluop<=3'b001;
								  if_lb<=0;
								  if_sb<=0;
								  if(zero)begin
								      npc_sel<=2'b01;
								  end
								  else begin
								      npc_sel<=2'b00;
								  end
							 end
					  `lui:begin
								  regdst<=2'b00;
								  alusrc<=1;
								  memtoreg<=2'b00;
								  memwrite<=0;
								  regwrite<=1;
								  extop<=2'b10;
								  npc_sel<=2'b00;
								  aluop<=3'b000;
								  if_lb<=0;
								  if_sb<=0;
							 end
					  `jal:begin
							     regdst<=2'b10;
								  alusrc<=0;
								  memtoreg<=2'b10;
								  memwrite<=0;
								  regwrite<=1;
								  extop<=2'b00;
								  npc_sel<=2'b10;
								  aluop<=3'b000;
								  if_lb<=0;
								  if_sb<=0;
							 end
				  `bgezal:begin
									alusrc<=0;
									memwrite<=0;
									extop<=2'b00;
									aluop<=3'b000;
									if_lb<=0;
								   if_sb<=0;
									if(bgezal_op)begin
										regdst<=2'b10;
										memtoreg<=2'b10;
										regwrite<=1;
										npc_sel<=2'b01;
									end
									else begin
										regdst<=2'b00;
										memtoreg<=2'b00;
										regwrite<=0;
										npc_sel<=2'b00;
									end
							 end
					 `slti:begin
									regdst<=2'b00;
									alusrc<=1;
									memtoreg<=2'b00;
									memwrite<=0;
									regwrite<=1;
									extop<=2'b01;
									npc_sel<=2'b00;
									aluop<=3'b100;
									if_lb<=0;
								   if_sb<=0;
							 end
						`lb:begin
									regdst<=2'b00;
									alusrc<=1;
									memtoreg<=2'b01;
									memwrite<=0;
									regwrite<=1;
									extop<=2'b01;
									npc_sel<=2'b00;
									aluop<=3'b000;
									if_lb<=1;
								   if_sb<=0;
							 end
						`sb:begin
									regdst<=2'b00;
									alusrc<=1;
									memtoreg<=2'b00;
									memwrite<=1;
									regwrite<=0;
									extop<=2'b01;
									npc_sel<=2'b00;
									aluop<=3'b000;
									if_lb<=0;
									if_sb<=1;
							 end
				  default:begin//nop
							     regdst<=2'b00;
								  alusrc<=0;
								  memtoreg<=2'b00;
								  memwrite<=0;
								  regwrite<=0;
								  extop<=2'b00;
								  npc_sel<=2'b00;
								  aluop<=3'b000;
								  if_lb<=0;
								  if_sb<=0;
							 end
        endcase
    end				
endmodule

