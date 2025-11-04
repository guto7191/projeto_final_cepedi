module testbench;

reg clk, reset;
reg [3:0] data_in;
wire [3:0] data_out;
integer k;

ProgramCounter PC(.clk(clk), .reset(reset), .data_in(data_in), .data_out(data_out));

initial begin 
    clk = 1'b0;
end

always #5 clk = ~clk;

initial begin 
    $dumpfile("teste.vcd");
    $dumpvars(0,testbench);

    $monitor("clk = %b | reset = %b | data_in = %b | data_out = %b", clk, reset, data_in, data_out);    
    #1 data_in = 4'b0000;

    #1 reset = 1'b1;
    #1 reset = 1'b0;
    
    for(k=0; k<16; k=k+1)begin
        #20 data_in = data_in + 4'b0001;
    end 
   
    #2 $finish;
end

endmodule