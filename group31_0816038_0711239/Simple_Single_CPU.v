/***************************************************
Student Name :
Student ID: Lab4_release
***************************************************/
   `timescale 1ns/1ps
   module Simple_Single_CPU(
       input clk_i,
       input rst_i
   );

   //Internal Signales
   //Control Signales
   wire RegWrite;
   wire Branch;
   wire Jump;
   wire WriteBack1;
   wire WriteBack0;
   wire MemRead;
   wire MemWrite;
   wire ALUSrcA;
   wire ALUSrcB;
   wire [2-1:0] ALUOp;
   wire PCSrc;
   //ALU Flag
   wire Zero;

   //Datapath
   wire [32-1:0] pc_i;
   wire [32-1:0] pc_o;
   wire [32-1:0] instr;
   wire [32-1:0] RegWriteData;
   wire [32-1:0] Imm_Gen_o;
   wire [32-1:0] Imm_4 = 4;
   wire [4-1:0] ALUControlOut;
   wire [4-1:0] ALUControlIn;
   assign ALUControlIn[3] = instr[30];
   assign ALUControlIn[2:0] = instr[14:12];
   assign PCSrc = (Branch & Zero) | Jump;

   ProgramCounter PC(
       .clk_i(clk_i),
       .rst_i(rst_i),
       .pc_i(pc_i),
       .pc_o(pc_o)
   );

   Adder Adder_PCPlus4(
       .src1_i(pc_o),
       .src2_i(Imm_4),
       .sum_o(PCPlus4_o)
   );

   Instr_Memory IM(
       .addr_i(pc_o),
       .instr_o(instr)
   );

   Reg_File RF(
       .clk_i(clk_i),
       .rst_i(rst_i),
       .RSaddr_i(instr[19:15]),
       .RTaddr_i(instr[24:20]),
       .RDaddr_i(instr[11:7]),
       .RDdata_i(),
       .RegWrite_i(),
       .RSdata_o(),
       .RTdata_o()
   );


   Decoder Decoder(
       .instr_i(instr[6:0]),
       .RegWrite(),
       .Branch(),
       .Jump(),
       .WriteBack1(),
       .WriteBack0(),
       .MemRead(),
       .MemWrite(),
       .ALUSrcA(),
       .ALUSrcB(),
       .ALUOp()
   );

   Imm_Gen ImmGen(
       .instr_i(instr),
       .Imm_Gen_o(Imm_Gen_o)
   );


   ALU_Ctrl ALU_Ctrl(
       .instr(),
       .ALUOp(),
       .ALU_Ctrl_o()
   );

   MUX_2to1 MUX_ALUSrcA(
       .data0_i(),
       .data1_i(),
       .select_i(),
       .data_o()
   );

   Adder Adder_PCReg(
       .src1_i(),
       .src2_i(),
       .sum_o()
   );

   MUX_2to1 MUX_PCSrc(
       .data0_i(),
       .data1_i(),
       .select_i(),
       .data_o()
   );

   MUX_2to1 MUX_ALUSrcB(
       .data0_i(),
       .data1_i(),
       .select_i(),
       .data_o()
   );

   alu alu(
       .rst_n(rst_i),
       .src1(),
       .src2(),
       .ALU_control(),
       .Zero(),
       .result()
   );

   Data_Memory Data_Memory(
       .clk_i(clk_i),
       .addr_i(),
       .data_i(),
       .MemRead_i(),
       .MemWrite_i(),
       .data_o()
   );

   MUX_2to1 MUX_WriteBack0(
       .data0_i(),
       .data1_i(),
       .select_i(),
       .data_o()
   );

   MUX_2to1 MUX_WriteBack1(
       .data0_i(),
       .data1_i(),
       .select_i(),
       .data_o()
   );

   endmodule
