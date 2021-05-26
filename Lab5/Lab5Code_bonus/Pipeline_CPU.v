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
wire [7:0] Mux_control_o;

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
wire [2:0] IDEXE_WB_o;
wire [1:0] IDEXE_Mem_o;
wire [2:0] IDEXE_Exe_o;
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
		);
		
ProgramCounter PC(
        .clk_i(clk_i),      
	    .rst_i (rst_i),     
		.PCWrite(PC_write),
	    .pc_i(pc_i),   
	    .pc_o(pc_o) 
	    );

Adder PC_plus_4_Adder(
	    );

Instr_Memory IM(
        .addr_i(pc_o),  
	    .instr_o(IF_instr)    
	    );




IF_register IFtoID(
     );

/////// ID

Hazard_detection Hazard_detection_obj(
);
MUX_2to1 Mux_control(
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
        .RegWrite_i (MEMWB_WB_o[1]),
        .RSdata_o(RSdata_o),  
        .RTdata_o(RTdata_o)   
        );
		
Imm_Gen ImmGen(
		);

Shift_Left_1 SL1(
		);

Adder Branch_Adder(
	    );

//BEQ or BNE or BLT or BGE

EXE_register IDtoEXE(
    );	
		
	
/////// EXE
MUX_2to1 Mux_ALUSrc(
		);

ForwardingUnit FWUnit(
		);
		
		
MUX_3to1 MUX_ALU_src1(
		);

MUX_3to1 MUX_ALU_src2(
		);
			
ALU_Ctrl ALU_Ctrl(
		);
		
		
alu alu(
		);

MEM_register EXEtoMEM(
    );

		
Data_Memory Data_Memory(
		);
		
WB_register MEMtoWB(
     );
		
/// WB
MUX_3to1 Mux_MemtoReg(
		);



endmodule
		  


