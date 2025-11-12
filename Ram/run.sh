iverilog -o test.out -s testbench testbench.v Ram.v
vvp test.out
gtkwave teste.vcd
