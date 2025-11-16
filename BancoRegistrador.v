module BancoRegistrador(
	input clk,
	input write,
	input reset,
	input	[1:0] reg_dest, // 00=A, 01=B seleciona qual registrador escrever
	input [7:0] wrData,
	output [7:0] regA_out,
	output [7:0] regB_out
);


	//registradores
	reg [7:0] regA;
	reg [7:0] regB;
	
	// saida dos dados
	assign regA_out = regA;
	assign regB_out = regB;

	always @(posedge clk) begin
		if(reset)begin
			regA <= 8'b0000_0000;
			regB <= 8'b0000_0000;
		end else begin
			if(write)begin
				case (reg_dest)
                2'b00: regA <= wrData;  // Escreve em A
                2'b01: regB <= wrData;  // Escreve em B
                default: ; // Não faz nada
            endcase
			end
		end
	end

endmodule 