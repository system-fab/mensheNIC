#!/bin/bash

# generate configurations of stateful memory, dummy p4 program
/home/vboxuser/Desktop/p4c_parametric/build/p4c-fpga --outputfile stateconf.txt --conffile allocate.txt --statefulconf 1
# sys program
/home/vboxuser/Desktop/p4c_parametric/build/p4c-fpga ./sys.p4 --vid 15 --outputfile confsys.txt --conffile allocate.txt --onlysys 1
# user program
/home/vboxuser/Desktop/p4c_parametric/build/p4c-fpga ./calc.p4 --vid 1 --outputfile conf1.txt --conffile allocate.txt

