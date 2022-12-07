module testbench();
	
	logic      		CLOCK_50;
	logic	[3:0]		flags_out;
	logic	[31:0]	result_out;

always
  begin
    #20 CLOCK_50 = 1;
    #20 CLOCK_50 = 0;
  end	

//-suppress 2388
Processor inst (CLOCK_50, flags_out, result_out);
	
endmodule