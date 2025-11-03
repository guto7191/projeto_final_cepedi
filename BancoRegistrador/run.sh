iverilog -o test.out -s testbench testbench.v BancoRegistrador.v
vvp test.out
gtkwave teste.vcd
