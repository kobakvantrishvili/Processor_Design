module instruction_memory(

	input 		      [15:0]    	PC_out,		 //tells instruction memory which instruction to read
	
	output		reg	[31:0]		IM_out
);

// instruction memory
logic [31:0] memory [15:0];

//assign memory[9] = 29; //just for testing

assign IM_out = memory[PC_out];


endmodule