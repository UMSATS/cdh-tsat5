open_project -project {C:\Users\Joseph Howarth\Documents\UMSATS\cdh-tsat5\cdh-tsat5-libero\designer\cdh_tsat5_system\cdh_tsat5_system_fp\cdh_tsat5_system.pro}\
         -connect_programmers {FALSE}
if { [catch {load_programming_data \
    -name {M2S010} \
    -fpga {C:\Users\Joseph Howarth\Documents\UMSATS\cdh-tsat5\cdh-tsat5-libero\designer\cdh_tsat5_system\cdh_tsat5_system.map} \
    -header {C:\Users\Joseph Howarth\Documents\UMSATS\cdh-tsat5\cdh-tsat5-libero\designer\cdh_tsat5_system\cdh_tsat5_system.hdr} \
    -spm {C:\Users\Joseph Howarth\Documents\UMSATS\cdh-tsat5\cdh-tsat5-libero\designer\cdh_tsat5_system\cdh_tsat5_system.spm} \
    -dca {C:\Users\Joseph Howarth\Documents\UMSATS\cdh-tsat5\cdh-tsat5-libero\designer\cdh_tsat5_system\cdh_tsat5_system.dca} } return_val] } {
save_project
close_project
exit }
set_programming_file -name {M2S010} -no_file
save_project
close_project
