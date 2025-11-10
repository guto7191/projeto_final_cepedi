module SomadorPC(
    input [7:0] PC_endereco,
    output reg [7:0 ]next_endereco;
);

always @(PC_endereco) begin

    next_endereco = PC_endereco + 8'b0000_0001; //incrementar 4 bits para proximo endereço 

end 



endmodule