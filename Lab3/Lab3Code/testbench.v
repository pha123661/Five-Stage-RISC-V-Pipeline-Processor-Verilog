/***************************************************
Student Name: 
Student ID: 
***************************************************/

`timescale 1ns/1ps
`define CYCLE_TIME 10			
`define END_COUNT 100

module testbench;

reg         clk;
reg         rst_n;
integer     count;
integer     fp_w;

Simple_Single_CPU cpu(
        .clk_i(clk),
		.rst_i(rst_n)
		);

always #(`CYCLE_TIME/2) clk = ~clk;	

initial begin
	$dumpfile("lab3.vcd");
    $dumpvars(0, testbench);
end
	
initial  begin
    fp_w = $fopen("CO_Result.txt");
	clk = 0;
    rst_n = 0;
	count = 0;
    #(`CYCLE_TIME)      rst_n = 1;
    #(`CYCLE_TIME*`END_COUNT)	$fclose(fp_w); $finish;
end

always@(posedge clk) begin
    count = count + 1;
	if( count == `END_COUNT ) begin 
    $fdisplay(fp_w, "r0 = %3d, r1 = %3d, r2 = %3d, r3 = %3d, \nr4 = %3d, r5 = %3d, r6 = %3d, r7 = %3d, \nr8 = %3d, r9 = %3d, r10 = %2d, r11 = %2d",
	          cpu.RF.Reg_File[0], cpu.RF.Reg_File[1], cpu.RF.Reg_File[2], cpu.RF.Reg_File[3], cpu.RF.Reg_File[4], 
			  cpu.RF.Reg_File[5], cpu.RF.Reg_File[6], cpu.RF.Reg_File[7], cpu.RF.Reg_File[8], cpu.RF.Reg_File[9], 
			  cpu.RF.Reg_File[10],cpu.RF.Reg_File[11]
			  );
	$display("r0 = %3d, r1 = %3d, r2 = %3d, r3 = %3d, \nr4 = %3d, r5 = %3d, r6 = %3d, r7 = %3d, \nr8 = %3d, r9 = %3d, r10 = %2d, r11 = %2d",
	          cpu.RF.Reg_File[0], cpu.RF.Reg_File[1], cpu.RF.Reg_File[2], cpu.RF.Reg_File[3], cpu.RF.Reg_File[4], 
			  cpu.RF.Reg_File[5], cpu.RF.Reg_File[6], cpu.RF.Reg_File[7], cpu.RF.Reg_File[8], cpu.RF.Reg_File[9], 
			  cpu.RF.Reg_File[10],cpu.RF.Reg_File[11]
			  );
	end
end
  
endmodule
