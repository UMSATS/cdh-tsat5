open_project -project {C:\Work\UMSATS\TSAT5\Libero\cdh-tsat5-libero\designer\cdh_tsat5_system\cdh_tsat5_system_fp\cdh_tsat5_system.pro}
set_programming_file -name {M2S010} -file {C:\Work\UMSATS\TSAT5\Libero\cdh-tsat5-libero\designer\cdh_tsat5_system\cdh_tsat5_system.ipd}
enable_device -name {M2S010} -enable 1
set_programming_action -action {PROGRAM} -name {M2S010} 
run_selected_actions
set_programming_file -name {M2S010} -no_file
save_project
close_project
