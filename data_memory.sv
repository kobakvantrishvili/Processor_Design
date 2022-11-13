module data_memory(
	
	input 		      [19:16]    	Mem_addr,
	input 		      [31:0]   	reg_file_Rd_data,
	input 		        				controller_write_en,
	
	output		reg	[31:0]		memory_data
);