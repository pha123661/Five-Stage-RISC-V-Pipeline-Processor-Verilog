/***************************************************
Student Name:
Student ID: Lab4_release
***************************************************/

`timescale 1ns / 1ps

module Data_Memory(
	input 			   clk_i,
	input 		[31:0] addr_i,
	input 		[31:0] data_i,
	input 	           MemRead_i,
	input 			   MemWrite_i,
	output wire [31:0] data_o
);

reg		[7:0]	Mem [0:16383];
integer			i;
wire	[31:0]	memory [0:4095];

genvar idx;
generate
    for( idx = 0; idx < 4096; idx = idx +1)
    begin
        assign memory[idx] = {Mem[idx*4+3], Mem[idx*4+2], Mem[idx*4+1], Mem[idx*4]};
    end
 endgenerate

initial begin
	for(i=0; i< 4*4096; i=i+1)
		Mem[i] = 8'b0;
end

always@(negedge clk_i) begin
    if(MemWrite_i) begin
		Mem[addr_i*4+3] <= data_i[31:24];
		Mem[addr_i*4+2] <= data_i[23:16];
		Mem[addr_i*4+1] <= data_i[15:8];
		Mem[addr_i*4]   <= data_i[7:0];
	end
end

assign data_o = (MemRead_i)?{Mem[addr_i*4+3], Mem[addr_i*4+2], Mem[addr_i*4+1], Mem[addr_i*4]}:32'd0;

endmodule

