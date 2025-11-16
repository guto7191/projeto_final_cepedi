module Rom (
    input reset,
    input [7:0] ler_endereco,
    output [7:0] instrucao_out
);

integer k;

reg [7:0] memoria [0:32]; // 32 registradores de 8 bits

assign instrucao_out = memoria[ler_endereco];

always @(*)begin
    if(reset)begin
      for(k=0; k < 32; k= k + 1)begin
            memoria[k] = 8'b0000_0000;
        end
    end else begin 
       // Inicilaizar manualmente a memória 
        for(k=0; k < 32; k= k + 1)begin
            memoria[k] = k;
        end
    end
end

endmodule 