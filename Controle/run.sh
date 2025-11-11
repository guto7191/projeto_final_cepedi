iverilog -o test.out -s testbench testbench.v Controle.v
vvp test.out
gtkwave teste.vcd
