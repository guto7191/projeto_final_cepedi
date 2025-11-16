module SomadorPC(
	input [7:0] PC_endereco,
	output reg [7:0] next_endereco
);


	always @(*) begin
		next_endereco = PC_endereco + 8'b0000_0001;
	end

endmodule 