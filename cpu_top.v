module cpu_top(
	input clk,
	input reset,
	output [7:0] debug_alu_result,
	output [7:0] debug_PC
);

	//Debug
	assign debug_alu_result = alu_result;
	assign debug_PC = PC_out;
	
	// Fios para conexoes dos componentes 
	
	
	//program_counter 
	wire [7:0] PC_out;
	wire [7:0] PC_next;
	wire [7:0] PC_incremented;
	
	// Opcode e Imediato
	wire [7:0] instrucao;
	wire [3:0] opcode = instrucao[7:4];
	wire [3:0] imediato = instrucao[3:0];
	
	// Sinais de controle
	wire [2:0] ALUOp;
	wire LoadA, LoadB;
	wire WriteBackMem;
	wire UseImmediate;
	wire BranchZero;
	wire BranchEQ;
	
	// Conexoes reg A e B
	wire [7:0] regA;
	wire [7:0] regB;
	
	// Conexoes ALU
	wire [7:0] alu_result;
	wire alu_zero;
	wire alu_eq;
	
	// Saida da ram 
	wire [7:0] ram_data_out;
	
	
	//Extencao de imediato
	wire [7:0] immediate_ext = {4'b0000, imediato};
	
	
	// UNIDADE DE CONTROLE
	
	Controle UC (
		.opcode(opcode),
		.ALUOp(ALUOp),
		.LoadA(LoadA),
		.LoadB(LoadB),
		.MemRead(MemRead),
		.MemWrite(MemWrite),
		.WriteBackMem(WriteBackMem),
		.BranchZero(BranchZero),
		.BranchEQ(BranchEQ),
		.UseImmediate(UseImmediate)
	);
	
	
	
	// ROM 
	Rom ROM (
		.ler_endereco(PC_out),
		.instrucao_out(instrucao)
	);	
	
	
	// BANCO DE REGISTRADORES
	
	// write_enable é ativo quando LoadA OU LoadB nivel alto
	wire write_enable = LoadA | LoadB;

	
	
	// *implementar o MUX: Seleciona qual registrador será escrito
   wire [1:0] reg_dest = (LoadA) ? 2'b00 :
                         (LoadB) ? 2'b01 : 2'b00;
								 
	// *implementar  o MUX: dado que será escrito em A ou B
    wire [7:0] write_reg_data =
            UseImmediate ? immediate_ext :     // LDC
            MemRead      ? ram_data_out :      // LDA/LDB
            alu_result;                        // operações ALU							 
	
	BancoRegistrador registradores (
		.clk(clk),
      .write(write_enable),
      .reset(reset),
      .reg_dest(reg_dest),
      .wrData(write_reg_data),
      .regA_out(regA),
      .regB_out(regB)
	);
		

	// ALU
	ALU alu (
		.A(regA),
		.B(regB),
		.ALUOp(ALUOp),
		.resultado(alu_result),
		.zero(alu_zero),
		.eq(alu_eq)
	);
		
	// RAM 
	// * mudar para assign:  Para instruções que guardam em m
	//emória (STA, STB, ADD#X, etc.)
    wire [7:0] ram_write_data = alu_result;

	Ram RAM (
        .clk(clk),
        .reset(reset),
        .MemWrite(MemWrite | WriteBackMem),
        .MemRead(MemRead),
        .Address({4'b0000, imediato}),   // endereços 0–15
        .WriteData(ram_write_data),
        .MemData_out(ram_data_out)
    );
	 
	 // Salto e PC control
	 
	 wire branch_taken =
        (BranchZero && alu_zero) ||
        (BranchEQ   && alu_eq);
	 
	 // MUX PC: incrementa ou faz salto
    Mux2x1 mux_pc (
        .in_0(PC_incremented),
        .in_1(immediate_ext),
        .sel(branch_taken),
        .out(PC_next)
    );

    // Incrementa PC
    SomadorPC ADD_PC (
        .PC_endereco(PC_out),
        .next_endereco(PC_incremented)
    );

    // Registrador PC
    ProgramCounter PC (
        .clk(clk),
        .reset(reset),
        .data_in(PC_next),
        .data_out(PC_out)
    );
	
endmodule 