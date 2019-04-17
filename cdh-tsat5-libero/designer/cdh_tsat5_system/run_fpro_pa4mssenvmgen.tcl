set_device \
    -fam SmartFusion2 \
    -die PA4M1000_N \
    -pkg tq144
set_input_cfg \
	-path {C:/Work/UMSATS/TSAT5/watchdog_try4/cdh-tsat5/cdh-tsat5-libero/component/work/cdh_tsat5_system_sb_MSS/ENVM.cfg}
set_output_efc \
    -path {C:\Work\UMSATS\TSAT5\watchdog_try4\cdh-tsat5\cdh-tsat5-libero\designer\cdh_tsat5_system\cdh_tsat5_system.efc}
set_proj_dir \
    -path {C:\Work\UMSATS\TSAT5\watchdog_try4\cdh-tsat5\cdh-tsat5-libero}
gen_prg -use_init false
