module instruction_memory(
	
	input 		          			CLOCK_50,
	input 		      [15:0]    	PC_out,		 //tells instruction memory which instruction to read
	
	output		reg	[3:0]				ARn,
	output		reg	[3:0]				ARd,
	output		reg	[3:0]				ARm,
	output		reg	[3:0]				ARs,
	output		reg	[23:0]			imm24,
	output		reg	[31:0]			CNTRL_in //?

);

// instruction memory
logic [31:0] memory [15:0];

logic [1:0]	  op   = memory[PC_out][27:26];
logic [31:28] cond = memory[PC_out][31:28];


always @(posedge CLOCK_50)
	begin

		if(op == 2'b00) begin	// op is 00 for Data Processing instructions
			ARn <= memory[PC_out][19:16];
			ARd <= memory[PC_out][15:12];
			// if immediate bit, I, is 0 instruction doesn't contain immediate value
			if(memory[PC_out][25] == 0) begin
				ARm <= memory[PC_out][3:0];
				// if 4th bit is 1, instruction doesn't have immediate shift length
				if(memory[PC_out][4] == 1) ARs <= memory[PC_out][11:8];
				else								imm24[11:7] <= memory[PC_out][11:7]; //shamt5
			end
			else begin
				imm24[11:0] <= memory[PC_out][11:0]; //immediate alignment(rot) [11:8] and 8-bit immediate(imm8) [7:0]
			end
		end
		
		
		if(op == 2'b01) begin	// op is 01 for Memory Access instructions
			ARn <= memory[PC_out][19:16];
			ARd <= memory[PC_out][15:12];
			// if immediate bit, I, is 1 instruction doesn't contain immediate value
			if(memory[PC_out][25] == 1) begin
				ARm <= memory[PC_out][3:0];
				// 4th bit is set to 1
				imm24[11:7] <= memory[PC_out][11:7]; //shamt
			end
			else begin
				imm24[11:0] <= memory[PC_out][11:0]; //12-bit immediate(imm12)
			end
		end
		
		
		if(op == 2'b10) begin	// op is 01 for Memory Access instructions
			imm24 <= memory[PC_out][23:0]
		end
	end


endmodule