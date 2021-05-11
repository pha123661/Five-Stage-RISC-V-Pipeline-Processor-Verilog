/***************************************************
Student Name:林俊宇 李勝維
Student ID: group31_0816038_0711239
***************************************************/

   `timescale 1ns/1ps

   module Adder(
       input  [31:0] src1_i,
       input  [31:0] src2_i,
       output [31:0] sum_o
   );

   assign sum_o = src1_i + src2_i;


   endmodule
