/***************************************************
Student Name: 李勝維
Student ID: 0711239
***************************************************/

`timescale 1ns/1ps

module ALU_Ctrl(
	input	[4-1:0]	instr,
	input	[2-1:0]	ALUOp,
	output	reg [4-1:0] ALU_Ctrl_o
	);
	
/* Write your code HERE */
// instr = Instruction [30, 14-12]
wire [4-1:0] instr;
wire [2-1:0] ALUop;
always @(*) begin
	case (ALUop)
		2'b10:
			case (instr)
				4'b0000: ALU_Ctrl_o = 4'b0010; //add
				4'b1000: ALU_Ctrl_o = 4'b0111; //sub
				4'b0111: ALU_Ctrl_o = 4'b0000; //and
				4'b0110: ALU_Ctrl_o = 4'b0001; //or
				4'b0010: ALU_Ctrl_o = 4'b0111; //slt
				4'b0100: ALU_Ctrl_o = 4'b1000; //xor (defined by myself)
				4'b0001: ALU_Ctrl_o = 4'b1100; //sll (defined bt myself)
				4'b1101: ALU_Ctrl_o = 4'b1011; //sra (defined by myself)
				default: ALU_Ctrl_o = 4'bxxxx; //don't care
			endcase 
		default: ALU_Ctrl_o = 4'bxxxx;
	endcase
end

endmodule