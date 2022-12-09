module Processor(
	input 		          			CLOCK_50,

	output	reg	[3:0]				flags_out,
	output	reg	[31:0]			result_out
);


logic [3:0]  	PC_out;
logic [31:0] 	instruction;

logic [3:0] 	flags;
logic				Wen_ARd;
logic				Wen_Dmem;
logic				Wen_Flags;
logic	[4:0]		cmd;
logic				select_X;
logic				select_Y;
logic	[1:0]		select_src1;
logic	[2:0]		select_src2shift;

logic [3:0] 	mux_Y_out;

logic [3:0]  	PC_next;

logic	[31:0]	Rn;
logic	[31:0]	Rs;
logic	[31:0]	Rm;
logic	[31:0]	Rd;

logic [31:0]	mux_src1_out;

logic [31:0]  	src2shift_out;
logic		  		was_shifted;
logic		  		carryBit;

logic [3:0]		NZCV;
logic [31:0]  	ALU_output;

logic [31:0] 	DMEM_output;

logic [31:0] 	mux_X_out;


instruction_memory inst0 (PC_out, instruction);
/*------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

controller inst1 (CLOCK_50, instruction, flags, Wen_ARd, Wen_Dmem, Wen_Flags, cmd, select_X, select_Y, select_src1, select_src2shift);
/*------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

mux_y inst2 (instruction[15:12], 4'b1111, select_Y, mux_Y_out);
/*------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

PCinc inst3 (PC_out, PC_next);
/*------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

reg_file inst4 (CLOCK_50, instruction[19:16], instruction[11:8], instruction[3:0], mux_Y_out, Wen_ARd, PC_next, mux_X_out, Rn, Rs, Rm, Rd, PC_out);
/*------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

mux_src1 inst5 (Rn, Rs, PC_out, select_src1, mux_src1_out);
/*------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

src2shift inst6 (CLOCK_50, select_src2shift, instruction[11:7], instruction[11:8], instruction[6:5], instruction[4], instruction[23:0], Rm, Rs, src2shift_out, was_shifted, carryBit);
/*------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

ALU inst7 (CLOCK_50, mux_src1_out, src2shift_out, carryBit, was_shifted, flags, cmd, NZCV, ALU_output);
/*------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

flags_register inst8 (CLOCK_50, NZCV, Wen_Flags, flags);
/*------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

data_memory inst9 (CLOCK_50, ALU_output[3:0], Rd, Wen_Dmem, DMEM_output);
/*------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

mux_x inst10 (ALU_output, DMEM_output, select_X, mux_X_out);
/*------------------------------------------------------------------------------------------------------------------------------------------------------------------*/


always @(PC_out or PC_next)
	begin
		result_out <= Rd;		//output
		flags_out <= flags;
	end

endmodule
