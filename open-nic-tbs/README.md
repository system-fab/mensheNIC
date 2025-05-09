# Open-nic testbenches
This folder contains:
- the testbenches for the menshen integration in opennic
- the "configurations" folder, where there are the files containing the configurations of the menshen pypeline for each testbench
- the "conf_packets_generation.py" file, which is similar to *the verilog_converter.py* file of the *p4s* folder
- 2 *.mem* files, used during the simulation to initialize the board memory

## Conf_packets_generation.py
To create a correct configuration file, copy the desired p4 compiled testbench folder in this directory and rename it to "p4_generted".<br />
After doing so execute the python script passing as argument the number of programs instantiated of the menshen pipeline and the type of packet's length signal of the axi stream protocol (the 2 arguments accepted are **tkeep** and **tuser_mty**, the default is tuser_mty).<br />
Example: 
```sh
python3 conf_packets_generation.py 1
```
