module EXE_register (clk_i, rst_i, instr_i, WB_i, Mem_i, Exe_i, data1_i, data2_i, immgen_i, alu_ctrl_instr, WBreg_i, pc_add4_i, instr_o, WB_o, Mem_o, Exe_o,  data1_o, data2_o, immgen_o, alu_ctrl_input, WBreg_o,pc_add4_o);

    input clk_i;
    input rst_i;
    input [31:0] instr_i;
    input [2:0] WB_i;
    input [1:0] Mem_i;
    input [2:0] Exe_i;
    input [31:0] data1_i;
    input [31:0] data2_i;
    input [31:0] immgen_i;
    input [3:0] alu_ctrl_instr;
    input [4:0] WBreg_i;
    input [31:0] pc_add4_i;

    output reg [31:0] instr_o;
    output reg [2:0] WB_o;
    output reg [1:0] Mem_o;
    output reg [2:0] Exe_o;
    output reg [31:0] data1_o;
    output reg [31:0] data2_o;
    output reg [31:0] immgen_o;
    output reg [3:0] alu_ctrl_input;
    output reg [4:0] WBreg_o;
    output reg [31:0] pc_add4_o;

    always @(posedge clk_i)
    begin
        if (!rst_i)
        begin
            instr_o <= 32'b00000000000000000000000000000000;
            WB_o <= 3'b000;
            Mem_o <= 2'b00;
            Exe_o <= 3'b000;
            data1_o <= 32'b00000000000000000000000000000000;
            data2_o <= 32'b00000000000000000000000000000000;
            immgen_o <= 32'b00000000000000000000000000000000;
            alu_ctrl_input <= 4'b0000;
            WBreg_o <= 5'b00000;
            pc_add4_o <= 32'b00000000000000000000000000000000;
        end
        else
        begin
            instr_o <= instr_i;
            WB_o <= WB_i;
            Mem_o <= Mem_i;
            Exe_o <= Exe_i;
            data1_o <= data1_i;
            data2_o <= data2_i;
            immgen_o <= immgen_i;
            alu_ctrl_input <= alu_ctrl_instr;
            WBreg_o <= WBreg_i;
            pc_add4_o <= pc_add4_i;
        end
    end


endmodule
