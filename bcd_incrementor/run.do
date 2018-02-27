if [file exists work] {vdel -all}
vlib work
vmap work work
vlog *.sv *.v
vsim work.bcd_incrementor_test
run -all
