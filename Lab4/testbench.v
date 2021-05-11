/***************************************************
Student Name:林俊宇 李勝維
Student ID: group31_0816038_0711239
***************************************************/

`timescale 1ns / 1ps
`define CYCLE_TIME 50
`define END_COUNT 154

module testbench;

reg clk, rst_n;
integer i, f;


Simple_Single_CPU CPU(
	.clk_i(clk),
	.rst_i(rst_n)
	);

always #(`CYCLE_TIME/2) clk = ~clk;

initial begin
	$dumpfile("Simple_CPU.lxt");
    f = $fopen("result.txt","w");
    $dumpvars(0, testbench);
end
integer count;
initial begin
	clk = 0;
	rst_n = 0;
    count = 0;
	#(`CYCLE_TIME) rst_n = 1;
	#(`CYCLE_TIME*`END_COUNT) $finish;
end

always@(posedge clk)
begin
	if(rst_n)
    begin
        count = count + 1;
		$fwrite(f, "PC = %b\n", CPU.PC.pc_o);
        $fwrite(f, "Instrction = %b\n", CPU.IM.instr_o);
        $fwrite(f, "Register\n");
        for (i = 0; i < 32; i++)
        begin
            if(CPU.RF.Reg_File[i] != 0)
            begin
		        $fwrite(f, "R%2d = %d\n", i, CPU.RF.Reg_File[i]);
            end
        end
        $fwrite(f, "Data Memory\n");
        for(i = 0; i < 4096; i++)
        begin
            if(CPU.Data_Memory.memory[i] != 0)
            begin
                $fwrite(f, "DataMemory[%4d] = %d\n", i, CPU.Data_Memory.memory[i]);
            end
        end
		$fwrite(f, "\n");
	end
end


endmodule

