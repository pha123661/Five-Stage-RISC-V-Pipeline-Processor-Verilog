
`timescale 1 ns/10 ps 

module ALU_1bit_tb;

    reg a, b, Ainvert, Binvert, Cin;
    reg [1:0] operation;
    wire sum, carry;

    // duration for each bit = 20 * timescale = 20 * 1 ns  = 20ns
    localparam period = 20;  
    ALU_1bit UUT(a, b, Ainvert, Binvert, Cin, operation, sum, carry);
    
    initial
    	begin 
    		$dumpfile("alu.vcd");
    		$dumpvars(0, ALU_1bit_tb);
    	end
    	
    
    initial // initial block executes only once
        begin
        	
            // values for a and b
            a = 1;
            b = 1;
            Ainvert = 0;
            Binvert = 0;
            Cin = 0;
            operation = 2'b00;
            #1
			$display("sum %d", sum);
			$display("carry %d", carry);
			$display("===============");
            #period; // wait for period 

            a = 1;
            b = 1;
            Ainvert = 0;
            Binvert = 0;
            Cin = 0;
            operation = 2'b01;
            #1
			$display("sum %d", sum);
			$display("carry %d", carry);
			$display("===============");
            #period;

            a = 1;
            b = 1;
            Ainvert = 0;
            Binvert = 0;
            Cin = 0;
            operation = 2'b11;
            #1
			$display("sum %d", sum);
			$display("carry %d", carry);
			$display("===============");
            #period;
            
        end
        
endmodule
