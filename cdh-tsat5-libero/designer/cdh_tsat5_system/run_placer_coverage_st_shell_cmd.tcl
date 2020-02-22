read_sdc -scenario "place_and_route" -netlist "user" -pin_separator "/" -ignore_errors {C:/UMSATS/45-CLI/cdh-tsat5-master/cdh-tsat5-libero/designer/cdh_tsat5_system/place_route.sdc}
set_options -tdpr_scenario "place_and_route" 
save
set_options -analysis_scenario "place_and_route"
set coverage [report \
    -type     constraints_coverage \
    -format   xml \
    -slacks   no \
    {C:\UMSATS\45-CLI\cdh-tsat5-master\cdh-tsat5-libero\designer\cdh_tsat5_system\cdh_tsat5_system_place_and_route_constraint_coverage.xml}]
set reportfile {C:\UMSATS\45-CLI\cdh-tsat5-master\cdh-tsat5-libero\designer\cdh_tsat5_system\coverage_placeandroute}
set fp [open $reportfile w]
puts $fp $coverage
close $fp
