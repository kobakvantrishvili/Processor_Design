module data_memory(
	
	input 		          			CLOCK_50,
	input 		      [3:0]    	Mem_addr,
	input 		      [31:0]   	RF_Rd_data,
	input 		        				CNTRL_write_en,
	
	output		reg	[31:0]		Mem_data
);

// data memory
logic [31:0] memory [15:0];
logic [4:0]	 i;

initial 
	begin
		for (i=0; i<=15; i++) begin
			memory[i] = 0;
		end
	end

always @(posedge CLOCK_50)
	begin
	
		if(CNTRL_write_en == 1) memory[Mem_addr] = RF_Rd_data;
		
		Mem_data <= memory[Mem_addr];
		
	end

endmodule