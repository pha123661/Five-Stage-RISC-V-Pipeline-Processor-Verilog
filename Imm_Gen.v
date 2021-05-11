/***************************************************
Student Name:林俊宇 李勝維
Student ID: group31_0816038_0711239
***************************************************/

`timescale 1ns/1ps

module Imm_Gen(
    input  [31:0] instr_i,
    output reg[31:0] Imm_Gen_o
);

//Internal Signals
wire    [7-1:0] opcode;
wire    [2:0]   func3;
wire    [3-1:0] Instr_field;

assign opcode = instr_i[6:0];
assign func3  = instr_i[14:12];

/* Write your code HERE */
// type1 = I, type2 = S, type3 = J, type4 = B
always @(*) begin
    if ((opcode == 7'b0010011) || (opcode == 7'b0000011) || (opcode == 7'b1100111)) begin
        // I-format: addi, load, JALR
        Imm_Gen_o = {{21{instr_i[31]}}, instr_i[30:25], instr_i[24:21], instr_i[20]};
    end else if (opcode == 7'b0100011) begin
        // S-format: Store
        Imm_Gen_o = {{21{instr_i[31]}}, instr_i[30:25], instr_i[11:8], instr_i[7]};
    end else if (opcode == 7'b1101111) begin
        // J-format: JAL
        Imm_Gen_o = {{12{instr_i[31]}}, instr_i[19:12], instr_i[20], instr_i[30:25], instr_i[24:21], 1'b0};
    end else if (opcode == 7'b1100011) begin
        // B-format: Branch
        Imm_Gen_o = {{20{instr_i[31]}}, instr_i[7], instr_i[30:25], instr_i[11:8], 1'b0};
    end
end
endmodule
