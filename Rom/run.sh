iverilog -o test.out -s testbench testbench.v Rom.v
vvp test.out
gtkwave teste.vcd
