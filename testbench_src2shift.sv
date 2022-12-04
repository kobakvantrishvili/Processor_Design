module testbench_src2shift();

logic 		         CLOCK_50;
logic		[2:0]			CTRL_select; // op, I
logic 	[4:0]  		IR_shamt5;			
logic		[3:0]			IR_rot;
logic		[1:0]			IR_sh;
logic						IR_4th;
logic		[23:0]		IR_imm;
logic		[31:0]		RF_Rm;
logic		[31:0]		RF_Rs;
	
	
// outputs
logic 	[31:0]  		src2;
logic 			  		was_shifted;
logic 			  		carryBit;
	

	
	
src2shift inst (CLOCK_50, CTRL_select, IR_shamt5, IR_rot, IR_sh, IR_4th, IR_imm, RF_Rm, RF_Rs, src2, was_shifted, carryBit);
	
	
always
  begin
    #20 CLOCK_50 = 1;
    #20 CLOCK_50 = 0;
  end
  
initial
  begin
  
/* data processing instruction where second operand is register */
#20
    CTRL_select = 3'b000;
	 IR_shamt5 = 2;
	 IR_sh = 2'b00;
	 IR_4th = 0;
	 RF_Rm = 8;	 				// logical shift left by 2 with immediate value (Carry should be 0)
#40
	 IR_4th = 1;
	 RF_Rs = 2;					// logical shift left by 2 with register Rs (Carry should be 0)
#40
	 IR_sh = 2'b10;
	 RF_Rs = 4;					// arithmetic shift right by 4 with register Rs (Carry should be 1)
#40
	 RF_Rm = -4;
	 RF_Rs = 1;					// arithmetic shift right by 3 with register Rs (Carry should be 0)
#40
	 RF_Rm = -56;
	 IR_sh = 2'b11;
	 RF_Rs = 8;					// right rotate  by 4 with register Rs (Carry should be 1)
#40
	 CTRL_select = 4'b000;
	 RF_Rs = 0;					// no shifting 

/* data processing instruction where second operand is immediate */
#40
	 CTRL_select = 4'b001;
	 IR_imm = 60;
	 IR_rot = 3;				// right rotate  by 3 with register Rs (Carry should be 1)
#40
	 IR_rot = 0;				// no shifting

/* memory access instruction where second operand is immediate */
#40
	 CTRL_select = 4'b010;
	 IR_imm = 25;				// no shifting

/* memory access instruction where second operand is register */
#40
	 CTRL_select = 4'b011;
	 IR_shamt5 = 5;
	 IR_sh = 2'b01;
	 RF_Rm = 12;				// logical shift right by 5 with immediate value (Carry should be 0)
#40
	 RF_Rm = 16;
	 IR_shamt5 = 0;			// logical shift right by 5 with register Rs (Carry should be 0)				

/* branch instruction */
#40
	CTRL_select = 4'b101;
	IR_imm = 9;					// no shifting
	 
	 
  end
	
	

endmodule