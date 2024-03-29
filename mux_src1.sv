module mux_src1(
	
	input 		      [31:0]    	Rn, 				//data and memory access
	input 		      [31:0]   	Rs, 				//multiplication
	input 		      [3:0]  		PC_out,			//for jump
	input					[1:0]			select,
	
	output		reg	[31:0]		src1
);


always @(Rn or Rs or PC_out or select)
begin

	case (select)
		2'b00 :  src1 <= Rn;
		2'b01 :  src1 <= Rs;
		2'b10 :  src1 <= PC_out;
	endcase

end

endmodule