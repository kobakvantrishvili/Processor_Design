module reg_file(
	
	input 		          			CLOCK_50,
	input 		      [3:0]		   IR_ARn,
	input 		      [3:0]   		IR_ARs,
	input 		      [3:0]  		IR_ARm,
	input 		      [3:0]  		mux_ARd_or_15,
	input 		        				CNTRL_write_en_ARd,
	input 		      [15:0]  		PC_next,
	input 		        				mux_ALU_result_or_DMEM_data,
	
	output		reg	[3:0]			Rn,
	output		reg	[3:0]			Rs,
	output		reg	[3:0]			Rm,
	output		reg	[3:0]			Rd,
	output		reg	[15:0]		PC_out
);

// register memory
logic [31:0] memory [15:0]; //there are 15 registers from R0 to R15

always @(posedge CLOCK_50)
	begin
		if(CNTRL_write_en == 1) begin
			Rd <= mux_ALU_result_or_DMEM_data;
			memory[mux_ARd_or_15] <= Rd;
		end
		else begin
			Rd <= memory[mux_ARd_or_15];
		end
		Rn <= memory[IR_ARn];
		Rs <= memory[IR_ARs];
		Rm <= memory[IR_ARm];
		
		PC_out  <= PC_next;
		memory[15] <= PC_out;
	end


endmodule