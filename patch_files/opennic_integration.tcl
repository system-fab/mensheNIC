############# Menshen TCL
set apath {{VAR}}/menshen

source ${apath}/tcl/fifo.tcl

#Add Parser Action RAM IP
create_ip -name blk_mem_gen -vendor xilinx.com -library ip -version 8.4 -module_name parse_act_ram_ip
set_property -dict [list CONFIG.Memory_Type {Simple_Dual_Port_RAM} CONFIG.Load_Init_File {true} CONFIG.Coe_File ${apath}/memory_init_files/parse_act_ram_init_file.coe CONFIG.Write_Depth_A {32} CONFIG.Write_Width_A {160} CONFIG.Read_Width_A {160} CONFIG.Operating_Mode_A {NO_CHANGE} CONFIG.Write_Width_B {160} CONFIG.Read_Width_B {160} CONFIG.Enable_B {Use_ENB_Pin} CONFIG.Register_PortA_Output_of_Memory_Primitives {false} CONFIG.Register_PortB_Output_of_Memory_Primitives {true} CONFIG.Port_B_Clock {100} CONFIG.Port_B_Enable_Rate {100}] [get_ips parse_act_ram_ip]
set_property generate_synth_checkpoint false [get_files parse_act_ram_ip.xci]
reset_target all [get_ips parse_act_ram_ip]
generate_target all [get_ips parse_act_ram_ip]

create_ip -name blk_mem_gen -vendor xilinx.com -library ip -version 8.4 -module_name blk_mem_gen_0
set_property -dict [list CONFIG.Memory_Type {Simple_Dual_Port_RAM} CONFIG.Load_Init_File {true} CONFIG.Coe_File ${apath}/memory_init_files/alu_2.coe CONFIG.Write_Depth_A {32} CONFIG.Write_Width_A {32} CONFIG.Read_Width_A {32} CONFIG.Operating_Mode_A {NO_CHANGE} CONFIG.Write_Width_B {32} CONFIG.Read_Width_B {32} CONFIG.Enable_B {Use_ENB_Pin} CONFIG.Register_PortA_Output_of_Memory_Primitives {false} CONFIG.Register_PortB_Output_of_Memory_Primitives {true} CONFIG.Port_B_Clock {100} CONFIG.Port_B_Enable_Rate {100}] [get_ips blk_mem_gen_0]
set_property generate_synth_checkpoint false [get_files blk_mem_gen_0.xci]
reset_target all [get_ips blk_mem_gen_0]
generate_target all [get_ips blk_mem_gen_0]

create_ip -name blk_mem_gen -vendor xilinx.com -library ip -version 8.4 -module_name blk_mem_gen_1
set_property -dict [list CONFIG.Memory_Type {Simple_Dual_Port_RAM} CONFIG.Load_Init_File {true} CONFIG.Coe_File ${apath}/memory_init_files/lkup.coe CONFIG.Write_Depth_A {16} CONFIG.Write_Width_A {625} CONFIG.Read_Width_A {625} CONFIG.Operating_Mode_A {NO_CHANGE} CONFIG.Write_Width_B {625} CONFIG.Read_Width_B {625} CONFIG.Enable_B {Use_ENB_Pin} CONFIG.Register_PortA_Output_of_Memory_Primitives {false} CONFIG.Register_PortB_Output_of_Memory_Primitives {true} CONFIG.Port_B_Clock {100} CONFIG.Port_B_Enable_Rate {100}] [get_ips blk_mem_gen_1]
set_property generate_synth_checkpoint false [get_files blk_mem_gen_1.xci]
reset_target all [get_ips blk_mem_gen_1]
generate_target all [get_ips blk_mem_gen_1]

create_ip -name blk_mem_gen -vendor xilinx.com -library ip -version 8.4 -module_name blk_mem_gen_2
set_property -dict [list CONFIG.Memory_Type {Simple_Dual_Port_RAM} CONFIG.Load_Init_File {true} CONFIG.Coe_File ${apath}/memory_init_files/key_extract.coe CONFIG.Write_Depth_A {32} CONFIG.Write_Width_A {38} CONFIG.Read_Width_A {38} CONFIG.Operating_Mode_A {NO_CHANGE} CONFIG.Write_Width_B {38} CONFIG.Read_Width_B {38} CONFIG.Enable_B {Use_ENB_Pin} CONFIG.Register_PortA_Output_of_Memory_Primitives {false} CONFIG.Register_PortB_Output_of_Memory_Primitives {true} CONFIG.Port_B_Clock {100} CONFIG.Port_B_Enable_Rate {100}] [get_ips blk_mem_gen_2]
set_property generate_synth_checkpoint false [get_files blk_mem_gen_2.xci]
reset_target all [get_ips blk_mem_gen_2]
generate_target all [get_ips blk_mem_gen_2]

create_ip -name blk_mem_gen -vendor xilinx.com -library ip -version 8.4 -module_name blk_mem_gen_3
set_property -dict [list CONFIG.Memory_Type {Simple_Dual_Port_RAM} CONFIG.Load_Init_File {true} CONFIG.Coe_File ${apath}/memory_init_files/key_mask.coe CONFIG.Write_Depth_A {32} CONFIG.Write_Width_A {193} CONFIG.Read_Width_A {193} CONFIG.Operating_Mode_A {NO_CHANGE} CONFIG.Write_Width_B {193} CONFIG.Read_Width_B {193} CONFIG.Enable_B {Use_ENB_Pin} CONFIG.Register_PortA_Output_of_Memory_Primitives {false} CONFIG.Register_PortB_Output_of_Memory_Primitives {true} CONFIG.Port_B_Clock {100} CONFIG.Port_B_Enable_Rate {100}] [get_ips blk_mem_gen_3]
set_property generate_synth_checkpoint false [get_files blk_mem_gen_3.xci]
reset_target all [get_ips blk_mem_gen_3]
generate_target all [get_ips blk_mem_gen_3]


create_ip -name blk_mem_gen -vendor xilinx.com -library ip -version 8.4 -module_name page_tbl_16w_32d

set_property -dict [list \
	CONFIG.Memory_Type {Simple_Dual_Port_RAM} \
	CONFIG.Load_Init_File {true} \
	CONFIG.Coe_File ${apath}/memory_init_files/page_tlb.coe \
	CONFIG.Write_Depth_A {32} \
	CONFIG.Write_Width_A {16} \
	CONFIG.Read_Width_A {16} \
	CONFIG.Operating_Mode_A {NO_CHANGE} \
	CONFIG.Write_Width_B {16} \
	CONFIG.Read_Width_B {16} \
	CONFIG.Enable_B {Use_ENB_Pin} \
	CONFIG.Register_PortA_Output_of_Memory_Primitives {false} \
	CONFIG.Register_PortB_Output_of_Memory_Primitives {true} \
	CONFIG.Port_B_Clock {100} \
	CONFIG.Port_B_Enable_Rate {100} \
] [get_ips page_tbl_16w_32d]

set_property generate_synth_checkpoint false [get_files page_tbl_16w_32d.xci]
reset_target all [get_ips page_tbl_16w_32d]
generate_target all [get_ips page_tbl_16w_32d]
####################

update_ip_catalog

###
add_files "${apath}/memory_init_files/cam_init_file.mif"

###
read_vhdl -library cam  ${apath}/../xilinx_cam/dmem.vhd
read_vhdl -library cam  [glob ${apath}/../xilinx_cam/cam*.vhd]

# rmt-related
read_verilog "${apath}/fallthrough_small_fifo.v"
read_verilog "${apath}/small_fifo.v"
read_verilog "${apath}/cookie.v"
read_verilog "${apath}/pkt_filter.v"
read_verilog "${apath}/sub_parser.v"
read_verilog "${apath}/parser_top.v"
read_verilog "${apath}/parser_do_parsing_top.v"
read_verilog "${apath}/parser_do_parsing.v"
read_verilog "${apath}/parser_wait_segs.v"
read_verilog "${apath}/sub_deparser.v"
read_verilog "${apath}/deparser_top.v"
read_verilog "${apath}/depar_do_deparsing.v"
read_verilog "${apath}/depar_wait_segs.v"
read_verilog "${apath}/rmt_wrapper.sv"
read_verilog "${apath}/stage.v"
read_verilog "${apath}/last_stage.v"
read_verilog "${apath}/output_arbiter.v"
read_verilog "${apath}/action/action_engine.v"
read_verilog "${apath}/action/alu_1.v"
read_verilog "${apath}/action/alu_2.v"
read_verilog "${apath}/action/alu_3.v"
read_verilog "${apath}/action/crossbar.v"
read_verilog "${apath}/extract/key_extract.v"
read_verilog "${apath}/extract/key_extract_top.v"
read_verilog "${apath}/lookup/lookup_engine_top.v"
read_verilog "${apath}/lookup/lke_cam_part.v"
read_verilog "${apath}/lookup/lke_ram_part.v"

################## END OF MENSHEN TCL
