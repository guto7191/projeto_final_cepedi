module testbench;

reg[1:0] sr1, sr2, dr;
reg[7:0] wrData;
reg clk, reset, write;
wire [7:0] rdData1, rdData2;
integer k;

BancoRegistrador BR (.clk(clk), .write(write), .reset(reset), .sr1(sr1), .sr2(sr2), .dr(dr), .wrData(wrData), .rdData1(rdData1), .rdData2(rdData2));

initial begin
    clk = 0;
end

always #5 clk = ~clk;

initial begin
    $dumpfile("teste.vcd");
    $dumpvars(0, testbench);

    #1 reset = 1; write = 0;
    #5 reset = 0;

    #7;
    for(k=0; k<8; k=k+1)begin
        dr = k;
        wrData = 10 * k; 
        write = 1;
        #10 write = 0;
    end


    for(k=0; k<7; k=k+1)begin
        sr1 = k;
        sr2 = k+1;
        #5;
        $display("reg[%2d] = %d, reg[%2d] = %d", sr1, rdData1, sr2, rdData2);
    end

    #2000;
    $finish; 
end
endmodule