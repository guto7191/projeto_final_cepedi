module Rom (
    input [7:0] ler_endereco,
    output reg [7:0] instrucao_out
);

reg [7:0] memoria [0:255];

initial begin
    //---------------------------------------
    // PROGRAMA DE TESTE COMPLETO
    //---------------------------------------
	
    memoria[0]  = {4'b0110, 4'b0001}; // LDC  #01H   A = 01H
    memoria[1]  = {4'b0110, 4'b1001}; // LDC  #09H   A = 09H
    memoria[2]  = {4'b0100, 4'b0110}; // LDB  #06H   B = MEM[06H]

    // Teste ADD
    memoria[3]  = {4'b0000, 4'b0000}; // ADD         A = A + B

    // STA
    memoria[4]  = {4'b0011, 4'b0111}; // STA  #07H   MEM[07H] = A

    // Teste SUB
    memoria[5]  = {4'b0001, 4'b0000}; // SUB         A = A - B

    // LDA
    memoria[6]  = {4'b0010, 4'b0110}; // LDA  #06H   A = MEM[06H]

    // STB
    memoria[7]  = {4'b0101, 4'b0111}; // STB  #07H   MEM[07H] = B

    // Teste JMP condicional
    memoria[8]  = {4'b0111, 4'b0101}; // JMP  #05H   se A == 0 → PC = 05H
		
    //---------------------------------------
    // TESTES DAS NOVAS INSTRUÇÕES
    //---------------------------------------
/*
    memoria[0]  = {4'b0110, 4'b1111}; // LDC #0F     A = 0F
    memoria[1] = {4'b0100, 4'b0001}; // LDB #01     B = MEM[01]

    // AND
    memoria[2] = {4'b1000, 4'b0000}; // AND         A = A & B

    // OR
    memoria[3] = {4'b1001, 4'b0000}; // OR          A = A | B

    // BEQ
    memoria[4] = {4'b1010, 4'b0001}; // BEQ #01H    se A == B → PC = 01

   */
end

always @(*) begin
    instrucao_out = memoria[ler_endereco];
end

endmodule
