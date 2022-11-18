module testbench_DM();

logic		          			CLOCK_50;
logic		      [15:0]    	Mem_addr;
logic		      [31:0]   	RF_Rd_data;
logic	        					CNTRL_write_en;
	
logic				[31:0]		Mem_data; // output


always
  begin
    #20 CLOCK_50 = 1;
    #20 CLOCK_50 = 0;
  end

initial
  begin
	 Mem_addr = 4;
	 RF_Rd_data = 20;
	 CNTRL_write_en = 1;
#100
	 Mem_addr = 4;
	 RF_Rd_data = 20;
	 CNTRL_write_en = 0;
#100
	 Mem_addr = 6;
	 RF_Rd_data = 5;
	 CNTRL_write_en = 1;
#100
	 Mem_addr = 7;
	 RF_Rd_data = 1;
	 CNTRL_write_en = 1;
#100
	 Mem_addr = 6;
	 CNTRL_write_en = 0;
#100
    Mem_addr = 7;
	 CNTRL_write_en = 0;
  end
 
 data_memory inst (CLOCK_50, Mem_addr, RF_Rd_data, CNTRL_write_en, Mem_data);
  

endmodule