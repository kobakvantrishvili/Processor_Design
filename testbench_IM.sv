module testbench_IM();

logic		      [15:0]    	PC_out;
	
logic				[31:0]		IM_out; // output


initial
  begin
	 PC_out = 0;
#100
	 PC_out = 4;
#100
	 PC_out = 9;
#100
	 PC_out = 6;
#100
	 PC_out = 13;
  end
 
 instruction_memory inst (PC_out, IM_out);
  

endmodule