module ProgramCounter(
    input clk, reset,
    input [3:0] data_in, // 1 byte == 4 bits 
    output reg [3:0] data_out
);

always @(posedge clk)begin
    if(reset)begin
        data_out <= 4'b0000; // reset do registrador PC
    end else begin
        data_out <= data_in; // Atibuicao do endereco da proxima instrucao
    end
end

endmodule