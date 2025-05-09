# P4 Scripts
This folder contains the P4 examples used in order to test the menshen pipeline.<br />
In each folder there is the P4 script and the compiled files with the comfiguration of the pipeline; in order to recompile them please check the [menshen compiler](https://github.com/multitenancy-project/menshen-compiler.git).

The python script "verilog_converter.py" is used to convert the compiled P4 files into verilog code, in order to simulate and test the menshen pipeline. To convert a P4 example, rename the desired folder into "p4_generated" and run the python script.

## Menshen compiler
In order to recompile all the scripts, after cloning the [menshen compiler](https://github.com/multitenancy-project/menshen-compiler.git) and before building it, apply the **"menshen_compiler.patch"** with the command:
```sh
patch -s -p0 < menshen_compiler.patch
```
executed in the folder containing the menshen-compiler repo.
