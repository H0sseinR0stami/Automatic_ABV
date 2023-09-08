SIM ?= icarus
TOPLEVEL_LANG ?= verilog

VERILOG_SOURCES += $(PWD)/../rtl/LBDR.sv
VERILOG_SOURCES += $(PWD)/../wrapper/LBDR_wrapper.sv
TOPLEVEL = LBDR_wrapper
MODULE = LBDR_test
include $(shell cocotb-config --makefiles)/Makefile.sim