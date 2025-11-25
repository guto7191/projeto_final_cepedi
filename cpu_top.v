module cpu_top(
	input clk,
	input reset,
	output [7:0] pc_debug,
	output [7:0] alu_debug,
	output [7:0] regA_data_debug,
	output [7:0] regB_data_debug
);

	// conexao caminho de dados 
	wire [7:0] PC_out, next_PC, PC_plus_1;
	wire [7:0] instruction;
	wire [3:0] opcode;
	wire [3:0] immediate;
	wire [7:0] extended_imm;

	// conexao de controle 
	wire Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite;
	wire [1:0] ALUOp;
	
	//conexao do banco de registrador
	wire [7:0] regA_data, regB_data;
	
	//conexao da alu
	wire [7:0] resultado_ALU;
	wire ALU_zero;
	
	//conexao de memoria 
	wire [7:0] mem_data_out;
	
	//conexao multiplexador
	wire [7:0] ALU_src_B;
	wire [7:0] write_back_data;
	
	//logica jump/branch
	wire [7:0] branch_target;
	wire PCSrc; 
	
	// Selecao de registrador de destino 
	wire [1:0] reg_dest;
	
	//Etapa de debug
	
	assign pc_debug = PC_out;
	assign alu_debug = resultado_ALU;
	assign regA_data_debug = regA_data;
	assign regB_data_debug = regB_data;
	
	//Estagio Buscar instruçao
	
	ProgramCounter PC(
		.clk(clk),
		.reset(reset),
		.data_in(next_PC),
		.data_out(PC_out)
	);
	
	SomadorPC PC_adder(
		.PC_endereco(PC_out),
		.next_endereco(PC_plus_1)
	);
	
	Rom ROM(
		.ler_endereco(PC_out),
		.instrucao_out(instruction)
	);
	
	
	// Estagio de decodificacao da instruçao
	assign opcode = instruction[7:4];
	assign immediate = instruction[3:0];
	
	Controle control_unit(
		.opcode(opcode),
		.Branch(Branch),
		.MemRead(MemRead),
		.MemtoReg(MemtoReg),
		.ALUOp(ALUOp),
		.MemWrite(MemWrite),
		.ALUSrc(ALUSrc),
		.RegWrite(RegWrite)
	);
	
	// Determina qual resgistrador escrever baseado na instruçao
	// localparam STB  = 4'b0101;  // STB #imm - Armazena B em MEM[imm]
	//localparam LDB  = 4'b0100;  // LDB #imm - Carrega MEM[imm] em B
	assign reg_dest = (opcode == 4'b0100 || opcode == 4'b0101)? 2'b01 : 2'b00;
	
	//Banco de registrado contendo A e B
	BancoRegistrador reg_file(
		.clk(clk),
		.write(RegWrite),
		.reset(reset),
		.reg_dest(reg_dest), // A para maioria - B para LDB/STB
		.wrData(write_back_data),
		.regA_out(regA_data),
		.regB_out(regB_data)
	);
	
	//Extensor de sinal 4 para 8 bits
	assign extended_imm = {4'b0000,immediate};
	
	//Estagio de EX
	//Multiplexador ALU Src B - escolhe entre registrador B ou imediato
	Mux2x1 ALU_src_B_mux(
		.in_0(regB_data), // para operaçoes ADD/SUB entre A e B
		.in_1(extended_imm), // para operaçoes  com immediato
		.sel(ALUSrc),
		.out(ALU_src_B)
	);
	
	//ALU sempre usa A como primeira entrada, B ou imediato com segunda
	ALU alu(
		.A(regA_data), // sempre A
		.B(ALU_src_B), // B ou Imediato
		.Controle_ALUop(ALUOp),
		.zero(ALU_zero), // JUMP para A==0
		.resultado_ALU(resultado_ALU)
	);
	
	
	//calculo do endereço de branch/jump
	assign branch_target = extended_imm; //JMP usa endereço absoluto
	
	
	// Estagio em memoria 
	Ram RAM(
		.clk(clk),
		.reset(reset),
		.MemWrite(MemWrite),
		.MemRead(MemRead),
		.Address(extended_imm), //resultado_ALU - era o que estava
		.WriteData((opcode == 4'b0101) ? regB_data : regA_data), // STB usa B, outros usam A
		.MemData_out(mem_data_out)                   
	);
	
	// Multiplexador Write Back - escolhe entre resultado ALU e dado da memoria
	Mux2x1 write_back_mux (
		.in_0(resultado_ALU), 
		.in_1(mem_data_out),
		.sel(MemtoReg),
		.out(write_back_data)
	);
	
	//Jump salta se A ==0
	//assign PCSrc = Branch & (regA_data == 8'b0000_0000);
	assign PCSrc = Branch;
	
	// Multiplexador do PC
	assign next_PC = PCSrc ? branch_target : PC_plus_1;
	
	
endmodule 