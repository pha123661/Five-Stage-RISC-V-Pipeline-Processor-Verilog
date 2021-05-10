/***************************************************
Student Name:	李勝維, 	林俊宇
Student ID:	0711239, 	0816038
***************************************************/

`timescale 1ns/1ps
module Simple_Single_CPU(
	input clk_i,
	input rst_i
	);

//Internal Signles
wire [31:0] pc_i;
wire [31:0] pc_o;
wire [31:0] instr;
wire [31:0] ALUresult;
wire RegWrite;
wire [31:0] RSdata_o;
wire [31:0] RTdata_o;
wire ALUSrc;
wire [1:0] ALUOp;
wire [3:0]ALU_control;
wire zero,cout,overflow;
wire [31:0]imm_4 = 4;
		
ProgramCounter PC(
        .clk_i(clk_i),      
	    .rst_i (rst_i),     
	    .pc_i(pc_i) ,   
	    .pc_o(pc_o) 
	    );

Instr_Memory IM(
        .addr_i(pc_o),  
	    .instr_o(instr)    
	    );
		
Reg_File RF(
        .clk_i(clk_i),      
	    .rst_i(rst_i) ,     
        .RSaddr_i(instr[19:15]) ,  
        .RTaddr_i(instr[24:20]) ,  
        .RDaddr_i(instr[11:7]) ,  
        .RDdata_i(ALUresult)  , 
        .RegWrite_i (RegWrite),
        .RSdata_o(RSdata_o) ,  
        .RTdata_o(RTdata_o)   
        );
		
Decoder Decoder(
        .instr_i(instr), 
        .ALUSrc(ALUSrc),
        .RegWrite(RegWrite),
        .Branch(),
        .ALUOp(ALUOp)  
	    );	

Adder PC_plus_4_Adder(
        .src1_i(pc_o),
	.src2_i(32'd4),
	.sum_o(pc_i)
	    );
		
	
			
ALU_Ctrl ALU_Ctrl(
        .instr({instr[30], instr[14:12]}),
        .ALUOp(ALUOp),
        .ALU_Ctrl_o(ALU_control)
		);
		
alu alu(
        .rst_n(rst_i),
        .src1(RSdata_o),
        .src2(RTdata_o),
        .ALU_control(ALU_control),
        .zero(zero),
        .result(ALUresult),
        .cout(cout),
        .overflow(overflow)
		);
	
		
endmodule
		  


