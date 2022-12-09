module testbench_RF();

logic		        			CLOCK_50;
logic		   [3:0]		   IR_ARn;
logic		   [3:0]   		IR_ARs;
logic	      [3:0]  		IR_ARm;
logic	      [3:0]  		mux_ARd_or_15;
logic			 				CNTRL_write_en_ARd;
logic       [15:0]  		PC_next;
logic			[31:0]		mux_ALU_result_or_DMEM_data;

//outputs
logic			[31:0]			Rn;
logic			[31:0]			Rs;
logic			[31:0]			Rm;
logic			[31:0]			Rd;
logic			[15:0]		PC_out;


always
  begin
    #20 CLOCK_50 = 1;
    #20 CLOCK_50 = 0;
  end


initial
  begin
	 PC_next = 0;
#20
	 // in R7 write 19
	 mux_ARd_or_15 = 7;
	 mux_ALU_result_or_DMEM_data = 19;
	 CNTRL_write_en_ARd = 1;
#200
	 // in R3 write 21
	 mux_ARd_or_15 = 3;
	 mux_ALU_result_or_DMEM_data = 21;
#200
	 // in R4 write 20
	 mux_ARd_or_15 = 4;
	 mux_ALU_result_or_DMEM_data = 20;
#200
	 // in R15 write 99
	 mux_ARd_or_15 = 15;
	 mux_ALU_result_or_DMEM_data = 2;
#200
	 // in R2 write 27
	 mux_ARd_or_15 = 2;
	 mux_ALU_result_or_DMEM_data = 27;
#200
	 CNTRL_write_en_ARd = 0;
#200
	 IR_ARn = 7;
	 IR_ARs = 3;
	 IR_ARm = 4;
	 mux_ARd_or_15 = 2;
#200
    IR_ARn = 3;
	 IR_ARs = 4;
	 IR_ARm = 2;
	 mux_ARd_or_15 = 15;
  end
 
 reg_file inst0 (CLOCK_50, IR_ARn, IR_ARs, IR_ARm, mux_ARd_or_15, CNTRL_write_en_ARd, PC_next, mux_ALU_result_or_DMEM_data, Rn, Rs, Rm, Rd, PC_out);
 PCinc inst1(PC_out, PC_next);
  

endmodule