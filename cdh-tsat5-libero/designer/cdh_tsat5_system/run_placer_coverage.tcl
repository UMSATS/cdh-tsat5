set_family {SmartFusion2}
read_adl {C:\UMSATS\45-CLI\cdh-tsat5-master\cdh-tsat5-libero\designer\cdh_tsat5_system\cdh_tsat5_system.adl}
map_netlist
check_constraints {C:\UMSATS\45-CLI\cdh-tsat5-master\cdh-tsat5-libero\designer\cdh_tsat5_system\placer_coverage.log}
write_sdc -strict {C:\UMSATS\45-CLI\cdh-tsat5-master\cdh-tsat5-libero\designer\cdh_tsat5_system\place_route.sdc}
