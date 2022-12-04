module testbench_ALU();

logic 					CLOCK_50;
logic		[31:0]		src1;
logic 	[31:0]  		src2;
logic						src2shift_carry;
logic						was_shifted;
logic		[3:0]			flags; 		// from flag register
logic		[3:0]			CTRL_cmd;
	
	
//outputs
logic   [3:0]  		NZCV;
logic   [31:0]  		ALU_output;
	

ALU inst (CLOCK_50, src1, src2, src2shift_carry, was_shifted, flags, CTRL_cmd, NZCV, ALU_output);
	
	
always
  begin
    #20 CLOCK_50 = 1;
    #20 CLOCK_50 = 0;
  end

  
initial
  begin
	 src1 = 32'h7FFFFFFF;
	 src2 = 32'hFFFFFFFF;
	 src2shift_carry = 0;
	 was_shifted = 0;
	 flags = 4'b0000;
#20
    CTRL_cmd = 4'b0000;
#40
	 CTRL_cmd = 4'b0001;
#40
	 CTRL_cmd = 4'b0010;
#40
	 CTRL_cmd = 4'b0011;
#40
	 CTRL_cmd = 4'b0100;
#40
	 CTRL_cmd = 4'b0101;
#40
	 CTRL_cmd = 4'b0110;
#40
    CTRL_cmd = 4'b0111;
#40
    CTRL_cmd = 4'b1000;
#40
    CTRL_cmd = 4'b1001;
#40
    CTRL_cmd = 4'b1010;
#40
    CTRL_cmd = 4'b1011;
#40
    CTRL_cmd = 4'b1100;
#40
    CTRL_cmd = 4'b1101;
#40
    CTRL_cmd = 4'b1110;
#40
    CTRL_cmd = 4'b1111;
#40
    src2shift_carry = 1;
	 was_shifted = 1;
#40
    CTRL_cmd = 4'b1101; // Move
#40
	was_shifted = 0;
	flags[1] = 1;
#40
    CTRL_cmd = 4'b0111; // reverse substract with carry
#40
    CTRL_cmd = 4'b1110; // bitwise clear
  end

	
endmodule