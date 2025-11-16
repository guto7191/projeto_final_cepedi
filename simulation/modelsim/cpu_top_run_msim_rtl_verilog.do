transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+/home/aug/Documents/projeto_final_cepedi {/home/aug/Documents/projeto_final_cepedi/cpu_top.v}
vlog -vlog01compat -work work +incdir+/home/aug/Documents/projeto_final_cepedi {/home/aug/Documents/projeto_final_cepedi/BancoRegistrador.v}
vlog -vlog01compat -work work +incdir+/home/aug/Documents/projeto_final_cepedi {/home/aug/Documents/projeto_final_cepedi/ALU.v}
vlog -vlog01compat -work work +incdir+/home/aug/Documents/projeto_final_cepedi {/home/aug/Documents/projeto_final_cepedi/Controle.v}
vlog -vlog01compat -work work +incdir+/home/aug/Documents/projeto_final_cepedi {/home/aug/Documents/projeto_final_cepedi/Rom.v}
vlog -vlog01compat -work work +incdir+/home/aug/Documents/projeto_final_cepedi {/home/aug/Documents/projeto_final_cepedi/Ram.v}
vlog -vlog01compat -work work +incdir+/home/aug/Documents/projeto_final_cepedi {/home/aug/Documents/projeto_final_cepedi/ProgramCounter.v}
vlog -vlog01compat -work work +incdir+/home/aug/Documents/projeto_final_cepedi {/home/aug/Documents/projeto_final_cepedi/SomadorPC.v}
vlog -vlog01compat -work work +incdir+/home/aug/Documents/projeto_final_cepedi {/home/aug/Documents/projeto_final_cepedi/Mux2x1.v}

