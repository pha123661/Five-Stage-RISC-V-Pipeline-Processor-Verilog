/***************************************************
Student Name:林俊宇 李勝維
Student ID: group31_0816038_0711239
***************************************************/

`timescale 1ns/1ps
/*instr[30,14:12]*/
module ALU_Ctrl(
    input       [4-1:0] instr,
    input       [2-1:0] ALUOp,
    output      [4-1:0] ALU_Ctrl_o
);
wire [2:0] func3;
assign func3 = instr[2:0];
/* Write your code HERE */
/*
ALUOp:
R-type: 1x
addi/Load: 00
Store: 00
Branch: 01
JAL/JALR: xx
*/
wire func7_1bit;
reg ALU_Ctrl_o;
assign func7_1bit = instr[3];

always @(*) begin
    case (ALUOp)
        2'b1x: begin
            // R-type
            if (func3 == 3'b000 && func7_1bit == 1'b0) begin
                // add
                ALU_Ctrl_o = 4'b0010;
            end else if (func3 == 3'b000 && func7_1bit == 1'b1) begin
                // sub
                ALU_Ctrl_o = 4'b0110;
            end else if (func3 == 3'b010) begin
                // slt
                ALU_Ctrl_o = 4'b0111;
            end
        end
        2'b00: begin
            // addi, load, store
            ALU_Ctrl_o = 4'b0010;
        end
        2'b01: begin
            // beq
            ALU_Ctrl_o = 4'b0110;
        end
        default: ALU_Ctrl_o = 4'Bxxxx; // JAL, JALR
    endcase
end

endmodule

