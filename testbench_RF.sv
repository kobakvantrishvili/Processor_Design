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

always @(posedge CLOCK_50)
	begin
		PC_next = PC_next + 1;
	end

initial
  begin
	 PC_next = 0;
#40
	 // in R7 write 19
	 mux_ARd_or_15 = 7;
	 mux_ALU_result_or_DMEM_data = 19;
	 CNTRL_write_en_ARd = 1;
#40
	 // in R3 write 21
	 mux_ARd_or_15 = 3;
	 mux_ALU_result_or_DMEM_data = 21;
#40
	 // in R4 write 20
	 mux_ARd_or_15 = 4;
	 mux_ALU_result_or_DMEM_data = 20;
#40
	 // in R15 write 99
	 mux_ARd_or_15 = 15;
	 mux_ALU_result_or_DMEM_data = 99;
#40
	 // in R2 write 27
	 mux_ARd_or_15 = 2;
	 mux_ALU_result_or_DMEM_data = 27;
#40
	 CNTRL_write_en_ARd = 0;
#40
	 IR_ARn = 7;
	 IR_ARs = 3;
	 IR_ARm = 4;
	 mux_ARd_or_15 = 2;
#40
    IR_ARn = 3;
	 IR_ARs = 4;
	 IR_ARm = 2;
	 mux_ARd_or_15 = 15;
  end
 
 reg_file inst (CLOCK_50, IR_ARn, IR_ARs, IR_ARm, mux_ARd_or_15, CNTRL_write_en_ARd, PC_next, mux_ALU_result_or_DMEM_data, Rn, Rs, Rm, Rd, PC_out);
  

endmodule