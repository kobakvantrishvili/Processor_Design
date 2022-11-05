module mux_src1(
	
	input 		          		Rn, 				//data and memory access
	input 		          		Rs, 				//multiplication
	input 		          		PC_out,			//for jump
	input					[1:0]		select,
	
	output				reg		src1
);


always @(Rn || Rs || PC_out || select)
begin

	case (select)
		2'b00 : src1 <= Rn;
		2'b01 : src1 <= Rs;
		2'b10 : src1 <= PC_out;
		//add default case
	endcase

end

endmodule
