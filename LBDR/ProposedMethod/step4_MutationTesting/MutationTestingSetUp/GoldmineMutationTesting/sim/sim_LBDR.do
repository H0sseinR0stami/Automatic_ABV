
#vsim -do sim_LBDR.do

# create the Library working directory
vlib work

# compile the src and tb files along with the includes and options

if {[catch {
    vlog -work work -vopt +incdir+../include -nocovercells "../rtl/LBDR.sv"
} result]} {
    quit -f
}

vlog -work work -vopt +incdir+../include -nocovercells "../rtl/LBDR.sv"
vlog -work work -vopt +incdir+../include -nocovercells "../tb/tb.sv" -assertdebug -cover bcefsx

# simulate the top file(testbench)
vsim -assertdebug -t 1ns -coverage -voptargs="+cover=bcesfx"  work.tb

# View Assertions
view assertions

# add the signals into waveform
add wave -noupdate sim:/tb/*
	
#run the simulation
run -all

# xml reports
coverage report -assert -detail -verbose -xml -output LBDR_assertion_report.xml  :

quit -f
