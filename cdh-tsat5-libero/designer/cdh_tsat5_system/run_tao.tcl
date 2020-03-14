set_family {SmartFusion2}
read_verilog -mode verilog_2k {C:\Users\Joseph Howarth\Documents\UMSATS\cdh-tsat5\cdh-tsat5-libero\component\Actel\DirectCore\COREI2C\7.0.102\rtl\vlog\core_obfuscated\corei2creal.v}
read_verilog -mode verilog_2k {C:\Users\Joseph Howarth\Documents\UMSATS\cdh-tsat5\cdh-tsat5-libero\component\Actel\DirectCore\COREI2C\7.0.102\rtl\vlog\core_obfuscated\corei2c.v}
read_verilog -mode verilog_2k {C:\Users\Joseph Howarth\Documents\UMSATS\cdh-tsat5\cdh-tsat5-libero\component\Actel\DirectCore\CORESPI\3.0.156\rtl\vlog\core_obfuscated\spi_master.v}
read_verilog -mode verilog_2k {C:\Users\Joseph Howarth\Documents\UMSATS\cdh-tsat5\cdh-tsat5-libero\component\Actel\DirectCore\CORESPI\3.0.156\rtl\vlog\core_obfuscated\spi_slave.v}
read_verilog -mode verilog_2k {C:\Users\Joseph Howarth\Documents\UMSATS\cdh-tsat5\cdh-tsat5-libero\component\Actel\DirectCore\CORESPI\3.0.156\rtl\vlog\core_obfuscated\corespi_sfr.v}
read_verilog -mode verilog_2k {C:\Users\Joseph Howarth\Documents\UMSATS\cdh-tsat5\cdh-tsat5-libero\component\Actel\DirectCore\CORESPI\3.0.156\rtl\vlog\core_obfuscated\corespi.v}
read_verilog -mode verilog_2k {C:\Users\Joseph Howarth\Documents\UMSATS\cdh-tsat5\cdh-tsat5-libero\component\Actel\DirectCore\CoreResetP\7.1.100\rtl\vlog\core\coreresetp_pcie_hotreset.v}
read_verilog -mode verilog_2k {C:\Users\Joseph Howarth\Documents\UMSATS\cdh-tsat5\cdh-tsat5-libero\component\Actel\DirectCore\CoreResetP\7.1.100\rtl\vlog\core\coreresetp.v}
read_verilog -mode verilog_2k {C:\Users\Joseph Howarth\Documents\UMSATS\cdh-tsat5\cdh-tsat5-libero\component\work\cdh_tsat5_system_sb\CCC_0\cdh_tsat5_system_sb_CCC_0_FCCC.v}
read_verilog -mode verilog_2k {C:\Users\Joseph Howarth\Documents\UMSATS\cdh-tsat5\cdh-tsat5-libero\component\work\cdh_tsat5_system_sb\FABOSC_0\cdh_tsat5_system_sb_FABOSC_0_OSC.v}
read_verilog -mode verilog_2k {C:\Users\Joseph Howarth\Documents\UMSATS\cdh-tsat5\cdh-tsat5-libero\component\work\cdh_tsat5_system_sb_MSS\cdh_tsat5_system_sb_MSS.v}
read_verilog -mode verilog_2k -lib COREAPB3_LIB {C:\Users\Joseph Howarth\Documents\UMSATS\cdh-tsat5\cdh-tsat5-libero\component\Actel\DirectCore\CoreAPB3\4.1.100\rtl\vlog\core\coreapb3_muxptob3.v}
read_verilog -mode verilog_2k -lib COREAPB3_LIB {C:\Users\Joseph Howarth\Documents\UMSATS\cdh-tsat5\cdh-tsat5-libero\component\Actel\DirectCore\CoreAPB3\4.1.100\rtl\vlog\core\coreapb3_iaddr_reg.v}
read_verilog -mode verilog_2k -lib COREAPB3_LIB {C:\Users\Joseph Howarth\Documents\UMSATS\cdh-tsat5\cdh-tsat5-libero\component\Actel\DirectCore\CoreAPB3\4.1.100\rtl\vlog\core\coreapb3.v}
read_verilog -mode verilog_2k {C:\Users\Joseph Howarth\Documents\UMSATS\cdh-tsat5\cdh-tsat5-libero\component\work\cdh_tsat5_system_sb\cdh_tsat5_system_sb.v}
read_verilog -mode verilog_2k {C:\Users\Joseph Howarth\Documents\UMSATS\cdh-tsat5\cdh-tsat5-libero\component\work\cdh_tsat5_system\cdh_tsat5_system.v}
set_top_level {cdh_tsat5_system}
map_netlist
check_constraints {C:\Users\Joseph Howarth\Documents\UMSATS\cdh-tsat5\cdh-tsat5-libero\constraint\synthesis_sdc_errors.log}
write_fdc {C:\Users\Joseph Howarth\Documents\UMSATS\cdh-tsat5\cdh-tsat5-libero\designer\cdh_tsat5_system\synthesis.fdc}
