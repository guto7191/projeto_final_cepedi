module testbench;

reg [3:0] instrucao;
wire Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite;
wire [1:0] ALUOp;

Controle controle(
    .instrucao(instrucao),
    .Branch(Branch),
    .MemRead(MemRead),
    .MemtoReg(MemtoReg),
    .MemWrite(MemWrite),
    .ALUSrc(ALUSrc),
    .RegWrite(RegWrite),
    .ALUOp(ALUOp)
    );

localparam ADD = 4'b0000; // Soma A e B, armazena no endereço indicado no imediato #
localparam SUB = 4'b0001; // Subtrai B de A, armazena no endereço indicado no imediato #
localparam LDA = 4'b0010; // Carrega o valor do endereço indicado no imediato # para o registrador A
localparam STA = 4'b0011; // Armazena o valor de A no endereço indicado no imediato #
localparam LDB = 4'b0100; // Carrega o valor do endereço indicado no imediato # para o registrador B
localparam STB = 4'b0101; // Armazena o valor de B no endereço indicado no imediato #
localparam LDC = 4'b0110; // Carrega uma constante no registrador A;
localparam JMP = 4'b0111;


initial begin 

    $dumpfile("teste.vcd");
    $dumpvars(0,testbench);

    $monitor("in: %b|ALUop: %b|Branch: %b|MemRead: %b|MemtoReg: %b|MemWrite: %b|ALUSrc: %b|RegWrite: %b", instrucao,
    ALUOp,Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite);
    instrucao = 4'b0000;
    #2 instrucao = ADD;
    #2 instrucao = SUB;
    #2 instrucao = STA;
    #2 instrucao = STB;
    #2 instrucao = LDA;
    #2 instrucao = LDB;
    #2 instrucao = LDC;
    #2 instrucao = JMP;
    
    #2 $finish;
end



endmodule