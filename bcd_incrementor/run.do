if [file exists work] {vdel -all}
vlib work
vmap work work
vlog *.sv *.v
vsim -novopt work.bcd_incrementor_test
run -all
vsim -novopt work.tbforBCDinc
run -all
