/*module Ram (
	input	clk,
	input reset,
	input MemWrite,
	input MemRead,
	input [7:0] Address,
	input [7:0] WriteData,
	output reg [7:0] MemData_out
);

	integer k;
	reg [7:0] memoria_dados[0:63]; // 64 bytes
	
	always @(posedge clk) begin
		if(reset) begin
			for(k=0; k<63; k=k+1) begin
				memoria_dados[k] <= 8'b0000_0000; 
			end
		
			MemData_out <= 8'b0000_0000; 
		
		end else begin 
			if(MemWrite)begin
				memoria_dados[Address] <= WriteData;
			end
			
			if(MemRead) begin
				MemData_out <= memoria_dados[Address];
			end else begin
				MemData_out <= 8'b0000_0000;
			end
				
		end	
			
	end

endmodule
*/

module Ram ( 
	input clk,
	input reset,
	input MemWrite,
	input MemRead,
	input [7:0] Address,
	input [7:0] WriteData,
	output reg [7:0] MemData_out
);


	integer k;
	
	reg [7:0] memoria_dados[0:63];

	
	// Escrita síncrona e inicialização no reset (síncrono)
	always @(posedge clk) begin
        if (reset) begin
            for (k = 0; k < 64; k = k + 1) begin
                memoria_dados[k] <= 8'b0000_0000;
            end
        end else begin
            if (MemWrite) begin
                memoria_dados[Address] <= WriteData;
            end
        end
    end

	 
	 // leitura assincrona / combinacional
	 always @(*) begin
        if (MemRead) begin
            // proteger acesso fora do range (opcional)
            if (Address <= 8'd63)
                MemData_out = memoria_dados[Address];
            else
                MemData_out = 8'b0000_0000;
        end else begin
            MemData_out = 8'b0000_0000;
        end
    end
	 
	 
endmodule 












 