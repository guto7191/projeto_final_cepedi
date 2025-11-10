module Rom (
    input reset,
    input [7:0] ler_endereco,
    output [7:0] instrucao_out
);

integer k;

reg [7:0] memoria [31:0]; // 32 registradores de 8 bits

assign trucao_out = memoria[ler_endereco];

always @(*)begin
    if(reset)begin
      for(k=0; k < 32; k= k + 1)begin
            memoria[k] = 8'b0000_0000;
        end
    end else begin 
       // Inicilaizar manualmente a memória 
        memoria[0] = 8'b0000_0001;
        memoria[1] = 8'b0000_0010; 
        memoria[2] = 8'b0000_0011;
        memoria[3] = 8'b0000_0100;
    end
end

endmodule 