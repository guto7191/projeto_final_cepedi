module testbench;

reg clk, reset;

cpu_top cpu (
    .clk(clk),
    .reset(reset)
);
    
initial begin
    clk = 1'b0;
end 

always #100 clk = ~clk; // Período = 20 us
    
initial begin 
    $dumpfile("teste.vcd");
    $dumpvars(0, testbench);

    // reset ativo por 3 ciclos de clock
    reset = 1'b1;
    #600;    
    reset = 1'b0;

    // roda simulação por tempo suficiente
    #500000;  

    $finish;
end

endmodule
