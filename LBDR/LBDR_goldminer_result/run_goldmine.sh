#!/bin/bash

# NOTE: All command line paths are relative to the RunTime directory

python ../src/goldmine.py -m LBDR -c clk:1  -u ../ -I ../verilog/LBDR -S -V -F ./vfiles/vfile_LBDR

