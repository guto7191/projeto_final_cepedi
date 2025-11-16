module Ram(
    input clk,
    input reset,
    input MemWrite,
    input MemRead,
    input [3:0] Address,
    input [7:0] WriteData,
    output [7:0] MemData_out
);

integer k; 
reg [7:0] memoria_dados[0:15];

always @(posedge clk) begin
    if(reset)begin
        for(k=0; k<16; k=k+1)begin
            memoria_dados[k] <= 8'b0000_0000;
        end
    end else if(MemWrite)begin 
        memoria_dados[Address] <= WriteData;
    end
end

assign MemData_out = (MemRead) ? memoria_dados[Address] : 8'b0000_0000;  

endmodule