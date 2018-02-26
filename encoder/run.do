if [file exists work] {vdel -all}
vlib work
vmap work work
vlog *.v
vlog *.sv
vsim -novopt work.encoder_test
run -all
