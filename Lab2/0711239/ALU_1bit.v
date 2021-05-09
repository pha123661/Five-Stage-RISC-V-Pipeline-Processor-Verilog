/***************************************************
Student Name: 李勝維
Student ID: 0711239
***************************************************/
`timescale 1ns/1ps

module ALU_1bit(
	input				src1,       //1 bit source 1  (input)
	input				src2,       //1 bit source 2  (input)
	input 				Ainvert,    //1 bit A_invert  (input)
	input				Binvert,    //1 bit B_invert  (input)
	input 				Cin,        //1 bit carry in  (input)
	input 	    [2-1:0] operation,  //2 bit operation (input)
	output reg          result,     //1 bit result    (output)
	output reg          cout        //1 bit carry out (output)
	);

/* Write your code HERE */

/*	opcode:
	2'b00 : AND
	2'b01 : OR
	2'b10/11: Full Adder*/

wire a, b;

assign a = src1 ^ Ainvert;
assign b = src2 ^ Binvert;


always @(*) begin
	case(operation)
		2'b00: begin
			result = a & b;
		end
		2'b01: begin
			result = a | b;
		end
		2'b10, 2'b11: begin
			result = a ^ b ^ Cin;
			cout = (a & b) | (b & Cin) | (Cin & a);
		end
	endcase
end

endmodule
