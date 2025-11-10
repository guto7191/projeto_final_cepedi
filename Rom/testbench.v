module testbench;

reg reset;
reg [7:0] ler_endereco;
wire [7:0] instrucao_out;
integer k;

Rom rom(
    .reset(reset),
    .ler_endereco(ler_endereco),
    .instrucao_out(instrucao_out)
);



initial begin
    $dumpfile("teste.vcd");
    $dumpvars(0,testbench);

    #1 reset = 1'b1;
    #1 ler_endereco = 8'b0000_0000;

    for(k=0; k < 32; k=k+1)begin
        #1 ler_endereco = ler_endereco + 8'b0000_0001; 
    end


end




endmodule
