module mux_y(
	
	input 		          		in_1, 		//addr_Rd
	input 		          		in_2,			//15
	input								select,
	
	output				reg		out
);


assign out = select ? in_2 : in_1; // if select is 1, MUX will output in_2, otherwise in_1

endmodule