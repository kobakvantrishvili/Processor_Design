module mux_x(
	
	input 			[31:0]			in_1, 		//ALU result
	input 			[31:0]         in_2,			//DMEM data
	input									select,
	
	output	reg	[31:0]			Rd_data
);


assign Rd_data = select ? in_2 : in_1; // if select is 1, MUX will output in_2, otherwise in_1

endmodule