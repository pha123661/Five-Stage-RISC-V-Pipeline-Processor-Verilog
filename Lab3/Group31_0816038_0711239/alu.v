/***************************************************
Student Name:	李勝維, 	林俊宇
Student ID:	0711239, 	0816038
***************************************************/
`timescale 1ns/1ps

module alu(
	input                   rst_n,         // negative reset            (input)
	input	signed    [32-1:0]	src1,          // 32 bits source 1          (input)
	input	signed     [32-1:0]	src2,          // 32 bits source 2          (input)
	input 	     [ 4-1:0] 	ALU_control,   // 4 bits ALU control input  (input)
	output reg   [32-1:0]	result,        // 32 bits result            (output)
	output reg              zero,          // 1 bit when the output is 0, zero must be set (output)
	output reg              cout,          // 1 bit carry out           (output)
	output reg              overflow       // 1 bit overflow            (output)
	);

/* Write your code HERE */
wire [33-1:0] a;
wire [33-1:0] b;
reg [33-1:0] inter_rst;
reg [32-1:0] trash;

assign a = {src1[31], src1};
assign b = {src2[31], src2};

/*
ALU_Ctrl_o = 4'b0010; //add
ALU_Ctrl_o = 4'b0111; //sub
ALU_Ctrl_o = 4'b0000; //and
ALU_Ctrl_o = 4'b0001; //or
ALU_Ctrl_o = 4'b0111; //slt
*/

always @(*) begin
	if(rst_n == 0) begin
		result = 0;
		zero = 0;
		cout = 0;
		overflow = 0;
	end	else begin
		case (ALU_control)
			4'b0010: begin
				//add
				inter_rst = a + b;
				result = inter_rst[31:0];
				overflow = inter_rst[32] ^ inter_rst[31];
				{cout, trash} = {1'b0, src1} + {1'b0, src2};
			end
			4'b0110: begin
				//sub
				inter_rst = a - b;
				result = inter_rst[31:0];
				overflow = inter_rst[32] ^ inter_rst[31];
				{cout, trash} = {1'b0, src1} + {1'b0, ~src2} + 1;
			end
			4'b0000: begin
				//and
				result = src1 & src2;
				overflow = 0;
				cout = 0;
			end
			4'b0001: begin
				//or
				result = src1 | src2;
				overflow = 0;
				cout = 0;
			end
			4'b0111: begin
				//slt
				trash = a - b;
				if(trash[31] == 1)
					result = 32'b00000000000000000000000000000001;
				else
					result = 32'b00000000000000000000000000000000;
				overflow = 0;
				cout = 0;
			end
			4'b1000: begin
				//xor
				result = src1 ^ src2;
				overflow = 0;
				cout = 0;
			end
			4'b1100: begin
				//sll
				result = src1 << src2;
				overflow = 0;
				cout = 0;
			end
			4'b1011: begin
				//sra
				result = src1 >>> src2;
				overflow = 0;
				cout = 0;
			end
			default: begin
				//not defined
				result = 32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
				cout = 1'bx;
				overflow = 1'bx;
			end
		endcase
		zero = ~(|result);
	end
end
endmodule
