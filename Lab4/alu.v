/***************************************************
Student Name:林俊宇 李勝維
Student ID: group31_0816038_0711239
***************************************************/
   `timescale 1ns/1ps

   module alu(
       input                   rst_n,         // negative reset            (input)
       input        [32-1:0]   src1,          // 32 bits source 1          (input)
       input        [32-1:0]   src2,          // 32 bits source 2          (input)
       input        [ 4-1:0]   ALU_control,   // 4 bits ALU control input  (input)
       output reg   [32-1:0]   result,        // 32 bits result            (output)
       output               Zero          // 1 bit when the output is 0, zero must be set (output)
   );

   /* Write your code HERE */
	wire [32-1:0] a;
	wire [32-1:0] b;
	reg [32-1:0] inter_rst;
	assign a = src1;
	assign b = src2;

	/*
	ALU_Ctrl_o = 4'b0010; //add
	ALU_Ctrl_o = 4'b0110; //sub
	ALU_Ctrl_o = 4'b0000; //and
	ALU_Ctrl_o = 4'b0001; //or
	ALU_Ctrl_o = 4'b0111; //slt
	*/

	always @(*) begin
		//$display("src1: %b", src1);
		if(~rst_n) begin
			result = 0;
		end	else begin
			case (ALU_control)
				4'b0010: begin
					//add
					result = a + b;
				end
				4'b0110: begin
					//sub
					result = a - b;
				end
				4'b0000: begin
					//and
					result = src1 & src2;
				end
				4'b0001: begin
					//or
					result = src1 | src2;
				end
				4'b0111: begin
					//slt
					inter_rst = a - b;
					if(inter_rst[31] == 1)
						result = 32'b00000000000000000000000000000001;
					else
						result = 32'b00000000000000000000000000000000;
				end
				4'b1000: begin
					//xor
					result = src1 ^ src2;
				end
				4'b1100: begin
					//sll
					result = src1 << src2;
				end
				4'b1011: begin
					//sra
					result = src1 >>> src2;
				end
				default: begin
					//not defined
					result = 32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
				end
			endcase
		end
	end
	assign Zero = ~(|result);
	endmodule

