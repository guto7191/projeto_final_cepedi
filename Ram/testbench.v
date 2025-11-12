`timescale 1ns / 1ps

module testbench;

    // Entradas
    reg clk;
    reg reset;
    reg MemWrite;
    reg MemRead;
    reg [3:0] Address;
    reg [7:0] WriteData;

    // Saídas
    wire [7:0] MemData_out;

    // Instancia o módulo RAM
    Ram uut (
        .clk(clk),
        .reset(reset),
        .MemWrite(MemWrite),
        .MemRead(MemRead),
        .Address(Address),
        .WriteData(WriteData),
        .MemData_out(MemData_out)
    );

    // Geração do clock: alterna a cada 5 ns (período = 10 ns)
    always #5 clk = ~clk;

    // Procedimento principal
    initial begin
        // Inicializa os sinais
        $dumpfile("teste.vcd");
        $dumpvars(0,testbench);

        clk = 0;
        reset = 0;
        MemWrite = 0;
        MemRead = 0;
        Address = 0;
        WriteData = 0;

        // ---------- Teste 1: RESET ----------
        $display("\n=== TESTE 1: RESET ===");
        reset = 1;
        #10; // Espera um ciclo de clock
        reset = 0;

        // ---------- Teste 2: ESCRITA ----------
        $display("\n=== TESTE 2: ESCRITA ===");
        @(posedge clk);
        MemWrite = 1;
        Address = 4'b0001;
        WriteData = 8'b1010_1010;
        @(posedge clk);
        MemWrite = 0;

        @(posedge clk);
        MemWrite = 1;
        Address = 4'b0010;
        WriteData = 8'b1111_0000;
        @(posedge clk);
        MemWrite = 0;

        // ---------- Teste 3: LEITURA ----------
        $display("\n=== TESTE 3: LEITURA ===");
        @(posedge clk);
        MemRead = 1;
        Address = 4'b0010;
        #1; // pequeno atraso para leitura estabilizar
        $display("Leitura [5] = %b (esperado: 10101010)", MemData_out);

        @(posedge clk);
        Address = 4'b0001;
        #1;
        $display("Leitura [10] = %b (esperado: 11110000)", MemData_out);

        // ---------- Teste 4: Leitura de endereço não escrito ----------
        @(posedge clk);
        Address = 4'b0000;
        #1;
        $display("Leitura [3] = %b (esperado: 00000000)", MemData_out);
        MemRead = 0;

        // ---------- Fim da simulação ----------
        $display("\n=== TESTE FINALIZADO ===\n");
        #10;

        #2 $finish;
    end

endmodule
