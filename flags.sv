module flags(

	input 		          			CLOCK_50,
	input 		      [3:0]  		NZCV,
	input									CNTRL_update_en,
	

	output		reg	[3:0]			flags 		// Negative, Zero, Carry and Overflow flags
);

always @(posedge CLOCK_50)
	begin
		// If updates are enabled write appropriate flags in NZCV
		if(CNTRL_update_en == 1) flags <= NZCV;
	end


endmodule