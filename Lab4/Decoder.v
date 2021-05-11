/***************************************************
Student Name:林俊宇 李勝維
Student ID: group31_0816038_0711239
***************************************************/

`timescale 1ns/1ps

module Decoder(
    input   [7-1:0]     instr_i, // opcode
    output              RegWrite,
    output              Branch,
    output              Jump,
    output              WriteBack1,
    output              WriteBack0,
    output              MemRead,
    output              MemWrite,
    output              ALUSrcA,
    output              ALUSrcB,
    output  [2-1:0]     ALUOp
);

/* Write your code HERE */
// opcode table: https://longfangsong.github.io/2019/06/12/RISC-V%20%E5%9F%BA%E6%9C%AC%E6%95%B4%E6%95%B0%E6%8C%87%E4%BB%A4%E9%9B%86/
wire [7-1:0] opcode;
assign opcode = instr_i;// Alias
reg              RegWrite;
reg              Branch;
reg              Jump;
reg              WriteBack1;
reg              WriteBack0;
reg              MemRead;
reg              MemWrite;
reg              ALUSrcA;
reg              ALUSrcB;
reg  [2-1:0]     ALUOp;

always @(*) begin
    //$display("opcode: %b",opcode);
    if (opcode == 7'b0110011) begin
        // R-type
        RegWrite = 1'b1;
        Branch = 1'b0;
        Jump = 1'b0;
        {WriteBack1, WriteBack0} = 2'b00;
        MemRead = 1'b0;
        MemWrite = 1'b0;
        {ALUSrcA, ALUSrcB} = 2'bx0;
        ALUOp = 2'b1x;
    end else if (opcode == 7'b0010011) begin
        // addi
        RegWrite = 1'b1;
        Branch = 1'b0;
        Jump = 1'b0;
        {WriteBack1, WriteBack0} = 2'b00;
        MemRead = 1'b0;
        MemWrite = 1'b0;
        {ALUSrcA, ALUSrcB} = 2'bx1;
        ALUOp = 2'b00;        
    end else if (opcode == 7'b0000011) begin
        // Load
        RegWrite = 1'b1;
        Branch = 1'b0;
        Jump = 1'b0;
        {WriteBack1, WriteBack0} = 2'b01;
        MemRead = 1'b1;
        MemWrite = 1'b0;
        {ALUSrcA, ALUSrcB} = 2'bx1;
        ALUOp = 2'b00;
    end else if (opcode == 7'b0100011) begin
        // Store
        RegWrite = 1'b0;
        Branch = 1'b0;
        Jump = 1'b0;
        {WriteBack1, WriteBack0} = 2'bxx;
        MemRead = 1'b0;
        MemWrite = 1'b1;
        {ALUSrcA, ALUSrcB} = 2'bx1;
        ALUOp = 2'b00;
    end else if (opcode == 7'b1100011) begin
        // Branch (beq)
        RegWrite = 1'b0;
        Branch = 1'b1;
        Jump = 1'b0;
        {WriteBack1, WriteBack0} = 2'bxx;
        MemRead = 1'b0;
        MemWrite = 1'b0;
        {ALUSrcA, ALUSrcB} = 2'b00;
        ALUOp = 2'b01;    
    end else if (opcode == 7'b1100111) begin
        // JALR
        RegWrite = 1'b1;
        Branch = 1'bx;
        Jump = 1'b1;
        {WriteBack1, WriteBack0} = 2'b1x;
        MemRead = 1'b0;
        MemWrite = 1'b0;
        {ALUSrcA, ALUSrcB} = 2'b1x;
        ALUOp = 2'bxx;    
    end else if (opcode == 7'b1101111) begin
        // JAL
        RegWrite = 1'b1;
        Branch = 1'bx;
        Jump = 1'b1;
        {WriteBack1, WriteBack0} = 2'b1x;
        MemRead = 1'b0;
        MemWrite = 1'b0;
        {ALUSrcA, ALUSrcB} = 2'b0x;
        ALUOp = 2'bxx;    
    end else begin
        RegWrite = 1'b0;
        Branch = 1'b0;
        Jump = 1'b0;
        {WriteBack1, WriteBack0} = 2'b00;
        MemRead = 1'b0;
        MemWrite = 1'b0;
        {ALUSrcA, ALUSrcB} = 2'b0x;
        ALUOp = 2'bxx;    
    end
end
endmodule

