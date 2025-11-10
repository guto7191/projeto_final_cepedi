module BancoRegistrador(
	input clk, 	
	input write, // sinal de escrita vindo unidade de controle
	input reset, // reset 
	input [1:0] sr1,
	input [1:0] sr2,
	input [1:0] dr,
	input [7:0] wrData,
	output [7:0] rdData1,
	output [7:0] rdData2
); 

reg [7:0] regFile[0:3]; //  4 registradores de 8 bits
integer k;

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