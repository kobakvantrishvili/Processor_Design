module PCinc(

	input 		      [3:0]  		PC_out,

	output		reg	[3:0]			PC_next
);

assign PC_next = PC_out + 1;

endmodule