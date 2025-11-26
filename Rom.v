module Rom (
    input [7:0] ler_endereco,
    output reg [7:0] instrucao_out
);

reg [7:0] memoria [0:255];

initial begin
	 /*	// LDC
	 memoria[0]  = {4'b0110, 4'b0001}; // LDC  #01H   A = 01H
	 
	  // STA
	  memoria[1]  = {4'b0011, 4'b0111}; // STA  #07H   MEM[07H] = A
	  
	  //LDB
	  memoria[2]  = {4'b0100, 4'b0111}; // LDB  #07H   B = MEM[07H]
	 
	  // STB
	  memoria[3]  = {4'b0101, 4'b0110}; // STB  #06H   MEM[06H] = B
	  
	  // LDA
	  memoria[4]  = {4'b0010, 4'b0110}; // LDA  #06H   A = MEM[06H]
	 */
	 
		// LDC
	 memoria[0]  = {4'b0110, 4'b0001}; // LDC  #01H   A = 01H
	 
	  // STA
	  memoria[1]  = {4'b0011, 4'b0111}; // STA  #07H   MEM[07H] = A
	  
	  //LDB
	  memoria[2]  = {4'b0100, 4'b0111}; // LDB  #07H   B = MEM[07H]
	  
	  // LDC 
	  memoria[3]  = {4'b0110, 4'b1001}; // LDC  #09H   A = 09H
	  
	  // Teste SUB
	  memoria[4]  = {4'b0001, 4'b0000}; // SUB         A = A - B
	  
	  // STA
	  memoria[5]  = {4'b0011, 4'b0110}; // STA  #06H   MEM[06H] = A
	  
	  
	  // Teste ADD
	  memoria[6]  = {4'b0000, 4'b0000}; // ADD         A = A + B
	  
	  // STA
	  memoria[7]  = {4'b0011, 4'b0100}; // STA  #04H   MEM[04H] = A
	  
	  // STB
	  memoria[8]  = {4'b0101, 4'b0110}; // STB  #06H   MEM[06H] = B
	  
	  //Troca de valores
	   // LDA
		memoria[9]  = {4'b0010, 4'b0000}; // LDA  #00H   A = MEM[00H]
		
		//LDB
	  memoria[10]  = {4'b0100, 4'b0000}; // LDB  #00H   B = MEM[00H]
		
		// Teste JMP condicional
		memoria[11]  = {4'b0111, 4'b1111}; // JMP  # 14d   se A == 0 & B ==0→ PC = 14d
		
		 // AND
		memoria[12] = {4'b1000, 4'b0000}; // AND         A = A & B

		// OR
		memoria[13] = {4'b1001, 4'b0000}; // OR          A = A | B

		// LDC
		memoria[14]  = {4'b0110, 4'b0001}; // LDC  #01H   A = 01H
		// BEQ
		memoria[15] = {4'b1010, 4'b1100}; // BEQ #01H    se A == B → PC = 01		

end

always @(*) begin
    instrucao_out = memoria[ler_endereco];
end

endmodule
