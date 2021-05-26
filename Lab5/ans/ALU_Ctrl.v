/***************************************************
Student Name: 
Student ID: 
***************************************************/

`timescale 1ns/1ps

module ALU_Ctrl(
	input		[4-1:0]	instr,
	input		[2-1:0]	ALUOp,
	output wire	[4-1:0] ALU_Ctrl_o
	);
/*
addi   v
 nop, v
sub	v
add	v
and, v
or, v
xor, v
sw   v
slt  v
lw   v
slti, v
slli, v
beq  v
jal  v
*/


/* Write your code HERE */
/*
ALUOp:
R-type: 1x
addi/Load: 00
Store: 00
Branch: 01
JAL/JALR: xx
*/


wire [5:0] ctrl_i;
assign ctrl_i = {ALUOp, instr};
assign ALU_Ctrl_o = (ctrl_i[5:4] == 2'b01 & ctrl_i[2:0] == 3'b000)?4'b0110:( // beq
			(ctrl_i[5:4] == 2'b10 & ctrl_i[3:0] == 4'b0000)? 4'b0010:( // add
			(ctrl_i[5:4] == 2'b10 & ctrl_i[3:0] == 4'b1000)? 4'b0110:( // sub
			(ctrl_i[5:4] == 2'b10 & ctrl_i[3:0] == 4'b0111)? 4'b0000:( // and
			(ctrl_i[5:4] == 2'b10 & ctrl_i[3:0] == 4'b0110)? 4'b0001:( // or
			(ctrl_i[5:4] == 2'b10 & ctrl_i[3:0] == 4'b0100)? 4'b0111:( // xor
			(ctrl_i[5:4] == 2'b10 & ctrl_i[3:0] == 4'b0010)? 4'b0011:( // slt
			(ctrl_i[5:4] == 2'b11 & ctrl_i[2:0] == 3'b000)? 4'b0010:( // addi, nop
			(ctrl_i[5:4] == 2'b00 & ctrl_i[2:0] == 3'b010)? 4'b0010:( //load, store
			(ctrl_i[5:4] == 2'b11 & ctrl_i[2:0] == 3'b010)? 4'b0011:( // slti
			(ctrl_i[5:4] == 2'b11 & ctrl_i[3:0] == 4'b0001)? 4'b1100: // slli
											4'bxxxx)))))))))); // jal



endmodule


