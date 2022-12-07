module controller(
	
	input 		          			CLOCK_50,
	input				[31:0]			IR_in,
	input				[3:0]				Flags_in, // NZCV
	
	
	output	reg						Wen_ARd,
	output	reg						Wen_Dmem,
	output	reg						Wen_Flags,
	output	reg	[4:0]				cmd,
	output	reg						select_X,
	output	reg						select_Y,
	output	reg	[1:0]				select_src1,
	output	reg	[2:0]				select_src2shift

);//Unfinished

logic [1:0] op;
logic [3:0] cond;
logic enable;

assign op = IR_in[27:26];
assign cond = IR_in[31:28];



always @(posedge CLOCK_50)
	begin
		
		case(cond)
		4'b0000: // EQ
			begin
				if(Flags_in[2])
					enable = 1;
				else
					enable = 0;
			end
		4'b0001: // NE
			begin
				if(!Flags_in[2])
					enable = 1;
				else
					enable = 0;
			end
		4'b0010:	// CS
			begin
				if(Flags_in[1])
					enable = 1;
				else
					enable = 0;
			end
		4'b0011: // CC
			begin
				if(!Flags_in[1])
					enable = 1;
				else
					enable = 0;
			end
		4'b0100: // MI
			begin
				if(Flags_in[3])
					enable = 1;
				else
					enable = 0;
			end
		4'b0101: // PL
			begin
				if(!Flags_in[3])
					enable = 1;
				else
					enable = 0;
			end
		4'b0110: // VS
			begin
				if(Flags_in[0])
					enable = 1;
				else
					enable = 0;
			end
		4'b0111: // VC
			begin
				if(!Flags_in[0])
					enable = 1;
				else
					enable = 0;
			end
		4'b1000: // HI
			begin
				if(Flags_in[1] && !Flags_in[2])
					enable = 1;
				else
					enable = 0;
			end
		4'b1001: // LS
			begin
				if(!Flags_in[1] || Flags_in[2])
					enable = 1;
				else
					enable = 0;
			end
		4'b1010: // GE
			begin
				if(!(Flags_in[0] ^ Flags_in[1]))
					enable = 1;
				else
					enable = 0;
			end
		4'b1011: // LT
			begin
				if(Flags_in[0] ^ Flags_in[1])
					enable = 1;
				else
					enable = 0;
			end
		4'b1100: // GT
			begin
				if(!(Flags_in[0] ^ Flags_in[1]) && !Flags_in[2])
					enable = 1;
				else
					enable = 0;
			end
		4'b1101: // LE
			begin
				if((Flags_in[0] ^ Flags_in[1]) || Flags_in[2])
					enable = 1;
				else
					enable = 0;
			end
		4'b1110: // AL
			begin
				enable = 1;
			end
		default: // AL
			begin
				enable = 1;
			end
		endcase
		
		
		
		if(enable) 
		begin
			case (op)
			2'b00 :
				begin
					// If data processing instruction isn't cmd: TST, TEQ, CMP, CMN
					if(IR_in[24:21] != 4'b1000 && IR_in[24:21] != 4'b1001 &&
						IR_in[24:21] != 4'b1010 && IR_in[24:21] != 4'b1011) begin
						Wen_ARd <= 1;
					end
					else begin
						Wen_ARd <= 0;
					end
					
					// data processing instructions don't write/read from Dmem
					Wen_Dmem <= 0;
					
					select_X <= 0; 			// Rd_data
					select_Y <= 0; 			// ARd
					
					
					
					// if operation is multiplication we have to send special command that doesn't match cmd bits
					if(IR_in[25:24] == 2'b00 && IR_in[23:21] == 3'b000 && IR_in[7:4] == 4'b1001) begin
						cmd <= 5'b10000;
					end
					else begin
						cmd <= {1'b0, IR_in[24:21]}; // other operations, cmd bits match operation code in ALU (we just put 0 in front)
					end
					
					select_src1 <= 2'b00; 	// Rn
					
					// if Set bit is 1
					if(IR_in[20] == 1)
						Wen_Flags <= 1;
					else
						Wen_Flags <= 0;
				end
			2'b01 :
				begin
					// If memory access instruction has 1 in Load bit (PUBWL)
					if(IR_in[20] == 1) begin
						Wen_ARd <= 1;
						Wen_Dmem <= 0;
						select_X <= 1; 		// DM_data
					end
					else begin
						Wen_ARd <= 0;
						Wen_Dmem <= 1;
						select_X <= 0; 		// Rd_data
					end
					
					select_Y <= 0; 			// ARd
					select_src1 <= 2'b00; 	// Rn
					
					Wen_Flags <= 0;
						
					cmd <= 5'b00100;			// since we perform add operation, adding offset to base address
					
				end
			2'b10 :
				begin
					// If branch instruction has 1 in Link bit we have branch and link instruction
					if(IR_in[24] == 1) begin
						Wen_ARd <= 1;
					end
					else begin
						Wen_ARd <= 0;
					end
					
					Wen_Dmem <= 0;
					Wen_Flags <= 0;
					
					select_X <= 0; 			// Rd_data
					select_Y <= 1; 			// 15 for jump
					select_src1 <= 2'b10; 	// PC_out, for jump
					
					cmd <= 5'b00100;			// since we perform add operation, adding imm_24 to PC to get the place where we jump to
					
				end
			endcase
			
			select_src2shift <= IR_in[27:25];	// passing op, I
			
		end
		else
		begin
			Wen_ARd <= 0;
			Wen_Dmem <= 0;
			Wen_Flags <= 0;
			//select_Y <= 0; so that in case of branch, jump doesnt get performed
		end
		
	end


endmodule
