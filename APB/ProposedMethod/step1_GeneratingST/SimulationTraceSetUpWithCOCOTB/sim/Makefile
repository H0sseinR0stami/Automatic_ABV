SIM ?= icarus
TOPLEVEL_LANG ?= verilog

VERILOG_SOURCES += $(PWD)/../rtl/APB.v
VERILOG_SOURCES += $(PWD)/../wrapper/APB_wrapper.sv
TOPLEVEL = APB_wrapper
MODULE = APB_test
include $(shell cocotb-config --makefiles)/Makefile.sim
