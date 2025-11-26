module Controle(
	input [3:0] opcode,
	output reg [2:0] ALUOp,
	output reg LoadA,
	output reg LoadB,
	output reg MemRead,
	output reg MemWrite,
	output reg BranchZero,
	output reg BranchEQ,
	output reg UseImmediate
);


	always @(*)begin 
		// valores default
		 LoadA = 0;
		 LoadB = 0;
		 MemRead = 0;
		 MemWrite = 0;
		 BranchZero = 0;
		 BranchEQ   = 0;
		 UseImmediate = 0;
		 ALUOp = 3'b000;
	
		case(opcode)
			
			4'b0000: begin // ADD #X 
				ALUOp = 3'b000;
				LoadA = 1;
			end
			
			4'b0001: begin // SUB #X
				ALUOp = 3'b001;
				LoadA = 1;
			end
			
			4'b0010: begin // LDA #X
            MemRead = 1;
            LoadA = 1;
        end
		  
		  4'b0011: begin // STA #X
            MemWrite = 1;
        end
		  
		  4'b0100: begin // LDB #x
				MemRead = 1;
				LoadB = 1;
		  end
		  
		  4'b0101: begin // STB #x
			MemWrite = 1;
		  end
			
			4'b0110: begin // LDC #X  
            UseImmediate = 1;
            LoadA = 1;
            ALUOp = 3'b100; 
        end
		  
		  4'b0111: begin // JMP #X
            BranchZero = 1;
        end
		  
		  4'b1000: begin // AND
            ALUOp = 3'b010;
				LoadA = 1;
        end
			
			4'b1001: begin // OR
            ALUOp = 3'b011;
            LoadA = 1;
        end
		  
		  4'b1010: begin // BEQ
            BranchEQ = 1;
        end
			
		endcase	
	end 
	
endmodule 
	
	