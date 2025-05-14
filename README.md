# Menshen port on the OpenNIC platform
This projects consists in the parameterization of the [Menshen](https://github.com/multitenancy-project/menshen) pipeline, an hardware library for an High-Speed Programmable Packet-Processing Pipeline, and the integration of an ARFS (Accelerated Receive Flow Steering) logic for better load balancing and performance isolation across the PCIe-side QDMA queues.<br />
You can read Menshen's paper and learn about the project [here](https://www.usenix.org/system/files/nsdi22-paper-wang_tao.pdf) and about ARFS [here](https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/6/html/performance_tuning_guide/network-acc-rfs).

The integration consists in the development within the AMD's [OpenNIC](https://github.com/Xilinx/open-nic-shell) platform, which is an open-source FPGA-based NIC, of a 250MHz user plugin box that wraps Menshen's pipeline inside. The project also comes with the testbenches, both in simulation and in real hardware, by using a machine with an FPGA as NIC, to verify that all of the pipeline features properly work.
## Directory structure
```sh
menshen-open-nic/
├── arfs/                       # Simulation unit tests for the arfs implementation module
├── implementation_testbenches  # Tests to be executed in real hardware, after bitstream
│                               # deployment
├── open-nic-tbs/               # Simulation unit tests for the complete OpenNIC component
├── p4s/                        # Source configuration files for our tests, written using
│                               # the P4 language
├── patch_files/                # diff patches for modifying the OpenNIC environment and
│                               # the Xilinx cam IPs
├── pipeline_tbs/               # Simulation unit tests for Menshen pipeline by itself
├── src/                        # OpenNIC user plugin template, accordingly patched for
│                               # the architecture of Menshen
└── menshen-open-nic.sh         # Script for project generation
```
## How to build
In order to build successfully the project, the [Xilinx Content Addressable Memory (CAM) IP](https://www.amd.com/en/products/adaptive-socs-and-fpgas/intellectual-property/ef-di-cam.html) licese must be obtained and installed. <br />
The build process consists on running a script that will clone the OpenNIC repository and patch the files necessary for building and testing the component on the OpenNIC platform.
1. Clone the repo and enter the folder you just cloned
   ```sh
   git clone --recurse-submodules https://github.com/system-fab/mensheNIC.git && cd mensheNIC
   ```
2. Give to the script the necessary permissions
   ```sh
   chmod +x menshen-open-nic.sh
   ```
3. Run the script
   ```sh
   ./menshen-open-nic.sh
   ```
   if only the simulation environment is needed.<br />
   Otherwise add the "impl" parameter if you want to generate the bistream and test the component in real hardware on an FPGA board
   ```sh
   ./menshen-open-nic.sh impl
   ```
4. In order to include the component inside OpenNIC you will need to build with one of those commands, using Vivado 2022.1:<br />
   For test simulation:
   ```sh
   cd path/to/mensheNIC/open-nic-shell/script
   vivado -mode tcl -source build.tcl -tclargs -board au280 -user_plugin ../../src
   ```
   For implementation add the *impl* and *post_impl* flags (respectively for bitstream generation and mcs file generation):
   ```sh
   cd path/to/mensheNIC/open-nic-shell/script
   vivado -mode tcl -source build.tcl -tclargs -board au280 -impl 1 -post_impl 1 -user_plugin ../../src
   ```

## Project description
### Overall design
The project overall architecture is composed by an FPGA board used as SmartNIC within a Linux-based machine, which receives and transmits packets using an ARFS logic on the PCIe-side to spread incoming packets across the queues of the QDMA.

![](/resources/Architecture.png)

### OpenNIC architecture
For the SmartNIC architecture the AMD's OpenNIC Project was leveraged, deploying the pipeline within the 250MHz user box, which communicates to the [QDMA](https://www.amd.com/en/products/adaptive-socs-and-fpgas/intellectual-property/pcie-qdma.html) submodule on the host machine side and with the [CMAC](https://docs.amd.com/r/en-US/ug974-vivado-ultrascale-libraries/CMAC) subsystem on the outside network side (using respectively the PCIe interface and the QSFP interface).

![](/resources/RX_TX_pipeline.png)

### RMT-like pipeline
The pipeline instantiated within the user box is an [RMT](https://dl.acm.org/doi/10.1145/2486001.2486011) based pipeline with isolation techniques for multi-tnant environments, as proposed by the Menshen architecture paper for programmable switches.

![](/resources/Menshen_pipeline.png)

### Custom header structure
The header structure of incoming packets is compleatly customizable and protocol independent, by defining it in the P4 script.<br />
For example in the tests conducted, after the L4 layer, four additional header fields were added and used as: operation code, operands, result of the operation.

![](/resources/Packet_header_simplified.png)
![](/resources/Packet_header_1.png)
![](/resources/Packet_header_2.png)

## How to write, compile and load a P4 script
The pipeline behaviour can be dynamically configured using a P4 script to generate a bitstream configuration of the pipeline, which is then translated by a [python script](/implementation_testbenches/python_converter.py) into packets to be sent to the SmartNIC in the appropriate direction (transmission or reception).<br />
For compilation of the [P4 scripts](/p4s) use the [backend provided](https://github.com/multitenancy-project/menshen-compiler) for Menshen and patch it, before building it with the make file, using the compiler's [patch file](/p4s/menshen_compiler.patch) in order to adapt it for a parametric pipeline used on within a smartNIC.<br />
After writing the P4 program/s, to generate a bitstream of the configuration run the following commands:
```sh
/PATH-TO-COMPILER-BACKEND/p4c-fpga --outputfile stateconf.txt --conffile allocate.txt --statefulconf 1
/PATH-TO-COMPILER-BACKEND/p4c-fpga ./prog_1.p4 --vid 1 --outputfile conf1.txt --conffile allocate.txt
/PATH-TO-COMPILER-BACKEND/p4c-fpga ./prog_2.p4 --vid 2 --outputfile conf2.txt --conffile allocate.txt
/PATH-TO-COMPILER-BACKEND/p4c-fpga ./prog_3.p4 --vid 3 --outputfile conf3.txt --conffile allocate.txt
...
```
use the "--vid" parameter to bind a P4 program to a different VLAN ID

In the end, to generate the packets used to configure the pipeline with the P4 program/s compiled, execute the [python script](/implementation_testbenches/python_converter.py) in the same folder containing the grouped P4 script generated files (the name of the folder containing the generated files must be "p4_generated").<br />
N.B: if multiple programs are compiled together, remember to add as an argument of the python script the number of compiled programs.
Example:
```sh
python python_converter 3
```

## aRFS configuration
In order to configure the aRFS table use the [python script](/arfs/arfs_conf_gen.py) within the arfs folder passing as arguments:
1. the interface used for the smartNIC
2. the destination address
3. the command (insert = 1, update = 0)
4. the content of the table's entry (the queue ID)
5. the vlan of the packet (the key of the table's entry)

Example:
```sh
python3 arfs_conf_gen.py wlan0 192.168.1.2 1 250 15
```

## Physical functions and multiple pipelines
OpenNIC allows to instantiate up to 4 physical functions which are mapped to a different network interface and a different PCIe lane.<br />
In this project up to 2 physical funtions can be instantiated and for each physical function a new independent pipeline is connected, having a different length in the number of stages.<br />
Each physical funtion is than connected to a CMAC instance, since the openNIC design supports up to 2 CMAC submodules.<br />
The command used to build a design with 2 pipelines is the following:
```sh
vivado -mode tcl -source build.tcl -tclargs -board au280 -num_cmac_port 2 -num_phys_func 2 -user_plugin ../../src
```

## Parameterization
The length of the pipeline can be customized and changed before the synthesis of the openNIC design. This allows the pipeline to accommodate more complex offloaded programs, with longer data dependency chains.<br />
This was possible thanks to the RMT design, where each stage in the pipeline takes as inputs the results from the previous stage, adding a new possible layer of data dependency.

To change the number of stages for the pipeline, the parameter *"PIPE_SIZE"* in the [p2p_250mhz.sv](/src/p2p_250mhz.sv) file can be changed. Each value in this parameter array is referenced to a different physical funtion (when there is only 1 physical function instantiated, only the first value will be used)

The pipeline lengths tested goes from 3 stages up to 16 stages, at 17 stages the utilization of the board used (the alveo u280) is too high and the timing closure becomes difficult to achieve. 

The utilization of the pipeline as a function in the number of stages can be seen in the picture below:

![](/resources/graph_Utilization.png)

## Sidenotes
The project has been tested (both in simulation and after deployment) on an Alveo U280 board and on an Alveo U55C, for the latter tests were executed only in simulation and by generating the bitstream, to check that the timing closure was achieved. Therefore support on other Alveo boards isn't guaranteed.

For better replicability, use the same open-nic shell and driver versions:
- for the open-nic-shell checkout at the commit *80777515c83cc04d8497522669aa82dd914d1e08*
- for the open-nic-driver checkout at the commit *1cf25782ba39bb23fe6cfbc75eac6ee0b6249e76*

Regarding the menshen submodule and its compiler:
- for menshen checkout at the commit *fc968bf28626c8f8a610592749a8b2542f0c1f0f*
- for the P4C backend checkout at the commit *367bef8dd37b76b97fd2f8cf51b86249349e3fdf* before using the ["menshen_compiler.patch"](/p4s/menshen_compiler.patch)


