`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:31:08 12/16/2018 
// Design Name: 
// Module Name:    main_controller 
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
module main_controller(
    input [31:0] instr,
	 input true,
    output reg alusrc,
    output reg [1:0] memtoreg,
    output reg memwrite,
    output reg regwrite,
    output reg [1:0] extop,
    output reg [1:0] npc_sel,
    output reg [2:0] aluop,
	 output reg pc_sel			//0:shunxu 1:jump;branch;
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
	 `define j 6'b000010
	 `define jalr 6'b001001
	 `define lb 6'b100000
	 `define bgezal 6'b000001
	 //`define bgezalr
	 
	 wire [5:0] op;
	 assign op[5:0]=instr[31:26];
	 wire [5:0] func;
	 assign func[5:0]=instr[5:0];
	 
	 initial begin
		alusrc<=0;
		memtoreg<=2'b00;
		memwrite<=0;
		regwrite<=0;
		extop<=2'b00;
		npc_sel<=2'b00;
		aluop<=3'b000;
		pc_sel<=0;
	 end
	 always@(*)begin
	     case(op)
			   `R_type:begin
							 case(func)
				            `addu:begin
										   alusrc<=0;
											memtoreg<=2'b00;
											memwrite<=0;
											regwrite<=1;
											extop<=2'b00;
										   npc_sel<=2'b00;
										   aluop<=3'b000;
											pc_sel<=0;
										end
								`subu:begin
											alusrc<=0;
											memtoreg<=2'b00;
											memwrite<=0;
											regwrite<=1;
											extop<=2'b00;
										   npc_sel<=2'b00;
										   aluop<=3'b001;
											pc_sel<=0;
										end
								  `jr:begin
											alusrc<=0;
											memtoreg<=2'b00;
											memwrite<=0;
											regwrite<=0;
											extop<=2'b00;
										   npc_sel<=2'b11;
										   aluop<=3'b000;
											pc_sel<=1;
										end
								`jalr:begin
											alusrc<=0;
											memtoreg<=2'b10;
											memwrite<=0;
											regwrite<=1;
											extop<=2'b00;
											npc_sel<=2'b11;
											aluop<=3'b000;
											pc_sel<=1;
										end
							     	default:begin//nop
												 alusrc<=0;
												 memtoreg<=2'b00;
												 memwrite<=0;
												 regwrite<=0;
												 extop<=2'b00;
												 npc_sel<=2'b00;
												 aluop<=3'b000;
												 pc_sel<=0;
											  end	  
							endcase
						 end
					  `ori:begin
								  alusrc<=1;
				   			  memtoreg<=2'b00;
								  memwrite<=0;
								  regwrite<=1;
								  extop<=2'b00;
								  npc_sel<=2'b00;
								  aluop<=3'b010;
								  pc_sel<=0;
							 end
						`lw:begin
								 alusrc<=1;
				   			 memtoreg<=2'b01;
								 memwrite<=0;
								 regwrite<=1;
								 extop<=2'b01;
								 npc_sel<=2'b00;
								 aluop<=3'b000;
								 pc_sel<=0;
							 end
						`sw:begin
								 alusrc<=1;
								 memtoreg<=2'b00;
								 memwrite<=1;
								 regwrite<=0;
							    extop<=2'b01;
								 npc_sel<=2'b00;
								 aluop<=3'b000;
								 pc_sel<=0;
							 end
					  `beq:begin
								  alusrc<=0;
								  memtoreg<=2'b00;
								  memwrite<=0;
								  regwrite<=0;
								  extop<=2'b00;
								  aluop<=3'b000;
								  if(true)begin
									  npc_sel<=2'b01;
									  pc_sel<=1;
								  end
								  else begin
									  npc_sel<=2'b00;
									  pc_sel<=0;
								  end
							 end
					  `lui:begin
								  alusrc<=1;
								  memtoreg<=2'b00;
								  memwrite<=0;
								  regwrite<=1;
								  extop<=2'b10;
								  npc_sel<=2'b00;
								  aluop<=3'b000;
								  pc_sel<=0;
							 end
					  `jal:begin
								  alusrc<=0;
								  memtoreg<=2'b10;
								  memwrite<=0;
								  regwrite<=1;
								  extop<=2'b00;
								  npc_sel<=2'b10;
								  aluop<=3'b000;
								  pc_sel<=1;
							 end
						 `j:begin
								  alusrc<=0;
								  memtoreg<=2'b00;
								  memwrite<=0;
								  regwrite<=0;
								  extop<=2'b00;
								  npc_sel<=2'b10;
								  aluop<=3'b000;
								  pc_sel<=1;
							 end
						`lb:begin
								 alusrc<=1;
				   			 memtoreg<=2'b11;
								 memwrite<=0;
								 regwrite<=1;
								 extop<=2'b01;
								 npc_sel<=2'b00;
								 aluop<=3'b000;
								 pc_sel<=0;
							 end
				  `bgezal:begin
								 alusrc<=0;
								 memtoreg<=2'b10;
								 memwrite<=0;
								 extop<=2'b00;
								 aluop<=3'b000;
								 if(true)begin
									regwrite<=1;
									npc_sel<=2'b01;
									pc_sel<=1;
								 end
								 else begin
									regwrite<=0;
									npc_sel<=2'b00;
									pc_sel<=0;
								 end
							 end
			  //`bgezalr:begin
							  //alusrc<=0;
								//memtoreg<=2'b10;
								//memwrite<=0;
								//regwrite<=1;
								//extop<=2'b00;
								//npc_sel<=2'b00;
								//aluop<=3'b000;
								//if(true) pc_sel<=1;
								//else pc_sel<=0;
							 //end
				  default:begin//nop
								  alusrc<=0;
								  memtoreg<=2'b00;
								  memwrite<=0;
								  regwrite<=0;
								  extop<=2'b00;
								  npc_sel<=2'b00;
								  aluop<=3'b000;
								  pc_sel<=0;
							 end
        endcase
    end				

endmodule
