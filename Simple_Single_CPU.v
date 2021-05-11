/***************************************************
Student Name:林俊宇 李勝維
Student ID: group31_0816038_0711239
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
   wire [32-1:0] ALU_o;
   wire [32-1:0] src1;
   wire [32-1:0] src2;
   wire [32-1:0] mux_A_o;
   wire [32-1:0] mux_B_o;
   wire [32-1:0] Data_Memory_o;
   wire [32-1:0] mux_W0_o;
   wire [32-1:0] PCPlusi_o;
   wire [32-1:0] PCPlus4_o;
   wire [32-1:0] Imm_Gen_o;
   wire [32-1:0] Imm_4 = 4;
   wire [4-1:0] ALUControlOut;
   wire [4-1:0] ALUControlIn;
   assign ALUControlIn[3] = instr[30];
   assign ALUControlIn[2:0] = instr[14:12];
   assign PCSrc = Jump | (Branch & Zero) ;

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
       .RDdata_i(RegWriteData),
       .RegWrite_i(RegWrite),
       .RSdata_o(src1),
       .RTdata_o(src2)
   );


   Decoder Decoder(
       .instr_i(instr[6:0]),
       .RegWrite(RegWrite),
       .Branch(Branch),
       .Jump(Jump),
       .WriteBack1(WriteBack1),
       .WriteBack0(WriteBack0),
       .MemRead(MemRead),
       .MemWrite(MemWrite),
       .ALUSrcA(ALUSrcA),
       .ALUSrcB(ALUSrcB),
       .ALUOp(ALUOp)
   );

   Imm_Gen ImmGen(
       .instr_i(instr),
       .Imm_Gen_o(Imm_Gen_o)
   );


   ALU_Ctrl ALU_Ctrl(
       .instr(ALUControlIn),
       .ALUOp(ALUOp),
       .ALU_Ctrl_o(ALUControlOut)
   );

   MUX_2to1 MUX_ALUSrcA(
       .data0_i(pc_o),
       .data1_i(src1),
       .select_i(ALUSrcA),
       .data_o(mux_A_o)
   );

   Adder Adder_PCReg(
       .src1_i(mux_A_o),
       .src2_i(Imm_Gen_o),
       .sum_o(PCPlusi_o)
   );

   MUX_2to1 MUX_PCSrc(
       .data0_i(PCPlus4_o),
       .data1_i(PCPlusi_o),
       .select_i(PCSrc),
       .data_o(pc_i)
   );

   MUX_2to1 MUX_ALUSrcB(
       .data0_i(src2),
       .data1_i(Imm_Gen_o),
       .select_i(ALUSrcB),
       .data_o(mux_B_o)
   );

   alu alu(
       .rst_n(rst_i),
       .src1(src1),
       .src2(mux_B_o),
       .ALU_control(ALUControlOut),
       .Zero(Zero),
       .result(ALU_o)
   );

   Data_Memory Data_Memory(
       .clk_i(clk_i),
       .addr_i(ALU_o),
       .data_i(src2),
       .MemRead_i(MemRead),
       .MemWrite_i(MemWrite),
       .data_o(Data_Memory_o)
   );

   MUX_2to1 MUX_WriteBack0(
       .data0_i(ALU_o),
       .data1_i(Data_Memory_o),
       .select_i(WriteBack0),
       .data_o(mux_W0_o)
   );

   MUX_2to1 MUX_WriteBack1(
       .data0_i(mux_W0_o),
       .data1_i(PCPlus4_o),
       .select_i(WriteBack1),
       .data_o(RegWriteData)
   );


   endmodule
