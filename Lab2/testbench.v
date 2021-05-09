/***************************************************
Student Name: 
Student ID: 
***************************************************/
`timescale 1ns/1ps

module testbench;

parameter PATTERN_NUMBER = 6'd30;

reg          clk;
reg          rst_n;
reg [32-1:0] src1_in;
reg [32-1:0] src2_in;
reg  [4-1:0] operation_in;

reg  [8-1:0] mem_src1   [0:(PATTERN_NUMBER*4-1)];
reg  [8-1:0] mem_src2   [0:(PATTERN_NUMBER*4-1)];
reg  [8-1:0] mem_opcode [0:(PATTERN_NUMBER-1)];
reg  [8-1:0] mem_result [0:(PATTERN_NUMBER*4-1)];
reg  [8-1:0] mem_zcv    [0:(PATTERN_NUMBER-1)];

reg  [6-1:0] pattern_count;
reg          start_check;
reg  [6-1:0] error_count;
reg  [6-1:0] correct_count;
reg  [6-1:0] error_count_tmp;

wire [32-1:0] result_out;
wire          zero_out;
wire          cout_out;
wire          overflow_out;

wire  [3-1:0] zcv_out;
wire [32-1:0] result_correct;
wire  [3-1:0] zcv_correct;
wire  [4-1:0] opcode_tmp;

	assign zcv_out = {zero_out, cout_out, overflow_out};
	assign opcode_tmp = mem_opcode[pattern_count];
	assign result_correct = {mem_result[4*(pattern_count-1) + 5'd3],
							mem_result[4*(pattern_count-1) + 5'd2],
							mem_result[4*(pattern_count-1) + 5'd1],
							mem_result[4*(pattern_count-1) + 5'd0]};
	assign zcv_correct = mem_zcv[pattern_count-1];

initial begin
	clk   = 1'b0;
	rst_n = 1'b0;
	src1_in = 32'd0;
	src2_in = 32'd0;
	operation_in = 4'h0;
	start_check = 1'd0;
	error_count = 6'd0;
    correct_count = 6'd0;
	error_count_tmp = 6'd0;
	pattern_count = 6'd0;

	$readmemh("src1.txt", mem_src1);
	$readmemh("src2.txt", mem_src2);
	$readmemh("op.txt", mem_opcode);
	$readmemh("result.txt", mem_result);
	$readmemh("zcv.txt", mem_zcv);

	#100 rst_n = 1'b1;
	start_check = 1'd1;

	//$dumpfile("alu.vcd");
  	//$dumpvars(0,testbench);
end

always #5 clk = ~clk;

alu alu(
	.rst_n(rst_n),
	.src1(src1_in),
	.src2(src2_in),
	.ALU_control(operation_in),
	.result(result_out),
	.zero(zero_out),
	.cout(cout_out),
	.overflow(overflow_out)
);


always@(posedge clk) begin
	if(pattern_count == (PATTERN_NUMBER+1)) begin
		if(error_count == 6'd0) begin
			$display("*      Congratulation! All data are correct!      *");
			$display("***************************************************");
            $display("Correct Count: %2d", correct_count );
		end
        else begin
        end
        $finish;
	end
	else if(rst_n) begin
		src1_in			<= {mem_src1[4*pattern_count + 6'd3],
							mem_src1[4*pattern_count + 6'd2],
							mem_src1[4*pattern_count + 6'd1],
							mem_src1[4*pattern_count + 6'd0]};
		src2_in			<= {mem_src2[4*pattern_count + 6'd3],
							mem_src2[4*pattern_count + 6'd2],
							mem_src2[4*pattern_count + 6'd1],
							mem_src2[4*pattern_count + 6'd0]};
		operation_in	<= opcode_tmp;
		pattern_count	<= pattern_count + 6'd1;
	end
end

always@(posedge clk) begin
	if(start_check) begin
		if(pattern_count==0) begin
			$display("***************************************************");
			$display("*             PATTERN RESULT TABLE                *");
			$display("***************************************************");
			$display("* PATTERN *              Result             * ZCV *");
			$display("***************************************************");
		end
		else if(pattern_count < (PATTERN_NUMBER+1)) begin
			if(result_out == result_correct) begin
				if(zcv_out != zcv_correct) begin
					$display("* No.%2d error!                                    *",pattern_count);
					$display("* Correct result: %h     Correct ZCV: %b   *",result_correct, zcv_correct[3-1:0]);
					$display("* Your result: %h        Your ZCV: %b      *",result_out, zcv_out);
					$display("***************************************************");
					error_count <= error_count + 6'd1;
				end
                else begin
                    correct_count <= correct_count + 6'd1;
                end
			end
			else begin
				$display("* No.%2d error!                                    *",pattern_count);
				$display("* Correct result: %h     Correct ZCV: %b   *",result_correct, zcv_correct[3-1:0]);
				$display("* Your result: %h        Your ZCV: %b      *",result_out, zcv_out);
				$display("***************************************************");
				error_count <= error_count + 6'd1;
			end
		end
	end
end

endmodule
