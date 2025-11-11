module Controle(
    input [3:0] instrucao,
    output reg Branch,
    output reg MemRead,
    output reg MemtoReg,
    output reg [1:0] ALUOp,
    output reg MemWrite,
    output reg ALUSrc,
    output reg RegWrite
);
//Operações imediatas
localparam ADD = 4'b0000; // Soma A e B, armazena no endereço indicado no imediato #
localparam SUB = 4'b0001; // Subtrai B de A, armazena no endereço indicado no imediato #
localparam LDA = 4'b0010; // Carrega o valor do endereço indicado no imediato # para o registrador A
localparam STA = 4'b0011; // Armazena o valor de A no endereço indicado no imediato #
localparam LDB = 4'b0100; // Carrega o valor do endereço indicado no imediato # para o registrador B
localparam STB = 4'b0101; // Armazena o valor de B no endereço indicado no imediato #
localparam LDC = 4'b0110; // Carrega uma constante no registrador A;
localparam JMP = 4'b0111; // Jump condicionado ao conteúdo de A, se 0, então salta para o endereço apontado 
                // pelo endereço indicado no imediato #

//*****************************
//localparam OR = 4'b1000;
//localparam AND = 4'b1001;
//localparam BEQ =


always @(*)begin 
    //Inicializando como valores que indicam não operação
    Branch = 1'b0;
    MemRead = 1'b0;
    MemtoReg = 1'b0;
    ALUOp = 2'b00; //add modo padrão 
    MemWrite = 1'b0;
    ALUSrc = 1'b0;
    RegWrite = 1'b0;

    case (instrucao)
        ADD: begin // ADD nessa arquitetura é um add imediato
            ALUSrc   = 1'b1;   // Usa imediato como operando
            RegWrite = 1'b1;   // Escreve no registrador
            ALUOp    = 2'b00;  // Operação de soma
        end
        
        SUB: begin
            ALUOp = 2'b01;
            RegWrite = 1'b1;
        end

        LDA: begin
            MemRead = 1'b1; // Lê da memoria
            MemtoReg = 1'b1; // Dado vem para memoria 
            ALUSrc = 1'b1; // usa o imediato para endereco
            RegWrite = 1'b1; // Escreve no registrador
            ALUOp = 2'b00;  // Soma para calculo de endereco????? 
        end

        LDB: begin
            MemRead = 1'b1; 
            MemtoReg = 1'b1; 
            ALUSrc = 1'b1; 
            RegWrite = 1'b1; 
            ALUOp = 2'b00;
        end

        LDC: begin
            MemRead = 1'b1; 
            MemtoReg = 1'b1; 
            ALUSrc = 1'b1; 
            RegWrite = 1'b1; 
            ALUOp = 2'b00;
        end

        STA: begin
            MemWrite = 1'b1;
            ALUSrc = 1'b1;
            ALUOp = 2'b00; 
        end

        STB: begin
            MemWrite = 1'b1;
            ALUSrc = 1'b1;
            ALUOp = 2'b00; 
        end

        JMP: begin
            Branch = 1'b1;
            // AluOP don't care
        end

        default: begin
            Branch = 1'b0;
            MemRead = 1'b0;
            MemtoReg = 1'b0;
            ALUOp = 2'b00; //add modo padrão 
            MemWrite = 1'b0;
            ALUSrc = 1'b0;
            RegWrite = 1'b0;
        end
    endcase

end


endmodule