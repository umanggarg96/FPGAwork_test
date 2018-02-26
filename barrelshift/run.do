if [file exists work] {vdel -all}
vlib work
vmap work work
vlog *.sv *.v
vsim -novopt work.barrelshift_test
run -all

