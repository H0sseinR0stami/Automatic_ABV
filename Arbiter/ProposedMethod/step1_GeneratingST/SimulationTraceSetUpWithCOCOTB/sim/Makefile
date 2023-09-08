SIM ?= icarus
TOPLEVEL_LANG ?= verilog

VERILOG_SOURCES += $(PWD)/../rtl/Arbiter.v
VERILOG_SOURCES += $(PWD)/../wrapper/Arbiter_wrapper.sv
TOPLEVEL = Arbiter_wrapper
MODULE = Arbiter
include $(shell cocotb-config --makefiles)/Makefile.sim
