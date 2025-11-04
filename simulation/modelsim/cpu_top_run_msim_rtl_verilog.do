transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+/home/aug/Documents/projeto_final_cepedi {/home/aug/Documents/projeto_final_cepedi/BancoRegistrador.v}

