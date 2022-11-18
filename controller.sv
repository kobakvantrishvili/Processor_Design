/*module controller(
	
	input 		          			CLOCK_50,
	input				[31:0]			IM_in,
	input				[3:0]				Flags_in,
	
	
	output	reg						Wen_ARd,
	output	reg						Wen_Dmem,
	output	reg						Wen_ALU,
	output	reg	[3:0]				update_Flags

);//Unfinished

logic [1:0]	  op   = CNTRL_in[27:26];
logic [31:28] cond = CNTRL_in[31:28];


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
			imm24 <= memory[PC_out][23:0];
		end
	end


endmodule
*/