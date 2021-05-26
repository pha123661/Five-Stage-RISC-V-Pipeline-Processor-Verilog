/***************************************************
Student Name: 
Student ID: 
***************************************************/

`timescale 1ns/1ps
module Pipeline_CPU(
        clk_i,
		rst_i
		);
		
//I/O port
input         clk_i;
input         rst_i;

//Internal Signles
wire [31:0] pc_i;
wire [31:0] pc_o;
wire [31:0] MuxMemtoReg_o;
wire [31:0] ALUresult;
wire [31:0] MuxALUSrc_o;
wire [31:0] decoder_o;
wire [31:0] RSdata_o;
wire [31:0] RTdata_o;
wire [31:0] Imm_Gen_o;
wire [31:0] ALUSrc1_o;
wire [31:0] ALUSrc2_o;
wire [31:0] Mux_control_o;

wire [31:0] pc_add_immediate;
wire [1:0] ALUOp;
wire PC_write;
wire ALUSrc; 
wire RegWrite;
wire Branch;
wire control_output_select;
wire Jump;
wire [31:0] SL1_o;
wire [3:0] ALU_Ctrl_o;
wire zero,cout,ovf;
wire branch_zero;
wire PCSrc;
wire [31:0] DM_o;
wire MemtoReg,MemRead,MemWrite;
wire [1:0] ALUSelSrc1;
wire [1:0] ALUSelSrc2;
wire [31:0] IF_instr;
wire [31:0] pc_add4;


//Pipeline Signals
//IFID
wire [31:0] IFID_pc_o;
wire [31:0] IFID_instr_o;
wire IFID_write;
wire IFID_flush;
wire [31:0]IFID_pc_add4_o;
//IDEXE
wire [31:0] IDEXE_instr_o;
wire [2:0] IDEXE_WB_o;			///2:jump, 1:MemtoReg, 0;:RegWrite
wire [1:0] IDEXE_Mem_o;			///1:mem_read, 0:mem_write
wire [2:0] IDEXE_Exe_o;			//[2:1]: aluop. 0:alusrc
wire [31:0] IDEXE_pc_o;
wire [31:0] IDEXE_RSdata_o;
wire [31:0] IDEXE_RTdata_o;
wire [31:0] IDEXE_ImmGen_o;
wire [3:0] IDEXE_instr_30_14_12_o;
wire [4:0] IDEXE_instr_11_7_o;
wire [31:0]IDEXE_pc_add4_o;

//EXEMEM
wire [31:0] EXEMEM_instr_o;
wire [2:0] EXEMEM_WB_o;
wire [1:0] EXEMEM_Mem_o;
wire [31:0] EXEMEM_pcsum_o;
wire EXEMEM_zero_o;
wire [31:0] EXEMEM_ALUresult_o;
wire [31:0] EXEMEM_RTdata_o;
wire [4:0]  EXEMEM_instr_11_7_o;
wire [31:0] EXEMEM_pc_add4_o;

//MEMWB
wire [2:0] MEMWB_WB_o;
wire [31:0] MEMWB_DM_o;
wire [31:0] MEMWB_ALUresult_o;
wire [4:0]  MEMWB_instr_11_7_o;
wire [31:0] MEMWB_pc_add4_o;

//Create componentes
///    IF




MUX_2to1 Mux_PCSrc(
	.data0_i(pc_add4),
	.data1_i(pc_add_immediate),
	.select_i(PCSrc),             ////////	PCSrc
	.data_o(pc_i)
		);
		
ProgramCounter PC(
        .clk_i(clk_i),      
	    .rst_i (rst_i),     
		.PCWrite(PC_write),
	    .pc_i(pc_i),   
	    .pc_o(pc_o) 
	    );

Adder PC_plus_4_Adder(
	.src1_i(pc_o),
	.src2_i(32'd4),
	.sum_o(pc_add4)
	    );

Instr_Memory IM(
        .addr_i(pc_o),  
	    .instr_o(IF_instr)    
	    );




IF_register IFtoID(
	.clk_i(clk_i),
	.rst_i(rst_i),
	.address_i(pc_o), 			////////////////////////////
	.instr_i(IF_instr),
	.pc_add4_i(pc_add4),
	.IFID_write(IFID_write),
	.IFID_flush(IFID_flush),
	.address_o(IFID_pc_o),			////////////////////////////////
	.instr_o(IFID_instr_o),
	.pc_add4_o(IFID_pc_add4_o)
     );

/////// ID
assign branch_zero = (RSdata_o == RTdata_o) ? 1'b1 : 1'b0;
assign PCSrc = Jump | (Branch & branch_zero);
assign IFID_flush = PCSrc;

Hazard_detection Hazard_detection_obj(
	.IFID_regRs(IFID_instr_o[19:15]),
	.IFID_regRt(IFID_instr_o[24:20]),
	.IDEXE_regRd(IDEXE_instr_11_7_o),
	.IDEXE_memRead(IDEXE_Mem_o[1]),			////////////
	.PC_write(PC_write),
	.IFID_write(IFID_write),
	.control_output_select(control_output_select)
);

MUX_2to1 Mux_control(
	.data0_i({24'b0, Jump, MemtoReg, RegWrite, MemRead, MemWrite, ALUOp, ALUSrc}),
	.data1_i(32'b0),				/////////////////////////
	.select_i(control_output_select),
	.data_o(Mux_control_o)
);

Decoder Decoder(
        .instr_i(IFID_instr_o), 
		.ALUSrc(ALUSrc),
		.MemtoReg(MemtoReg),
	    .RegWrite(RegWrite),
		.MemRead(MemRead),
		.MemWrite(MemWrite),
	    .Branch(Branch),
		.ALUOp(ALUOp),
		.Jump(Jump)
	    );

	 
Reg_File RF(
        .clk_i(clk_i),      
	    .rst_i(rst_i) ,     
        .RSaddr_i(IFID_instr_o[19:15]) ,  
        .RTaddr_i(IFID_instr_o[24:20]) ,  
        .RDaddr_i(MEMWB_instr_11_7_o) ,  
        .RDdata_i(MuxMemtoReg_o)  , 
        .RegWrite_i (MEMWB_WB_o[0]),
        .RSdata_o(RSdata_o),  
        .RTdata_o(RTdata_o)   
        );
		
Imm_Gen ImmGen(					///////////////content temp
	.instr_i(IFID_instr_o),
	.Imm_Gen_o(Imm_Gen_o)
		);

/*
Shift_Left_1 SL1(
	.data_i(Imm_Gen_o),
	.data_o(SL1_o)
		);
*/

Adder Branch_Adder(
	.src1_i(Imm_Gen_o),			//originally SL1_o
	.src2_i(IFID_pc_o),
	.sum_o(pc_add_immediate)
	    );

//BEQ or BNE or BLT or BGE

EXE_register IDtoEXE(
	.clk_i(clk_i), 
	.rst_i(rst_i), 
	.instr_i(IFID_instr_o),
	.WB_i(Mux_control_o[7:5]),
	.Mem_i(Mux_control_o[4:3]), 
	.Exe_i(Mux_control_o[2:0]),
	.data1_i(RSdata_o), 
	.data2_i(RTdata_o), 
	.immgen_i(Imm_Gen_o), 
	.alu_ctrl_instr({IFID_instr_o[30], IFID_instr_o[14:12]}),
	.WBreg_i(IFID_instr_o[11:7]),
	.pc_add4_i(IFID_pc_add4_o),
	.instr_o(IDEXE_instr_o), 
	.WB_o(IDEXE_WB_o), 
	.Mem_o(IDEXE_Mem_o), 
	.Exe_o(IDEXE_Exe_o),  
	.data1_o(IDEXE_RSdata_o), 
	.data2_o(IDEXE_RTdata_o), 
	.immgen_o(IDEXE_ImmGen_o), 
	.alu_ctrl_input(IDEXE_instr_30_14_12_o),
	.WBreg_o(IDEXE_instr_11_7_o),
	.pc_add4_o(IDEXE_pc_add4_o)
    );	
		
	
/////// EXE
MUX_2to1 Mux_ALUSrc(
	.data0_i(ALUSrc2_o),
	.data1_i(IDEXE_ImmGen_o),
	.select_i(IDEXE_Exe_o[0]),
	.data_o(MuxALUSrc_o)
		);

ForwardingUnit FWUnit(			/////////////do later
	.EXE_instr19_15(IDEXE_instr_o[19:15]), 
	.EXE_instr24_20(IDEXE_instr_o[24:20]), 
	.MEM_instr11_7(EXEMEM_instr_11_7_o), 
	.MEM_WBControl(EXEMEM_WB_o[0]), 
	.WB_instr11_7(MEMWB_instr_11_7_o), 
	.WB_Control(MEMWB_WB_o[0]), 
	.src1_sel_o(ALUSelSrc1), 
	.src2_sel_o(ALUSelSrc2)
		);
		
		
MUX_3to1 MUX_ALU_src1(			//////////temp
	.data0_i(IDEXE_RSdata_o),       
	.data1_i(MuxMemtoReg_o),
	.data2_i(EXEMEM_ALUresult_o),
	.select_i(ALUSelSrc1),
	.data_o(ALUSrc1_o)
		);

MUX_3to1 MUX_ALU_src2(
	.data0_i(IDEXE_RTdata_o),       
	.data1_i(MuxMemtoReg_o),
	.data2_i(EXEMEM_ALUresult_o),
	.select_i(ALUSelSrc2),
	.data_o(ALUSrc2_o)
		);
			
ALU_Ctrl ALU_Ctrl(
	.instr(IDEXE_instr_30_14_12_o),
	.ALUOp(IDEXE_Exe_o[2:1]),
	.ALU_Ctrl_o(ALU_Ctrl_o)
		);
		
		
alu alu(
	.rst_n(rst_i),
	.src1(ALUSrc1_o),
	.src2(MuxALUSrc_o),
	.ALU_control(ALU_Ctrl_o),
	.result(ALUresult),
	.zero(zero),
	.cout(cout),
	.overflow(ovf)
		);

MEM_register EXEtoMEM(
	.clk_i(clk_i), 
	.rst_i(rst_i), 
	.instr_i(IDEXE_instr_o), 
	.WB_i(IDEXE_WB_o), 
	.Mem_i(IDEXE_Mem_o),  
	.zero_i(zero), 
	.alu_ans_i(ALUresult), 
	.rtdata_i(ALUSrc2_o), 
	.WBreg_i(IDEXE_instr_11_7_o),
	.pc_add4_i(IDEXE_pc_add4_o), 
	.instr_o(EXEMEM_instr_o), 
	.WB_o(EXEMEM_WB_o), 
	.Mem_o(EXEMEM_Mem_o),  
	.zero_o(EXEMEM_zero_o), 
	.alu_ans_o(EXEMEM_ALUresult_o), 
	.rtdata_o(EXEMEM_RTdata_o), 
	.WBreg_o(EXEMEM_instr_11_7_o),
	.pc_add4_o(EXEMEM_pc_add4_o)
    );

		
Data_Memory Data_Memory(
	.clk_i(clk_i),
	.addr_i(EXEMEM_ALUresult_o),
	.data_i(EXEMEM_RTdata_o),
	.MemRead_i(EXEMEM_Mem_o[1]),
	.MemWrite_i(EXEMEM_Mem_o[0]),
	.data_o(DM_o)
		);
		
WB_register MEMtoWB(
	.clk_i(clk_i), 
	.rst_i(rst_i), 
	.WB_i(EXEMEM_WB_o), 
	.DM_i(DM_o), 
	.alu_ans_i(EXEMEM_ALUresult_o), 
	.WBreg_i(EXEMEM_instr_11_7_o),
	.pc_add4_i(EXEMEM_pc_add4_o),
	.WB_o(MEMWB_WB_o), 
	.DM_o(MEMWB_DM_o), 
	.alu_ans_o(MEMWB_ALUresult_o), 
	.WBreg_o(MEMWB_instr_11_7_o),
	.pc_add4_o(MEMWB_pc_add4_o)
     );
		
/// WB
MUX_3to1 Mux_MemtoReg(
	.data0_i(MEMWB_DM_o),       
	.data1_i(MEMWB_ALUresult_o),
	.data2_i(MEMWB_pc_add4_o),
	.select_i((MEMWB_WB_o[2] == 1) ? 2'd2 : ((MEMWB_WB_o[1] == 1) ? 2'd0 : 2'd1)),
	.data_o(MuxMemtoReg_o)
		);





endmodule
		  


