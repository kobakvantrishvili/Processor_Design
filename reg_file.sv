module data_memory(
	
	input 		      		    	IR_addr_Rn,
	input 		         			IR_addr_Rs,
	input 		        				IR_addr_Rm,
	input 		        				mux_addr_Rd_or_15,
	input 		        				CNTRL_write_en_addr_Rd,
	input 		        				PC_next,
	input 		        				mux_ALU_result_or_DMEM_data,
	
	output		reg	[19:16]		Rn,
	output		reg	[11:8]		Rs,
	output		reg	[3:0]			Rm,
	output		reg	[15:12]		Rd,
	output		reg	[31:0]		pc_out
);