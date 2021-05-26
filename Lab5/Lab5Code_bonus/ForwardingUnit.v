module ForwardingUnit (EXE_instr19_15, EXE_instr24_20, MEM_instr11_7, MEM_WBControl, WB_instr11_7, WB_Control, src1_sel_o, src2_sel_o);

	input [5-1:0] EXE_instr19_15, EXE_instr24_20, MEM_instr11_7, WB_instr11_7;
	input  MEM_WBControl, WB_Control;
	output wire [2-1:0] src1_sel_o, src2_sel_o;

endmodule
 
