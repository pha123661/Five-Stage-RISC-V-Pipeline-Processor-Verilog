module IF_register (clk_i, rst_i,address_i, instr_i,pc_add4_i, address_o, instr_o,pc_add4_o, IFID_write, IFID_flush);

    input clk_i ;
    input rst_i;
    input [31:0] address_i;
    input [31:0] instr_i;
    input [31:0] pc_add4_i;
    input IFID_write;
    input IFID_flush;
    output reg [31:0] address_o;
    output reg [31:0] instr_o;
    output reg [31:0] pc_add4_o;

    always @(posedge clk_i)
    begin
        if (!rst_i)
        begin
            // reset
            address_o <= 32'b00000000000000000000000000000000;
            instr_o <= 32'b00000000000000000000000000000000;
            pc_add4_o <= 32'b00000000000000000000000000000000;
        end
        else if (~IFID_write)
	begin
	end
	else if (IFID_flush)
	begin
            address_o <= 32'b00000000000000000000000000000000;
            instr_o <= 32'b00000000000000000000000000000000;
            pc_add4_o <= 32'b00000000000000000000000000000000;
	end
	else
        begin
            address_o <= address_i;
            instr_o <= instr_i;
            pc_add4_o <= pc_add4_i;
        end
    end

endmodule
