/*module Rom (
    input clk,
    input reset,
    input [7:0] ler_endereco,
    output reg [7:0] instrucao_out
);

reg [7:0] memoria [0:255];
integer k;

always @(posedge clk, posedge reset) begin
    if(reset) begin
        // Inicialização
        for(k=0; k < 256; k = k + 1) begin
            memoria[k] <= 8'b0000_0000;
        end
        
        // Programa de exemplo seguindo as instruções
        memoria[0]  <= {4'b0110, 4'b0001};  // LDC #01H  (A = 01H)
        memoria[1]  <= {4'b0110, 4'b1001};  // LDC #09H  (A = 09H) 
        memoria[2]  <= {4'b0100, 4'b0110};  // LDB #06H  (B = MEM[06H])
        memoria[3]  <= {4'b0000, 4'b0101};  // ADD #05H  (A = A + B, resultado em A)
        memoria[4]  <= {4'b0011, 4'b0111};  // STA #07H  (MEM[07H] = A)
        memoria[5]  <= {4'b0001, 4'b0100};  // SUB #04H  (A = A - B)
        memoria[6]  <= {4'b0010, 4'b0110};  // LDA #06H  (A = MEM[06H])
        memoria[7]  <= {4'b0101, 4'b0111};  // STB #07H  (MEM[07H] = B)
        memoria[8]  <= {4'b0111, 4'b0101};  // JMP #15H  (Se A==0, jump para 15H)
        memoria[9]  <= {4'b0110, 4'b0001};  // LDC #01H  (Continuação se não jump)
        // ... resto do programa
    end else begin
        instrucao_out <= memoria[ler_endereco];
    end
end

endmodule*/


module Rom (
    input [7:0] ler_endereco,
    output reg [7:0] instrucao_out
);

reg [7:0] memoria [0:255];

initial begin
    memoria[0] = {4'b0110, 4'b0001}; // LDC #01H  (A = 01H)
    memoria[1] = {4'b0110, 4'b1001}; // LDC #09H  (A = 09H) 
    memoria[2] = {4'b0100, 4'b0110}; // LDB #06H  (B = MEM[06H])
    memoria[3] = {4'b0000, 4'b0101}; // ADD #05H  (A = A + B, resultado em A)
    memoria[4] = {4'b0011, 4'b0111}; // STA #07H  (MEM[07H] = A)
    memoria[5] = {4'b0001, 4'b0100}; // SUB #04H  (A = A - B)
    memoria[6] = {4'b0010, 4'b0110}; // LDA #06H  (A = MEM[06H])
    memoria[7] = {4'b0101, 4'b0111}; // STB #07H  (MEM[07H] = B)
    memoria[8] = {4'b0111, 4'b0101}; // JMP #15H  (Se A==0, jump para 15H)
end

always @(*) begin
    instrucao_out = memoria[ler_endereco];
end

endmodule

