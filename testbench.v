//`timescale 1ns/1ps

module testbench;

    reg clk;
    reg reset;

    // Instancia a CPU
    cpu_top DUT (
        .clk(clk),
        .reset(reset)
    );

    //============================
    //  Clock
    //============================
    initial begin
        clk = 0;
        forever #10 clk = ~clk;   // clock de 10ns (100 MHz)
    end

    //============================
    //  Reset
    //============================
    initial begin
        reset = 1;
        #20;
        reset = 0;
    end

    //============================
    //  Monitoramento
    //============================
    initial begin
        $display("=== Iniciando Simulação ===");

        $monitor(
            "t=%0dns | PC=%02h | Instr=%02h | A=%02h | B=%02h | ALU=%02h |	Zero=%b | EQ=%b | write_reg_data=%b | ram_write_data=%b | ram_data_out=%b",
            $time,
            DUT.PC_out,
            DUT.instrucao,
            DUT.regA,
            DUT.regB,
            DUT.alu_result,
            DUT.alu_zero,
            DUT.alu_eq,
				DUT.write_reg_data,
				DUT.ram_write_data,
				DUT.ram_data_out
        );
    end

    //============================
    //  Tempo de simulação
    //============================
    initial begin
        #3000;      // roda 300ns
        $display("=== Fim da Simulação ===");
        $stop;
    end

endmodule
