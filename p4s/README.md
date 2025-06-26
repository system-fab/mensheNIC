# P4 Scripts
This folder contains the P4 examples used in order to test the menshen pipeline.<br />
In each folder there is the P4 script and the compiled files with the comfiguration of the pipeline; in order to recompile them please check the [menshen compiler](https://github.com/multitenancy-project/menshen-compiler.git).

The python script "verilog_converter.py" is used to convert the compiled P4 files into verilog code, in order to simulate and test the menshen pipeline. To convert a P4 example, rename the desired folder into "p4_generated" and run the python script.
If more than one P4 configurations should be loaded on the NIC, to generate a single verilog file specify also the number of programs as an argument.<br />
Example: 
```sh
python verilog_converter.py 4
```
N.B: in this last case, the P4 configurations should be named (within the p4_generated folder) "p4_generated/conf**N**.txt", where N is an incremental number starting from 1. 
The configuration generated as verilog will respect this order.

## Menshen compiler
In order to recompile all the scripts, after cloning the [menshen compiler](https://github.com/multitenancy-project/menshen-compiler.git) and before building it, apply the **"menshen_compiler.patch"** with the command:
```sh
patch -s -p0 < menshen_compiler.patch
```
executed in the folder containing the menshen-compiler repo.
