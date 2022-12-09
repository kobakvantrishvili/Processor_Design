module src2shift(

	input 		          			CLOCK_50,
	input					[2:0]			CTRL_select, // op, I
	input 		      [4:0]  		IR_shamt5,			
	input					[3:0]			IR_rot,
	input					[1:0]			IR_sh,
	input									IR_4th,
	input					[23:0]		IR_imm,
	input					[31:0]		RF_Rm,
	input					[31:0]		RF_Rs,
	
	output 		reg   [31:0]  		src2,
	output 		reg			  		was_shifted,
	output 		reg			  		carryBit
);

logic [31:0] temp;

initial
	begin
		was_shifted <= 0;
		carryBit <= 0;
	end

always @(posedge CLOCK_50)
	begin
		case (CTRL_select)
		3'b000 :								// data processing instruction where second operand is register
			begin
				if(IR_4th == 0) begin	// shift is done with immediate value
					if(IR_shamt5 >= 1) begin
						was_shifted <= 1;
						case (IR_sh)
						2'b00: {carryBit, src2} <= {1'b0, RF_Rm} << IR_shamt5;				// logical shift left
						2'b01: {src2, carryBit} <= {RF_Rm, 1'b0} >> IR_shamt5;				// logical shift right
						2'b10: {src2, carryBit} <= $signed({RF_Rm, 1'b0}) >>> IR_shamt5;	// arithmeric shift right
						2'b11: begin																		// rotate right
							{temp,src2} <= {RF_Rm, RF_Rm} >> IR_shamt5;
							carryBit <= src2[31];
						end
						endcase
					end
					else begin	
						src2 <= RF_Rm; 	// no shifting
						was_shifted <= 0;
					end
				end
				else begin					// shift is done with register Rs
					if(RF_Rs >= 1) begin
						was_shifted <= 1;
						case (IR_sh) 
						2'b00: {carryBit, src2} <= {1'b0, RF_Rm} << RF_Rs;						// logical shift left
						2'b01: {src2, carryBit} <= {RF_Rm, 1'b0} >> RF_Rs;						// logical shift right
						2'b10: {src2, carryBit} <= $signed({RF_Rm, 1'b0}) >>> RF_Rs;		// arithmeric shift right
						2'b11: begin																		// rotate right
							{temp, src2} <= {RF_Rm, RF_Rm} >> RF_Rs % 32;
							carryBit <= src2[31];
						end
						endcase
					end
					else begin
						src2 <= RF_Rm; 	// no shifting
						was_shifted <= 0;
					end
				end
			end
		3'b001 :								// data processing instruction where second operand is immediate
			begin
				if(IR_rot >= 1) begin
					was_shifted <= 1;
					src2[31:8] <= 0;
					{temp[7:0], src2[7:0]} <= {IR_imm[7:0], IR_imm[7:0]} >> IR_rot % 8;
					carryBit <= src2[7];
				end
				else begin
					src2 <= IR_imm[7:0]; // no shifting
					was_shifted <= 0;
				end
			end
		3'b010 :								// memory access instruction where second operand is immediate
			begin
				src2 <= IR_imm[11:0];
				was_shifted <= 0;
			end
		3'b011 :								// memory access instruction where second operand is register
			begin
				if(IR_shamt5 >= 1) begin
					was_shifted <= 1;
					case (IR_sh) 
					2'b00: {carryBit, src2} <= {1'b0, RF_Rm} << IR_shamt5;				// logical shift left
					2'b01: {src2, carryBit} <= {RF_Rm, 1'b0} >> IR_shamt5;				// logical shift right
					2'b10: {src2, carryBit} <= $signed({RF_Rm, 1'b0}) >>> IR_shamt5;	// arithmeric shift right
					2'b11: begin																		// rotate right
						{temp, src2} <= {RF_Rm, RF_Rm} >> IR_shamt5;
						carryBit <= src2[31];
					end
					endcase
				end
				else begin
					src2 <= RF_Rm; 		// no shifting
					was_shifted <= 0;
				end
			end
		3'b101 :								// branch instruction
			begin
				src2 <= IR_imm[23:0];
				was_shifted <= 0;
			end
		endcase

		
	end
	
endmodule