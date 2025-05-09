set design TProj
set sim_top arfs_tb.sv
set device xcu250-figd2104-2-e
set proj_dir ./project_sim

create_project -name ${design} -force -dir "${proj_dir}" -part ${device}
set_property source_mgmt_mode DisplayOnly [current_project]

create_fileset -constrset -quiet constrants
update_ip_catalog

create_ip -name cam -vendor xilinx.com -library ip -version 2.3 -module_name cam_arfs
set_property -dict [list \
	CONFIG.MODE {CBCAM} \
	CONFIG.NUM_ENTRIES {16} \
	CONFIG.KEY_WIDTH {12} \
	CONFIG.RESP_WIDTH {11} \
	CONFIG.LOOKUP_RATE {125} \
	CONFIG.LOOKUP_INTERFACE_FREQ {250} \
	CONFIG.CLOCKING_MODE {SINGLE CLOCK} \
] [get_ips cam_arfs]


set_property generate_synth_checkpoint false [get_files cam_arfs.xci]
reset_target all [get_ips cam_arfs]
generate_target all [get_ips cam_arfs]


update_ip_catalog
####################

# rmt-related
read_verilog "./qdma_subsystem_function.sv"
read_verilog "./dependencies/axi_lite_register.sv"
read_verilog "./dependencies/axi_stream_register_slice.sv"
read_verilog "./dependencies/qdma_subsystem_function_register.sv"

set_property SOURCE_SET sources_1 [get_filesets sim_1]
add_files -fileset sim_1 -norecurse arfs_tb.sv
set_property top arfs_tb [get_filesets sim_1]
set_property top_lib xil_defaultlib [get_filesets sim_1]
update_compile_order -fileset sim_1

set_property include_dirs ${proj_dir} [get_filesets sim_1]
set_property simulator_language Mixed [current_project]
set_property verilog_define { {SIMULATION=1} } [get_filesets sim_1]
set_property -name xsim.more_options -value {-testplusarg TESTNAME=basic_test} -objects [get_filesets sim_1]
set_property runtime {} [get_filesets sim_1]
set_property target_simulator xsim [current_project]
set_property compxlib.compiled_library_dir {} [current_project]
set_property top_lib xil_defaultlib [get_filesets sim_1]
update_compile_order -fileset sim_1

set_property source_mgmt_mode All [current_project]
update_compile_order -fileset sources_1
set_property -name {xsim.simulate.runtime} -value {10000ns} -objects [get_filesets sim_1]

launch_simulation -simset sim_1 -mode behavioral
run 10us



exit
