/***************************************************
Student Name: 李勝維
Student ID: 0711239
***************************************************/
`timescale 1ns/1ps

module alu(
	input                   rst_n,         // negative reset            (input)
	input	     [32-1:0]	src1,          // 32 bits source 1          (input)
	input	     [32-1:0]	src2,          // 32 bits source 2          (input)
	input 	     [ 4-1:0] 	ALU_control,   // 4 bits ALU control input  (input)
	output reg   [32-1:0]	result,        // 32 bits result            (output)
	output reg              zero,          // 1 bit when the output is 0, zero must be set (output)
	output reg              cout,          // 1 bit carry out           (output)
	output reg              overflow       // 1 bit overflow            (output)
	);

/* Write your code HERE */
wire Ainvert = ALU_control[3];
wire Binvert = ALU_control[2];
wire [2-1:0] op = ALU_control[1:0];

wire [32-1:0] out;
wire C0,C1,C2,C3,C4,C5,C6,C7,C8,C9,C10,C11,C12,C13,C14,C15,C16,C17,C18,C19,C20,C21,C22,C23,C24,C25,C26,C27,C28,C29,C30,C31;
reg first_cin; // 太長省略

// 32 1-bit-ALU
ALU_1bit first(src1[0], src2[0], Ainvert, Binvert, first_cin, op, out[0], C0);
ALU_1bit one(src1[1], src2[1], Ainvert, Binvert, C0, op, out[1], C1);
ALU_1bit two(src1[2], src2[2], Ainvert, Binvert, C1, op, out[2], C2);
ALU_1bit three(src1[3], src2[3], Ainvert, Binvert, C2, op, out[3], C3);
ALU_1bit four(src1[4], src2[4], Ainvert, Binvert, C3, op, out[4], C4);
ALU_1bit five(src1[5], src2[5], Ainvert, Binvert, C4, op, out[5], C5);
ALU_1bit six(src1[6], src2[6], Ainvert, Binvert, C5, op, out[6], C6);
ALU_1bit seven(src1[7], src2[7], Ainvert, Binvert, C6, op, out[7], C7);
ALU_1bit eight(src1[8], src2[8], Ainvert, Binvert, C7, op, out[8], C8);
ALU_1bit nine(src1[9], src2[9], Ainvert, Binvert, C8, op, out[9], C9);
ALU_1bit ten(src1[10], src2[10], Ainvert, Binvert, C9, op, out[10], C10);
ALU_1bit eleven(src1[11], src2[11], Ainvert, Binvert, C10, op, out[11], C11);
ALU_1bit twelve(src1[12], src2[12], Ainvert, Binvert, C11, op, out[12], C12);
ALU_1bit thirteen(src1[13], src2[13], Ainvert, Binvert, C12, op, out[13], C13);
ALU_1bit fourteen(src1[14], src2[14], Ainvert, Binvert, C13, op, out[14], C14);
ALU_1bit fifteen(src1[15], src2[15], Ainvert, Binvert, C14, op, out[15], C15);
ALU_1bit sixteen(src1[16], src2[16], Ainvert, Binvert, C15, op, out[16], C16);
ALU_1bit seventeen(src1[17], src2[17], Ainvert, Binvert, C16, op, out[17], C17);
ALU_1bit eighteen(src1[18], src2[18], Ainvert, Binvert, C17, op, out[18], C18);
ALU_1bit nineteen(src1[19], src2[19], Ainvert, Binvert, C18, op, out[19], C19);
ALU_1bit twenty(src1[20], src2[20], Ainvert, Binvert, C19, op, out[20], C20);
ALU_1bit twenty_one(src1[21], src2[21], Ainvert, Binvert, C20, op, out[21], C21);
ALU_1bit twenty_two(src1[22], src2[22], Ainvert, Binvert, C21, op, out[22], C22);
ALU_1bit twenty_three(src1[23], src2[23], Ainvert, Binvert, C22, op, out[23], C23);
ALU_1bit twenty_four(src1[24], src2[24], Ainvert, Binvert, C23, op, out[24], C24);
ALU_1bit twenty_five(src1[25], src2[25], Ainvert, Binvert, C24, op, out[25], C25);
ALU_1bit twenty_six(src1[26], src2[26], Ainvert, Binvert, C25, op, out[26], C26);
ALU_1bit twenty_seven(src1[27], src2[27], Ainvert, Binvert, C26, op, out[27], C27);
ALU_1bit twenty_eight(src1[28], src2[28], Ainvert, Binvert, C27, op, out[28], C28);
ALU_1bit twenty_nine(src1[29], src2[29], Ainvert, Binvert, C28, op, out[29], C29);
ALU_1bit thirty(src1[30], src2[30], Ainvert, Binvert, C29, op, out[30], C30);
ALU_1bit thirty_one(src1[31], src2[31], Ainvert, Binvert, C30, op, out[31], C31);

always @(*) begin
	if(rst_n == 0)begin
		result = 0;
		zero = 0;
		cout = 0;
		overflow = 0;
	end
	else begin
		case (ALU_control)
			4'b0000: begin //AND
				first_cin = 0;
				cout = 0;
				result = out;
				overflow = 0;
			end
			4'b0001: begin //OR
				first_cin = 0;
				cout = 0;
				result = out;
				overflow = 0;
			end
			4'b0010: begin //add
				first_cin = 0;
				cout = C31;
				result = out;
				overflow = C30 ^ C31;
			end
			4'b0110: begin //sub
				first_cin = 1;
				cout = C31;
				result = out;
				overflow = C30 ^ C31;
			end
			4'b0111: begin //slt
				first_cin = 1;
				cout = 0;
				if (out[31] == 1)
					result = 32'b00000000000000000000000000000001;
				else
					result = 32'b00000000000000000000000000000000;
				overflow = 0;
			end
			4'b1100: begin //nor
				first_cin = 0;
				cout = 0;
				result = out;
				overflow = 0;
			end
			4'b1101: begin //nand
				first_cin = 0;
				cout = 0;
				result = out;
				overflow = 0
			end
		endcase

		zero = |result;
		zero = ~zero;
	end
end

endmodule
