/***************************************************
Student Name:
Student ID: group99_0811111_0811999 
***************************************************/

   `timescale 1ns/1ps

   module Adder(
       input  [31:0] src1_i,
       input  [31:0] src2_i,
       output [31:0] sum_o
   );

   assign sum_o = src1_i + src2_i;


   endmodule
