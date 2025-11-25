module ALU(
	input [7:0] A,
	input [7:0] B,
	input [2:0] ALUOp,
	output reg [7:0] resultado,
	output zero,
	output eq
);


		always @(*) begin
			case(ALUOp)
				3'b000: resultado = A + B;
				3'b001: resultado = A - B;	
				3'b010: resultado = A & B; 
				3'b011: resultado = A | B;
				3'b100: resultado = A;
				default: resultado = 8'b0000_0000;
			endcase
		end

		assign zero = (resultado == 8'b0000_0000);
		assign eq = (A == B);

endmodule