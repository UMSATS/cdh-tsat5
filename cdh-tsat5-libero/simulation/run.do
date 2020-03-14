quietly set ACTELLIBNAME SmartFusion2
quietly set PROJECT_DIR "C:/Users/Joseph Howarth/Documents/UMSATS/cdh-tsat5/cdh-tsat5-libero"
source "${PROJECT_DIR}/simulation/bfmtovec_compile.tcl";source "${PROJECT_DIR}/simulation/CM3_compile_bfm.tcl";

if {[file exists ../designer/cdh_tsat5_system/simulation/postlayout/_info]} {
   echo "INFO: Simulation library ../designer/cdh_tsat5_system/simulation/postlayout already exists"
} else {
   file delete -force ../designer/cdh_tsat5_system/simulation/postlayout 
   vlib ../designer/cdh_tsat5_system/simulation/postlayout
}
vmap postlayout ../designer/cdh_tsat5_system/simulation/postlayout
vmap SmartFusion2 "C:/Microsemi/Libero_SoC_v11.9/Designer/lib/modelsim/precompiled/vlog/SmartFusion2"
if {[file exists COREAPB3_LIB/_info]} {
   echo "INFO: Simulation library COREAPB3_LIB already exists"
} else {
   file delete -force COREAPB3_LIB 
   vlib COREAPB3_LIB
}
vmap COREAPB3_LIB "COREAPB3_LIB"
vmap CORESPI_LIB "../component/Actel/DirectCore/CORESPI/3.0.156/mti/lib_vlog_rtl/CORESPI_LIB"
vcom -work CORESPI_LIB -force_refresh
vlog -work CORESPI_LIB -force_refresh

vlog -vlog01compat -work postlayout "${PROJECT_DIR}/designer/cdh_tsat5_system/cdh_tsat5_system_ba.v"

vsim -L SmartFusion2 -L postlayout -L COREAPB3_LIB -L CORESPI_LIB  -t 1fs -sdfmax /cdh_tsat5_system=${PROJECT_DIR}/designer/cdh_tsat5_system/cdh_tsat5_system_ba.sdf postlayout.cdh_tsat5_system
# The following lines are commented because no testbench is associated with the project
# add wave /testbench/*
# run 1000ns
