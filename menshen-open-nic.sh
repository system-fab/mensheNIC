# CHECK DEPENDENCIES
DEP_NAME=$(ls)
if [[ $DEP_NAME != *"menshen"* ]]; then
	echo "ERROR: no \"menshen\" folder found!"
	exit
fi
DEP_NAME=$(ls)
if [[ $DEP_NAME != *"open-nic-shell"* ]]; then
	echo "ERROR: no \"open-nic-shell\" folder found!"
	exit
fi

# MENSHEN
mv menshen/lib_rmt/rmtv2/ rmtv2
mv menshen/lib_rmt/netfpga_fifo/fallthrough_small_fifo_v1_0_0/hdl/fallthrough_small_fifo.v rmtv2/
mv menshen/lib_rmt/netfpga_fifo/fallthrough_small_fifo_v1_0_0/hdl/small_fifo.v rmtv2/
rm rmtv2/rmt_wrapper.v
rm -rf menshen
mv rmtv2 menshen

implementation="impl"
if [[ "$1" == "$implementation" ]];
then
    patch -s -p0 < patch_files/menshen_impl.patch
else
    patch -s -p0 < patch_files/menshen_sim.patch
    cp pipeline_tbs/tb_rmt_wrapper_calc.sv menshen/tb/
    cp pipeline_tbs/tb_rmt_wrapper_drop.sv menshen/tb/
    cp pipeline_tbs/tb_rmt_wrapper_modules.sv menshen/tb/
    cp pipeline_tbs/tb_rmt_wrapper_stages.sv menshen/tb/
    cp pipeline_tbs/tb_rmt_wrapper_moreStages.sv menshen/tb/
fi

cp patch_files/opennic_integration.tcl menshen/tcl/


# ON SHELL
if [[ "$1" != "$implementation" ]];
then
    patch open-nic-shell/script/build.tcl < patch_files/build.patch
    patch open-nic-shell/src/open_nic_shell.sv < patch_files/open_nic_shell.patch
    patch open-nic-shell/src/open_nic_shell_macros.vh < patch_files/open_nic_shell_macros.patch
    rm open-nic-shell/src/qdma_subsystem/qdma_subsystem_function.sv
    cp arfs/qdma_subsystem_function.sv open-nic-shell/src/qdma_subsystem/qdma_subsystem_function.sv
    TOP_TB="tb_opennic_addSub"
    sed -i "s/set_property top {{TOP_TB}}/set_property top ${TOP_TB}/" open-nic-shell/script/build.tcl
    
    # ABS PATH PATCHES
    VAR=$(realpath open-nic-tbs)
    sed -i "s|{{VAR}}|${VAR}|g" "open-nic-shell/script/build.tcl"
fi

# ABS PATH PATCHES
VAR=$(realpath .)
sed -i "s|{{VAR}}|${VAR}|g" "menshen/tcl/opennic_integration.tcl"

echo "successful project gen"

