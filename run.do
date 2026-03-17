vdel -all
vlib work
vmap work work
vcom rtl/ffd.vhd
vcom tb/ffd_tb.vhd
vsim -voptargs=+acc work.ffd_tb
add wave -r /*
run 50ms

# vsim -do run.do