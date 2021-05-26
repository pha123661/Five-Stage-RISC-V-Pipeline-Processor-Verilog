// Done
module ForwardingUnit (EXE_instr19_15, EXE_instr24_20, MEM_instr11_7, MEM_WBControl, WB_instr11_7, WB_Control, src1_sel_o, src2_sel_o);

    input [5-1:0] EXE_instr19_15, EXE_instr24_20, MEM_instr11_7, WB_instr11_7;
    input MEM_WBControl, WB_Control;
    output wire [2-1:0] src1_sel_o, src2_sel_o;

    // Alias
    wire [5-1:0] EX_MEM_Rd, MEM_WB_Rd, ID_EX_Rs1, ID_EX_Rs2;
    wire EX_MEM_RegWrite, MEM_WB_RegWrite;

    assign ID_EX_Rs1 = EXE_instr19_15;
    assign ID_EX_Rs2 = EXE_instr24_20;
    assign EX_MEM_Rd = MEM_instr11_7;
    assign MEM_WB_Rd = WB_instr11_7;

    assign EX_MEM_RegWrite = MEM_WBControl;
    assign MEM_WB_RegWrite = WB_Control;

    // Forward A
    assign src1_sel_o = (EX_MEM_RegWrite && (EX_MEM_Rd != 5'b00000) && (EX_MEM_Rd == ID_EX_Rs1)) ? 2'b10 :
           (MEM_WB_RegWrite && (MEM_WB_Rd != 5'b00000) && (EX_MEM_Rd != ID_EX_Rs1) && (MEM_WB_Rd == ID_EX_Rs1))? 2'b01 :
           2'b00;
    // Forward B
    assign src2_sel_o = (EX_MEM_RegWrite && (EX_MEM_Rd != 5'b00000) && (EX_MEM_Rd == ID_EX_Rs2)) ? 2'b10 :
           (MEM_WB_RegWrite && (MEM_WB_Rd != 5'b00000) && (EX_MEM_Rd != ID_EX_Rs2) && (MEM_WB_Rd == ID_EX_Rs2))? 2'b01 :
           2'b00;
endmodule

