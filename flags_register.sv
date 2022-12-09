module flags_register(

	input 		          			CLOCK_50,
	input 		      [3:0]  		NZCV,
	input									CNTRL_update_en,
	

	output		reg	[3:0]			flags 		// Negative, Zero, Carry and Overflow flags
);


logic [3:0] flags_memory = 0;

always @(posedge CLOCK_50)
	begin
		// If updates are enabled write appropriate flags in NZCV
		if(CNTRL_update_en == 1) flags_memory <= NZCV;
		
		flags <= flags_memory;
	end


endmodule