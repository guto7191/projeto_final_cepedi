module ALU(
    input [7:0] A;
    input [7:0] B;
    input [1:0] Controle_ALUop,
    output reg zero;
    output reg [7:0] resultado_ALU
);
/*
// Agora podemos ter:
2'b00 = Operações aritméticas (ADD, ADDI)
2'b01 = Operações de comparação (SUB, SLT, BEQ)  
2'b10 = Operações lógicas (AND, ANDI)
2'b11 = Operações lógicas (OR, ORI)
*/



always @(A, B, Controle_ALUop)begin
    case (Controle_ALUop)
        
        2'b00:begin
            zero <= 1'b0;
            resultado_ALU <= A + B;
        end

        2'b01: begin
            if(A==B) zero <= 1'b1;
            else zero <= 1'b0;
            resultado_ALU <= A - B;
        end

        2'b10: begin
            zero <= 0;
            resultado_ALU <= A & B;
        end

        2'b11: begin
            zero <= 0;
            resultado_ALU <= A | B;
        end
        default: 
    endcase
end 


endmodule