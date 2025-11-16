module ALU(
	input [7:0] A,
	input [7:0] B,
	input [1:0] Controle_ALUop,
	output reg zero,
	output reg [7:0] resultado_ALU
);

	always @(*) begin
		
		case(Controle_ALUop)
			2'b00: begin //add
				resultado_ALU = A + B;
				zero = (resultado_ALU == 8'b0) ? 1'b1 : 1'b0;
			end
			
			2'b01: begin //sub
				resultado_ALU = A - B;
				zero = (A == B) ? 1'b1 : 1'b0; 
			end
			
			2'b10: begin //and
				resultado_ALU = A & B;
				zero = (resultado_ALU == 8'b0) ? 1'b1 : 1'b0;
			end
			
			2'b11: begin //or
				resultado_ALU = A | B;
				zero = (resultado_ALU == 8'b0) ? 1'b1 : 1'b0;
			end
			
			default: begin
				zero = 1'b0;
				resultado_ALU = 8'b0000_0000;
			end
		
		endcase
	
	end

	
endmodule 