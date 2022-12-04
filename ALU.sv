module ALU(

	input 		          			CLOCK_50,
	input					[31:0]		src1,
	input 		      [31:0]  		src2,
	input									src2shift_carry,
	input									was_shifted,
	input					[3:0]			flags, 		// from flag register
	input					[4:0]			CTRL_cmd,
	
	

	output 		reg   [3:0]  		NZCV,
	output 		reg   [31:0]  		ALU_output
);

logic [31:0] temp;
logic [31:0] out;
logic carryBit;

assign ALU_output = out;

always @(posedge CLOCK_50)
	begin
		case(CTRL_cmd)
		5'b00000:
			out <= src1 & src2; 														 		// bitwise AND
		5'b00001:
			out <= src1 ^ src2; 														 		// bitwise XOR
		5'b00010:
			{carryBit, out} <= {1'b0, src1} - {1'b0, src2};							// Substract
		5'b00011:
			{carryBit, out} <= {1'b0, src2} - {1'b0, src1}; 			 			// Reverse Substract
		5'b00100:
			{carryBit, out} <= {1'b0, src1} + {1'b0, src2}; 			 			// Add
		5'b00101:
			begin
				temp <= src2 + flags[1];
				{carryBit, out} <= {1'b0, src1} + {1'b0, src2} + flags[1];		// Add with Carry
			end
		5'b00110:
			begin
				temp <= src2 + !flags[1];
				{carryBit, out} <= {1'b0, src1} - {1'b0, src2} - !flags[1];		// Substract with Carry
			end
		5'b00111:
			begin
				temp <= src1 + !flags[1];
				{carryBit, out} <= {1'b0, src2} - {1'b0, src1} - !flags[1];		// Reverse Substract with Carry
			end
		5'b01000:																 		
			temp <= src1 & src2;																// Test
		5'b01001:
			temp <= src1 ^ src2;																// Test Equivalence
		5'b01010:
			{carryBit, temp} <= {1'b0, src1} - {1'b0, src2};			 			// Compare
		5'b01011:
				{carryBit, temp} <= {1'b0, src1} + {1'b0, src2};			 		// Compare Negative
		5'b01100:
			out <= src1 | src2;														 		// Bitwise OR
		5'b01101: 
			out <= src2;																 		// Move
		5'b01110:
			out <= src1 & ~src2;														 		// Bitwise Clear
		5'b01111:
			out <= ~src1;																 		// Bitwise Not
		5'b10000:
			{carryBit, out} <= {1'b0, src1} * {1'b0, src2};							// Multiply
		endcase
	end

	
always @(out or temp or carryBit or was_shifted or src2shift_carry)
	begin
		case(CTRL_cmd)
		5'b00010:																			 // Substract
			begin
				if((!src1[31] && src2[31] && out[31]) || 	/* positive - negative = negative */
					(src1[31] && !src2[31] && !out[31]))	/* negative - positive = positive */
					NZCV[0] <= 1;
				else 
					NZCV[0] <= 0;
					
				NZCV[1] <= ~carryBit; /* if substraction produces underflow carryBit is 0 */
			end
		5'b00011:																			 // Reverse Substract
			begin
				if((!src2[31] && src1[31] && out[31]) ||	/* positive - negative = negative */
					(src2[31] && !src1[31] && !out[31]))	/* negative - positive = positive */
					NZCV[0] <= 1;
				else 
					NZCV[0] <= 0;
					
				NZCV[1] <= ~carryBit; /* if substraction produces underflow carryBit is 0 */
			end
		5'b00100:																			 // Add
			begin
				if((!src1[31] && !src2[31] && out[31]) ||	/* positive + positive = negative */
					(src1[31] && src2[31] && !out[31]))		/* negative + negative = positive */
					NZCV[0] <= 1;
				else
					NZCV[0] <= 0;
					
				NZCV[1] <= carryBit; /* if addition produces overflow carryBit is 1 */
			end
		5'b00101:																			 // Add with Carry
			begin
				if((!src1[31] && !temp[31] && out[31]) ||	/* positive + positive = negative */
					(src1[31] && temp[31] && !out[31]))		/* negative + negative = positive */
					NZCV[0] <= 1;
				else
					NZCV[0] <= 0;
				
				NZCV[1] <= carryBit; /* if addition produces overflow carryBit is 1 */
			end
		5'b00110:																			 // Substract with Carry
			begin
				if((!src1[31] && temp[31] && out[31]) || 	/* positive - negative = negative */
					(src1[31] && !temp[31] && !out[31]))	/* negative - positive = positive */
					NZCV[0] <= 1;
				else
					NZCV[0] <= 0;
				
				NZCV[1] <= ~carryBit; /* if substraction produces underflow carryBit is 0 */
			end
		5'b00111:																			 // Reverse Substract with Carry
			begin
				if((!src2[31] && temp[31] && out[31]) ||	/* positive - negative = negative */
					(src2[31] && !temp[31] && !out[31]))	/* negative - positive = positive */
						NZCV[0] <= 1;
					else 
						NZCV[0] <= 0;
						
				NZCV[1] <= ~carryBit; /* if substraction produces underflow carryBit is 0 */
			end
		5'b01000:																			 // Test
			begin
				if(temp == 0)						NZCV[3:2] = 2'b01;
				else if(temp[31] == 1)			NZCV[3:2] = 2'b10;
				else									NZCV[3:2] = 2'b00;
			end
		5'b01001:																			 // Test Equivalence
			begin
				if(temp == 0)						NZCV[3:2] = 2'b01;
				else if(temp[31] == 1)			NZCV[3:2] = 2'b10;
				else									NZCV[3:2] = 2'b00;
			end
		5'b01010:																			 // Compare
			begin
				if(temp == 0)				NZCV[3:2] = 2'b01;	
				else if (temp[31] == 1)	NZCV[3:2] = 2'b10;
				else							NZCV[3:2] = 2'b00;
				
				NZCV[1] <= ~carryBit; /* if substraction produces underflow carryBit is 0 */
				
				if((!src1[31] && src2[31] && temp[31]) || /* positive - negative = negative */
					(src1[31] && !src2[31] && !temp[31]))	/* negative - positive = positive */
					NZCV[0] <= 1;
				else 
					NZCV[0] <= 0;
			end
		5'b01011:																			 // Compare Negative
			begin
				if(temp == 0)				NZCV[3:2] = 2'b01;	
				else if (temp[31] == 1)	NZCV[3:2] = 2'b10;
				else							NZCV[3:2] = 2'b00;
				
				NZCV[1] <= carryBit; /* if addition produces overflow carryBit is 1 */
				
				if((!src1[31] && !src2[31] && temp[31]) || /* positive + positive = negative */
					(src1[31] && src2[31] && !temp[31]))	 /* negative + negative = positive */
					NZCV[0] <= 1;
				else 
					NZCV[0] <= 0;
			end
		5'b10000:																		 	 // Multiply
			begin
				if((!src1[31] && !temp[31] && out[31]) ||	/* positive * positive = negative */
					(src1[31] && !temp[31] && !out[31]) ||	/* negative * positive = positive */
					(!src1[31] && temp[31] && !out[31]))	/* positive * negative = positive */
					NZCV[0] <= 1;
				else
					NZCV[0] <= 0;
				
				NZCV[1] <= carryBit; /* if multiply produces overflow carryBit is 1 */						
			end
		endcase
		
		
		
		if(CTRL_cmd != 5'b01000 && CTRL_cmd != 5'b01001 &&	/* If command doesn't set ALU_output */
			CTRL_cmd != 5'b01010 && CTRL_cmd != 5'b01011) begin
			if (out == 0)				NZCV[3:2] <= 2'b01;	
			else if (out[31] == 1)	NZCV[3:2] <= 2'b10;
			else							NZCV[3:2] <= 2'b00;
		end
	
		if(CTRL_cmd != 5'b00010 && CTRL_cmd != 5'b00011 &&	/* For non-additions/subtractions */
			CTRL_cmd != 5'b00100 && CTRL_cmd != 5'b00101 && 
			CTRL_cmd != 5'b00110 && CTRL_cmd != 5'b00111 && 
			CTRL_cmd != 5'b01010 && CTRL_cmd != 5'b01011 && 
			CTRL_cmd != 5'b10000 && was_shifted == 1) begin
				NZCV[1] <= src2shift_carry;
			end
	end
	
	

endmodule
	