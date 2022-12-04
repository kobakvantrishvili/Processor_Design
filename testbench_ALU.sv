module testbench_ALU();

logic 					CLOCK_50;
logic		[31:0]		src1;
logic 	[31:0]  		src2;
logic						src2shift_carry;
logic						was_shifted;
logic		[3:0]			flags; 		// from flag register
logic		[4:0]			CTRL_cmd;
	
	
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
	 src1 = 5;
	 src2 = -6;
	 src2shift_carry = 0;
	 was_shifted = 0;
	 flags = 4'b0000;
#20
    CTRL_cmd = 5'b00000;
#40
	 CTRL_cmd = 5'b00001;
#40
	 CTRL_cmd = 5'b00010;
#40
	 CTRL_cmd = 5'b00011;
#40
	 CTRL_cmd = 5'b00100;
#40
	 CTRL_cmd = 5'b00101;
#40
	 CTRL_cmd = 5'b00110;
#40
    CTRL_cmd = 5'b00111;
#40
    CTRL_cmd = 5'b01000;
#40
    CTRL_cmd = 5'b01001;
#40
    CTRL_cmd = 5'b01010;
#40
    CTRL_cmd = 5'b01011;
#40
    CTRL_cmd = 5'b01100;
#40
    CTRL_cmd = 5'b01101;
#40
    CTRL_cmd = 5'b01110;
#40
    CTRL_cmd = 5'b01111;
#40
    CTRL_cmd = 5'b10000;
#40
    src2shift_carry = 1;
	 was_shifted = 1;
#40
    CTRL_cmd = 5'b01101; // Move
#40
	was_shifted = 0;
	flags[1] = 1;
#40
    CTRL_cmd = 5'b00111; // reverse substract with carry
#40
    CTRL_cmd = 5'b01110; // bitwise clear
  end

	
endmodule