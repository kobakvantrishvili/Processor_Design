module reg_file(
	
	input 		          			CLOCK_50,
	input 		      [3:0]		   IR_ARn,
	input 		      [3:0]   		IR_ARs,
	input 		      [3:0]  		IR_ARm,
	input 		      [3:0]  		mux_ARd_or_15,
	input 		        				CNTRL_write_en_ARd,
	input 		      [3:0]  		PC_next,
	input 		      [31:0]  		mux_ALU_result_or_DMEM_data,
	
	output		reg	[31:0]		Rn,
	output		reg	[31:0]		Rs,
	output		reg	[31:0]		Rm,
	output		reg	[31:0]		Rd,
	output		reg	[3:0]			PC_out // only needs to count up to 16 since only 16 instructions
);

// register memory
logic [31:0] memory [15:0]; //there are 15 registers from R0 to R15
logic [4:0]  i;

logic [2:0] counter = 0;
logic [2:0] counter_max = 3'b110;
logic state = 0;

initial 
	begin
		for (i=0; i<=15; i++) begin
			memory[i] = 0;
		end
		
		PC_out <= 0;
	end

always @(posedge CLOCK_50)
	begin
		
		// if write_enable is 1, result from ALU or DMEM is written in destination register
		if(CNTRL_write_en_ARd == 1) memory[mux_ARd_or_15] = mux_ALU_result_or_DMEM_data;
					
		// If Rd writes in the PC (R15) register it has priority over PC_next, so PC_next won't rewrite it
		if(mux_ARd_or_15 != 15 || CNTRL_write_en_ARd != 1) memory[15] = PC_next;
		
		Rn <= memory[IR_ARn];
		Rs <= memory[IR_ARs];
		Rm <= memory[IR_ARm];
		Rd <= memory[mux_ARd_or_15];
			
		if (state == 0) begin
			PC_out <= memory[15];
			state <= 1;
		end
		else begin
			counter <= counter + 1;
			if(counter == counter_max - 1) begin
				state <= 0;
				counter <= 0;
			end
		end
	end


endmodule