iverilog -o teste.out -s testbench testbench.v ProgramCounter.v
vvp teste.out
gtkwave teste.vcd