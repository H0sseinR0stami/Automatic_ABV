#!/bin/bash

# NOTE: All command line paths are relative to the RunTime directory

python ../src/goldmine.py -m APB -c PCLK:1  -u ../ -I ../verilog/APB -S -V -F ./vfiles/vfile_APB

