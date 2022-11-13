module mux_x(
	
	input 		          		in_1, 		//ALU result
	input 		          		in_2,			//DMEM data
	input								select,
	
	output				reg		Rd_data
);


assign Rd_data = select ? in_2 : in_1; // if select is 1, MUX will output in_2, otherwise in_1

endmodule