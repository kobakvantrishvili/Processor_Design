module testbench_CTRL();

	logic 		      CLOCK_50;
	logic		[31:0]	IR_in;
	logic		[3:0]		Flags_in; // NZCV
	
	
	logic					Wen_ARd;
	logic					Wen_Dmem;
	logic					Wen_Flags;
	logic		[4:0]		cmd;
	logic					select_X;
	logic					select_Y;
	logic		[1:0]		select_src1;
	logic		[2:0]		select_src2shift;

controller inst (CLOCK_50, IR_in, Flags_in, Wen_ARd, Wen_Dmem, Wen_Flags, cmd, select_X, select_Y, select_src1, select_src2shift);


always
  begin
    #20 CLOCK_50 = 1;
    #20 CLOCK_50 = 0;
  end

  
initial
  begin
	 Flags_in = 4'b0000;
#20
    IR_in = 32'b11100000100000010000001100010010; // ADD R0, R1, R2, LSL R3
	/* output:
		1
		0
		0
		00100
		0
		0
		00
		000	*/
#40
	 IR_in = 32'b11100000100000010000000100000100; // ADD R0, R1, R4, LSL #2
	/* output:
		1
		0
		0
		00100
		0
		0
		00
		000	*/
	 
#40
	 Flags_in = 4'b0100;
	 IR_in = 32'b00000010010100010000000000000010; // SUBEQS R0, R1, #2
	/* output:
		1
		0
		1
		00010
		0
		0
		00
		001	*/
#40
	 IR_in = 32'b00010010010000100000000000000010; // SUBNE R0, R2, #2
	/* output:
		0
		0
		0
		00010
		1
		0
		00
		001	*/
#40
	 IR_in = 32'b00000100000100010000000000000011; //LDR R0, [R1, #3]
	/* output:
		1
		0
		0
		00100
		1
		0
		00
		010	*/
#40
	 IR_in = 32'b00000110000000010000000000010010; // STR R0, [R1, R2]
	/* output:
		0
		1
		0
		00100
		0
		0
		00
		011	*/
#40
	 Flags_in = 4'b0010;
	 IR_in = 32'b10001010000000000000000000001000; // BHI label
	/* output:
		0
		0
		0
		00100
		0
		1
		10
		101	*/
#40
	 Flags_in = 4'b0000;
	 IR_in = 32'b10001010000000000000000000001000; // BHI label
	/* output:
		0
		0
		0
		00100
		0
		1
		10
		101	*/
  end
  
endmodule