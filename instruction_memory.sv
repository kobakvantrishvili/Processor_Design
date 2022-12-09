module instruction_memory(

	input 		      [3:0]    	PC_out,		 //tells instruction memory which instruction to read
	
	output		reg	[31:0]		IR_out
);

// instruction memory
logic [31:0] memory [15:0];

assign memory[0] = 32'b11100011101000010001000000010110;  // MOV R1, #22
assign memory[1] = 32'b11100011101000100010000000000101;  // MOV R2, #5
assign memory[2] = 32'b11100011101000110011000000000011;  // MOV R3, #3

assign memory[3] = 32'b11100000100000010000001100010010;  // ADD R0, R1, R2, LSL R3
assign memory[4] = 32'b11100000100100010000000010100010;  // ADDS R0, R1, R2, LSR #1
assign memory[5] = 32'b11100110000000010000000000010010;  // STR R0, [R1, R2]
assign memory[6] = 32'b00010010010100100000000000000010;  // SUBNES R0, R2, #2
assign memory[7] = 32'b10001010000000000000000000000100;  // BHI label
assign memory[8] = 32'b11100011101000100010000000000101;  // MOV R2, #5
assign memory[9] = 32'b11100011101000100010000000000101;  // MOV R2, #5
assign memory[10] = 32'b11100011101000100010000000000101; // MOV R2, #5
assign memory[11] = 32'b11100011101000010001000000010110; // MOV R1, #22
assign memory[12] = 32'b11100011101000100010000000000101; // MOV R2, #5



assign IR_out = memory[PC_out];


endmodule