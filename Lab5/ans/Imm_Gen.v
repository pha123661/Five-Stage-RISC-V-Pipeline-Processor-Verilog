/***************************************************
Student Name: 
Student ID: 
***************************************************/

`timescale 1ns/1ps

module Imm_Gen(
	input  [31:0] instr_i,
	output [31:0] Imm_Gen_o
	);

/* Write your code HERE */

//Internal Signals
wire    [7-1:0] opcode;
wire    [2:0]   func3;
wire    [3-1:0] Instr_field;

assign opcode = instr_i[6:0];
assign func3  = instr_i[14:12];

// type1 = I, type2 = S, type3 = J, type4 = B
assign Imm_Gen_o = 	((opcode == 7'b0010011) || (opcode == 7'b0000011) || (opcode == 7'b1100111)) ? 
					        // I-format: addi, load, JALR, slli
						{{21{instr_i[31]}}, instr_i[30:25], instr_i[24:21], instr_i[20]} : (
			(opcode == 7'b0100011) ?
     						// S-format: Store
						{{21{instr_i[31]}}, instr_i[30:25], instr_i[11:8], instr_i[7]} : (
			(opcode == 7'b1101111) ?
						// J-format: JAL
						{{12{instr_i[31]}}, instr_i[19:12], instr_i[20], instr_i[30:25], instr_i[24:21], 1'b0} : 
						// B-format: Branch
						{{20{instr_i[31]}}, instr_i[7], instr_i[30:25], instr_i[11:8], 1'b0}));


/*always @(*) begin
	$display("Imm_Gen_o//////////////////////////////////////////////: %b", Imm_Gen_o);
	$display("opcode//////////////////////////////////////////////: %b", opcode);
	$display("instr_i//////////////////////////////////////////////: %b", instr_i);
end
*/

endmodule
