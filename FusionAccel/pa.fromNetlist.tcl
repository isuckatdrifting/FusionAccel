
# PlanAhead Launch Script for Post-Synthesis floorplanning, created by Project Navigator

create_project -name FusionAccel -dir "C:/Users/shish/source/repos/FusionAccel/FusionAccel/planAhead_run_2" -part xc6slx45fgg484-2
set_property design_mode GateLvl [get_property srcset [current_run -impl]]
set_property edif_top_file "C:/Users/shish/source/repos/FusionAccel/FusionAccel/ramtest.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {C:/Users/shish/source/repos/FusionAccel/FusionAccel} {lib} {ipcore_dir} }
add_files [list {ipcore_dir/accum.ncf}] -fileset [get_property constrset [current_run]]
add_files [list {ipcore_dir/comparator.ncf}] -fileset [get_property constrset [current_run]]
add_files [list {ipcore_dir/divider.ncf}] -fileset [get_property constrset [current_run]]
add_files [list {ipcore_dir/multiplier.ncf}] -fileset [get_property constrset [current_run]]
set_property target_constrs_file "C:/Users/shish/source/repos/FusionAccel/FusionAccel/rtl/xem6310.ucf" [current_fileset -constrset]
add_files [list {C:/Users/shish/source/repos/FusionAccel/FusionAccel/rtl/xem6310.ucf}] -fileset [get_property constrset [current_run]]
link_design
