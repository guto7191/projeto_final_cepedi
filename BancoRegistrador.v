module BancoRegistrador(
	input clk, 	
	input write, // sinal de escrita vindo unidade de controle
	input reset, // reset 
	input [1:0] sr1, // endereço registrador 1
	input [1:0] sr2, // endereço registrador 2
	input [1:0] dr, // endereço para escrita
	input [7:0] wrData, // escrita de dado no registrador
	output [7:0] rdData1, // leitura do dado no registrador 1
	output [7:0] rdData2  // leitura do dado no registrador 2
); 

integer k;
reg [7:0] regFile[0:3]; // 4 X 8 
/*
mapeamento de endereços
sr1/sr2 = 2'b00 - regFile[0] - R0
sr1/sr2 = 2'b01 - regFile[1] - R1  
sr1/sr2 = 2'b10 - regFile[2] - R2
sr1/sr2 = 2'b11 - regFile[3] - R3
*/

// Estruturado dessa forma pq eh monociclo 
assign rdData1 = regFile[sr1]; 
assign rdData2 = regFile[sr2];

always @(posedge clk) begin
	if(reset)begin
		for(k=0; k<4; k=k+1)begin 
			regFile[k] <= 0;
		end
	end else begin
		if(write) 
			regFile[dr] <= wrData;
	end
end

endmodule