new_project \
         -name {cdh_tsat5_system} \
         -location {C:\Work\UMSATS\TSAT5\Libero\cdh-tsat5-libero\designer\cdh_tsat5_system\cdh_tsat5_system_fp} \
         -mode {chain} \
         -connect_programmers {FALSE}
add_actel_device \
         -device {M2S010} \
         -name {M2S010}
enable_device \
         -name {M2S010} \
         -enable {TRUE}
save_project
close_project
