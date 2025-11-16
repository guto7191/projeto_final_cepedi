module Controle(
	input [3:0] opcode,
	output reg Branch,
	output reg MemRead,
	output reg MemtoReg,
	output reg [1:0] ALUOp,
	output reg MemWrite,
	output reg ALUSrc,
	output reg RegWrite
);


	// Definição das instruções conforme especificado
	localparam ADD  = 4'b0000;  // ADD #imm - Soma A e B, armazena em A
	localparam SUB  = 4'b0001;  // SUB #imm - Subtrai B de A, armazena em A  
	localparam LDA  = 4'b0010;  // LDA #imm - Carrega MEM[imm] em A
	localparam STA  = 4'b0011;  // STA #imm - Armazena A em MEM[imm]
	localparam LDB  = 4'b0100;  // LDB #imm - Carrega MEM[imm] em B
	localparam STB  = 4'b0101;  // STB #imm - Armazena B em MEM[imm]
	localparam LDC  = 4'b0110;  // LDC #imm - Carrega constante em A
	localparam JMP  = 4'b0111;  // JMP #imm - Jump se A == 0


	always @(*) begin 
		// valores default dos sinais 
		Branch = 1'b0;
		MemRead = 1'b0;
		MemtoReg = 1'b0;
		ALUOp = 2'b00;
		MemWrite = 1'b0;
		ALUSrc = 1'b0;
		RegWrite = 1'b0;

		case(opcode)
			
			ADD: begin
				ALUSrc = 1'b1; // usa o imediato como operando b
				RegWrite = 1'b1; // escreve no registrador a
				ALUOp = 2'b00; // operaçao de soma
			end
			
			SUB: begin
				ALUSrc = 1'b1; 
				RegWrite = 1'b1; 
				ALUOp = 2'b01; // opereçao de sub 
			end
			
			LDA: begin
				MemRead = 1'b1; // le da memoria 
				MemtoReg = 1'b1; // dado vem da memoria
				ALUSrc = 1'b1; //usa o imediato como endereço 
				RegWrite = 1'b1; // escreve no registrador A
				ALUOp = 2'b00; // soma para calculo do endereço
			end
			
			LDB: begin
				MemRead = 1'b1; 
				MemtoReg = 1'b1; 
				ALUSrc = 1'b1; 
				RegWrite = 1'b1; // escreve no registrador B
				ALUOp = 2'b00; // soma para calculo do endereço
			end
			
			LDC: begin
				ALUSrc = 1'b1;   //usa o imediato como dado
				RegWrite = 1'b1; // escreve no registrador A
				ALUOp = 2'b00; // soma para calculo do endereço
			end
			
			STA: begin 
				MemWrite = 1'b1; // escreve o dado na memoria
				ALUSrc = 1'b1;  // usa imediato como endereço
				ALUOp = 2'b00; // soma para calculo de endereço
			end
			
			STB: begin 
				MemWrite = 1'b1; // escreve o dado na memoria
				ALUSrc = 1'b1;  // usa imediato como endereço
				ALUOp = 2'b00; // soma para calculo de endereço
			end
			
			JMP: begin
				Branch = 1'b1; // Ativa o branch para informar desvio
				ALUSrc = 1'b1; // usa imediato como offset
				// nao passa pela alu don't care para ALUOp
			end
			
			default: begin 
				//Manter valores default
				Branch = 1'b0;
				MemRead = 1'b0;
				MemtoReg = 1'b0;
				ALUOp = 2'b00;
				MemWrite = 1'b0;
				ALUSrc = 1'b0;
				RegWrite = 1'b0;
			end
		endcase
	
	end
	
endmodule 