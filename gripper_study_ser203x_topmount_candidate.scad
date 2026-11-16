/*
  Integrated SER top-mount end-effector study candidate for the PolyU MATE ROV.
  Units: millimetres. Geometry is schematic, not dimensioned for fabrication.

  Controls:
    jaw_gap      structural separation of jaw rails at the pivot region
    jaw_angle    positive swings the moving jaw inward toward the anvil
    max_jaw_angle_deg  animation stop selected to avoid pad overlap in this study
    reach        mount datum to nominal jaw contact zone
    pad_size     soft pad envelope; replace with wet-test-selected inserts
    normal_force_per_pad_N  measured wet normal force; 0 disables torque estimate
    contact_position_fraction  contact location along pad, 0 near pivot to 1 at nose
    desired_close_time_s  target time for the selected direct-drive jaw sweep; 0 disables speed estimate
    target_min_grasp_width_mm / target_max_grasp_width_mm  measured object size limits; 0 disables fit screen
    jaw_angle_deg manually selected pose, or animate_jaw for an OpenSCAD sweep
    insert_style  "round_channel", "v_channel", or "flat"
    fixed_pad_style / moving_pad_style  independent anvil and jaw profiles
    part_view     assembly, component view, collision selector or coupon export
    pose checks   set jaw_angle_deg=0, 22, and max_jaw_angle_deg for the SER collision selectors

  This integrated SER candidate is unpowered study CAD. Vehicle/prop interfaces,
  vendor STEP, loads, materials, guard access and D-flat dimensions remain unverified.
*/

$fn = 36;

// Illustration-only defaults; replace after importing the vehicle and prop models.
plate_w = 84; // matches the 84 mm internal study cross-tie after jaw-thickness revision
plate_h = 82;
plate_t = 6;
mount_hole_pitch_x = 42;
mount_hole_pitch_z = 58;
mount_hole_d = 5.5;
frame_mount_z_pitch = 24;
frame_mount_screw_d = 3;
frame_mount_screw_clearance = 0.3;
frame_mount_head_d = 5.6;
frame_mount_head_h = 2.5;
frame_mount_screw_l = 12; // under-head length; thread engagement TBD
frame_mount_insert_od = 4.5;
frame_mount_insert_bore_d = 3;
frame_mount_insert_l = 8;

reach = 68;
jaw_gap = 42;
jaw_projection = 58; // fixed-anvil reach from the support cheeks
pivot_forward_offset = 20; // clear the enlarged reaction clamp and guard from the yoke cheek
jaw_angle_deg = 8; // 0 is aligned/open; larger angles close the nose gap
animate_jaw = false;
max_jaw_angle_deg = 44; // illustrative stop; recompute after changing geometry
jaw_length = jaw_projection - pivot_forward_offset;
jaw_thickness = 12; // fits the catalog M3 insert's reference boss and wall envelope
jaw_height = 16;
pad_size = [9, 24, 14];
pad_channel_radius = 4;
insert_style = "round_channel"; // choose geometry after inspecting real grasp features
fixed_pad_style = insert_style; // [round_channel,v_channel,flat]
moving_pad_style = insert_style; // [round_channel,v_channel,flat]
pad_coupon_pair_gap_mm = 24; // [0:1:100] clear gap between standalone test coupons
retainer_thickness = 1.5;
retainer_screw_d = 3;
retainer_screw_l = 6; // M3 under-head length reference; verify assembled engagement
retainer_head_d = 5.7; // ISO 7380-1 M3 reference
retainer_head_h = 1.65; // ISO 7380-1 M3 reference
pad_thread_insert_od = 4.73; // Tappex Trisert-3 M3 reference
pad_thread_insert_l = 5.25;
pad_thread_insert_head_d = 4.70;
pad_thread_insert_head_t = 0.38;
pad_thread_insert_pilot_d = 4.25; // midpoint of manufacturer's 4.10-4.40 mm plastics range
pad_thread_insert_hole_depth = 5.8;
pad_thread_insert_boss_d = 7.70;
pad_thread_insert_min_wall = 1.65; // manufacturer's reference wall; verify for printed material
pad_thread_insert_thread_bore_d = 2.5; // visual proxy; real M3 internal thread omitted
keeper_screw_reference_pad_length_mm = 24;
keeper_screw_reference_y_offsets_mm = [5.0, 8.5]; // open the close pair around the insert bosses
function keeper_screw_y_offset_mm(zside) =
    pad_size[1]/keeper_screw_reference_pad_length_mm
    * keeper_screw_reference_y_offsets_mm[zside > 0 ? 1 : 0];
keeper_inner_screw_pair_spacing_mm =
    2*pad_size[1]/keeper_screw_reference_pad_length_mm
    * keeper_screw_reference_y_offsets_mm[0];

support_depth = 39;
support_cheek_height = 42; // shared with the structural side-cheek CAD envelope
support_cheek_top_z = support_cheek_height/2;
pivot_y = support_depth + pivot_forward_offset;
support_cross_tie_width = jaw_gap+2*jaw_thickness+18;
grip_start_y = reach;
grip_end_y = support_depth + jaw_projection;
grip_length = grip_end_y - grip_start_y;
grip_center_y = (grip_start_y + grip_end_y)/2;
hook_lip_width_x = 8;
hook_lip_width_y = 9;
hook_lip_center_x = -jaw_thickness/2-0.75;
hook_lip_center_y = jaw_length-4;
function approx_pad_clearance(angle_deg) =
    jaw_gap + jaw_thickness/2 - pad_size[0]
    - (jaw_thickness/2 + pad_size[0])*cos(angle_deg)
    - (grip_center_y-pivot_y + pad_size[1]/2)*sin(angle_deg);
function approx_hook_clearance(angle_deg) =
    jaw_gap/2+jaw_thickness/2
    + (hook_lip_center_x-hook_lip_width_x/2)*cos(angle_deg)
    - (hook_lip_center_y+hook_lip_width_y/2)*sin(angle_deg)
    - (-jaw_gap/2+pad_size[0]);
echo(str("Approx pad-edge clearance at current pose: ",
         approx_pad_clearance(jaw_angle), " mm"));
echo(str("Approx pad opening at zero angle: ",
         jaw_gap - 2*pad_size[0], " mm"));
echo(str("Keeper fastener inner-pair spacing on each outer face: ",
         keeper_inner_screw_pair_spacing_mm, " mm"));
if (keeper_inner_screw_pair_spacing_mm < pad_thread_insert_boss_d+0.5)
    echo("KEEPER FIT WARNING: insert boss envelopes overlap at the close fastener pair; revise the spacing or use a different retention method.");
if (jaw_thickness < pad_thread_insert_boss_d+2*pad_thread_insert_min_wall)
    echo("KEEPER FIT WARNING: rail thickness is below the insert reference boss plus wall envelope; revise the body or select different hardware.");
jaw_contact_arm_near_mm = grip_center_y-pivot_y-pad_size[1]/2;
jaw_contact_arm_center_mm = grip_center_y-pivot_y;
jaw_contact_arm_far_mm = grip_center_y-pivot_y+pad_size[1]/2;
contact_position_fraction = 0.5; // [0:0.05:1] 0=near pivot, 1=pad nose
contact_arm_selected_mm = jaw_contact_arm_near_mm
    +contact_position_fraction*pad_size[1];
normal_force_per_pad_N = 0; // [0:5:100] enter a measured wet-test value; 0 disables estimate
transmission_efficiency = 1; // replace with measured/defensible value; 1 is ideal
design_factor = 1; // set from team risk/load policy; 1 is no margin
desired_close_time_s = 0; // [0:0.5:10] enter target close time after handling trials
target_min_grasp_width_mm = 0; // [0:1:100] enter the smallest measured grasp feature
target_max_grasp_width_mm = 0; // [0:1:150] enter the largest measured grasp feature
echo(str("First-pass pad moment arm near/center/far: ",
         jaw_contact_arm_near_mm," / ",jaw_contact_arm_center_mm," / ",
         jaw_contact_arm_far_mm," mm"));
echo(str("First-pass pivot torque per 1 N at pad center: ",
         jaw_contact_arm_center_mm/1000," N*m before losses"));
echo(str("Selected pad contact arm: ",contact_arm_selected_mm," mm"));
if (normal_force_per_pad_N > 0) {
    ideal_pivot_torque_Nm = normal_force_per_pad_N*contact_arm_selected_mm/1000;
    screening_output_torque_Nm = ideal_pivot_torque_Nm*design_factor
        /max(transmission_efficiency,0.01);
    echo(str("Ideal pivot torque for measured normal force: ",
             ideal_pivot_torque_Nm," N*m"));
    echo(str("Screening output torque incl. entered factor/efficiency: ",
             screening_output_torque_Nm," N*m; NOT actuator selection"));
}
if (desired_close_time_s > 0)
    echo(str("Ideal average direct-drive output speed for ",max_jaw_angle_deg,
             " degree sweep in ",desired_close_time_s," s: ",
             max_jaw_angle_deg/(6*desired_close_time_s),
             " rpm; confirm loaded speed from actuator data"));
pivot_shaft_d = 8;
bearing_h = 4;
bearing_hole_clearance = 0.5;
bearing_bracket_width = 32;
bearing_bracket_depth = 40;
bearing_bracket_rear_overlap = 12;
bearing_mount_screw_d = 3;
bearing_mount_screw_l = bearing_h+frame_mount_insert_l;
bearing_mount_clearance = 3.2;
bearing_mount_head_d = 5.6;
bearing_mount_head_h = 2.5;
bearing_mount_y_back = support_depth-bearing_bracket_rear_overlap+3;
bearing_mount_y_front = bearing_mount_y_back+6;
shaft_thrust_washer_t = 0.5;
shaft_retainer_ring_t = 0.8;
shaft_retainer_ring_od = 11.0; // simplified arc envelope; not the full circlip/lug outline
shaft_retainer_groove_d = 7.6; // Rotor Clip DSH-8 DIN 471 reference; verify selected ring/material
shaft_retainer_groove_w = 0.9; // DSH-8 minimum reference; use selected vendor tolerance
shaft_retainer_endplay = 0.2;
shaft_retainer_washer_id = pivot_shaft_d+0.2;
shaft_retainer_washer_od = 12;
// Candidate extension lets the fork hub reach a second simplified top retainer.
shaft_top_extension = 19;
pivot_shaft_flat_x = 3;
pivot_shaft_key_clearance = 0.2;
// Replacement-stop packaging dimensions; none are load-rated.
stop_radius = 23;
stop_pin_d = 8;
stop_pin_head_d = 12;
stop_pin_h = 14;
stop_pin_below_plate_mm = 0;
stop_arm_thickness_mm = 3;
stop_slot_width = stop_pin_d+0.8;
stop_tangent_clearance = 0.4;
stop_plate_d = 64;
stop_plate_h = 4;
stop_screen_design_torque_Nm = 0; // disabled; current screening equations do not model the replacement stop
shaft_retainer_upper_groove_z = jaw_height/2+bearing_h
    +shaft_thrust_washer_t+shaft_retainer_endplay+shaft_retainer_ring_t/2;
shaft_retainer_lower_groove_z = -jaw_height/2-bearing_h
    -shaft_thrust_washer_t-shaft_retainer_endplay-shaft_retainer_ring_t/2;
stop_sector_id = 24;
stop_sector_od = stop_plate_d;
stop_sector_t = stop_plate_h;
stop_sector_center_z = 20;
stop_sector_bottom_z = stop_sector_center_z-stop_sector_t/2;
stop_sector_top_z = stop_sector_center_z+stop_sector_t/2;
stop_fork_cheek_t = 3;
stop_fork_boss_d = 20;
stop_fork_lower_center_z = 16;
stop_fork_upper_center_z = 27;
stop_fork_pin_length = stop_fork_upper_center_z-stop_fork_lower_center_z
    +stop_fork_cheek_t;
stop_fork_pin_center_z = (stop_fork_upper_center_z+stop_fork_lower_center_z)/2;
stop_block_radial = 17;
stop_block_tangent = 9;
stop_block_height = 2.5;
stop_block_contact_offset_deg = asin(
    (stop_pin_d/2+stop_block_tangent/2)/stop_radius);
stop_block_angles = [-stop_block_contact_offset_deg,
                     max_jaw_angle_deg+stop_block_contact_offset_deg];
// Move the retained bolt/nut station toward the outer part of each block so the
// nut clears the rotating fork cheek; this is a packaging datum to verify.
stop_block_fastener_radius = stop_radius+3;
stop_sector_slot_clearance = 0.8;
stop_sector_slot_inner_r = stop_radius-(stop_pin_d+stop_sector_slot_clearance)/2;
stop_sector_slot_outer_r = stop_radius+(stop_pin_d+stop_sector_slot_clearance)/2;
stop_sector_slot_margin_deg = asin(
    (stop_pin_d/2+stop_sector_slot_clearance/2)/stop_sector_slot_inner_r);
stop_sector_slot_start_deg = -stop_sector_slot_margin_deg;
stop_sector_slot_end_deg = max_jaw_angle_deg+stop_sector_slot_margin_deg;
stop_bridge_r = 36;
stop_bridge_post_d = 8;
stop_bridge_foot_d = 10;
stop_bridge_post_angles = [100,150,210,260];
stop_bridge_mount_hole_d = 4.2;
// Placeholder joint hardware for packaging only; verify real fastener standards,
// thread engagement, material, corrosion, and loads before any fabrication.
joint_screw_d = 3.0;
joint_screw_clearance_d = 3.2;
joint_screw_head_d = 5.5;
joint_screw_head_h = 2.4;
joint_screw_washer_od = 6.0;
joint_screw_washer_t = 0.5;
joint_nut_af = 5.5;
joint_nut_h = 2.4;
joint_thread_insert_od = 4.5;
joint_thread_insert_id = 2.5;
joint_thread_insert_l = 4.0;
joint_stop_head_recess_d = 5.7; // placeholder counterbore diameter
joint_stop_head_recess_h = 1.5; // placeholder low-profile head depth; leaves 1 mm nominal block floor
stop_guard_mount_y = -26; // existing bracket cross-fastener datum; verify on body CAD
stop_guard_base_screw_clearance = stop_bridge_mount_hole_d;
stop_bridge_plate_inner_d = 26;
stop_bridge_plate_outer_d = 72;
stop_bridge_plate_t = 2;
stop_bridge_plate_bottom_z = jaw_height/2+bearing_h;
stop_bridge_plate_top_z = stop_bridge_plate_bottom_z+stop_bridge_plate_t;
stop_bridge_post_bottom_z = stop_bridge_plate_top_z;
stop_bridge_post_h = stop_sector_bottom_z-stop_bridge_post_bottom_z;
stop_upper_washer_t = 0.5;
stop_upper_endplay = 0.2;
stop_upper_ring_z = stop_fork_upper_center_z+stop_fork_cheek_t/2
    +stop_upper_washer_t+stop_upper_endplay+shaft_retainer_ring_t/2;
stop_upper_shaft_top_z = stop_upper_ring_z+shaft_retainer_ring_t/2+1;
stop_main_shaft_top_z = jaw_height/2+bearing_h+12.5;
stop_shaft_extension_delta = stop_upper_shaft_top_z-stop_main_shaft_top_z;
stop_guard_outer_d = 96; // reliefs the fixed-sector tabs with a stronger 5 mm wall
stop_guard_inner_d = 86; // 3 mm nominal radial margin outside the 40 mm bridge-corner envelope
stop_guard_bottom_z = 12.0; // 0.2 mm service clearance above the removable floor panels
stop_guard_top_z = 33;
stop_guard_window_deg = 0; // closed radial wall in this candidate; the old 62-degree moving opening is removed
stop_guard_cap_t = 3.2; // leaves 1.5 mm below a 1.5 mm head recess plus 0.2 mm cutter allowance
stop_guard_cap_outer_d = 100;
stop_guard_lid_shaft_hole_d = 10.0; // 1 mm nominal radial clearance to the 8 mm shaft; lid only
stop_guard_lid_screw_d = 3.0; // placeholder removable M3-class screws
stop_guard_lid_screw_clearance_d = 3.2;
stop_guard_thread_pilot_d = 2.5; // nominal M3 printed/self-tapping pilot; validate in the chosen material
stop_guard_lid_fastener_style = "heat_set_insert"; // [self_tapping, heat_set_insert] placeholder; confirm insert datasheet
stop_guard_lid_head_d = 5.5;
stop_guard_lid_head_t = 1.5; // recessed head proxy in the lid
stop_guard_boss_d = 8.5;
stop_guard_boss_h = 5.5;
stop_guard_insert_pilot_d = 4.6; // placeholder M3 heat-set insert pilot; confirm insert datasheet
stop_guard_insert_length = 4.0;
stop_guard_lid_screw_radius = stop_guard_outer_d/2-2;
stop_guard_bottom_flange_t = 1.5;
stop_guard_bottom_flange_outer_d = stop_guard_cap_outer_d;
stop_guard_bottom_flange_inner_d = stop_guard_inner_d;
stop_guard_floor_t = 1.5;
stop_guard_floor_bottom_z = 10.3; // top at z=11.8; 0.7 mm below lower pin-head bottom
stop_guard_floor_outer_d = stop_guard_bottom_flange_outer_d;
stop_guard_floor_edge_clearance = 0.2;
stop_guard_floor_seam = 0.4;
stop_guard_floor_mount_radius = stop_guard_floor_outer_d/2-6;
stop_guard_floor_mount_angles = [45,135,165,315]; // shifted to clear cross-tie, bridge foot and reaction rail
stop_guard_floor_fastener_style = "self_tapping"; // [self_tapping, captive_nut, heat_set_insert]; comparative prototype choice, not hardware selection
stop_guard_floor_base_boss_h = stop_guard_bottom_z+stop_guard_bottom_flange_t-stop_guard_floor_bottom_z;
stop_guard_floor_boss_h = stop_guard_floor_fastener_style == "heat_set_insert"
    ? max(stop_guard_floor_base_boss_h, stop_guard_insert_length+1.5)
    : stop_guard_floor_base_boss_h;
stop_guard_floor_boss_top_z = stop_guard_floor_bottom_z+stop_guard_floor_boss_h;
stop_guard_floor_boss_d = stop_guard_floor_fastener_style == "self_tapping" ? 6.5 : 8.0;
stop_guard_floor_boss_clearance = 0.4; // radial assembly clearance to split panel
stop_guard_floor_screw_d = 3.0;
stop_guard_floor_screw_clearance_d = 3.2;
stop_guard_floor_head_d = stop_guard_floor_fastener_style == "self_tapping" ? 9.0 : 10.0; // bridges panel relief around the boss
stop_guard_floor_head_t = 1.0;
stop_guard_fastener_socket_af = 2.5; // M3-class hex key proxy; select real hardware later
stop_guard_fastener_socket_depth = 0.7;
stop_open_hard_limit_deg = 0;
stop_close_hard_limit_deg = max_jaw_angle_deg;
// Animated motion stops at the commanded sweep. A manually entered study pose
// may extend through the small overtravel allowance to the modeled hard stop.
jaw_angle = animate_jaw
    ? min(max(max_jaw_angle_deg*$t,0),max_jaw_angle_deg)
    : min(max(jaw_angle_deg,stop_open_hard_limit_deg),
          stop_close_hard_limit_deg);
actuator_body_d = 20;
actuator_body_l = 45;
show_ser203x_package_proxy = true; // integrated dimensional case proxy; not a selected actuator or fit check
ser203x_package_rotation_deg = 0; // rotate 70 x 32 mm housing footprint about its output axis
ser203x_case_below_output_face = 72.1; // 67 mm case plus 5.1 mm top feature; vendor drawing proxy
actuator_coupler_d = 14;
actuator_output_shaft_d = 6; // placeholder; replace from the selected actuator drawing
actuator_motor_shaft_engagement = 3; // placeholder; confirm vendor shaft projection and engagement
actuator_pivot_shaft_engagement = 3; // placeholder; confirm retention stack and engagement
actuator_coupler_web = 2; // placeholder; size from torque/fatigue and retention design
actuator_coupler_l = actuator_motor_shaft_engagement
    +actuator_coupler_web+actuator_pivot_shaft_engagement;
show_dshaft_coupler_interface = true; // [true,false] optional SER-203X/SER-213X-style D-shaft packaging proxy
dshaft_coupler_outer_d = 20; // placeholder hub OD
dshaft_motor_flat_depth = 0.8; // unknown vendor flat; placeholder only
dshaft_motor_diametral_clearance = 0.25; // placeholder fit allowance
dshaft_pivot_flat_depth = 1.0; // matches study's nominal x=3 mm flat; still a placeholder fit
dshaft_pivot_diametral_clearance = 0.25; // placeholder fit allowance
dshaft_retention_pilot_d = 2.5; // unthreaded radial pilot placeholder, not a screw specification
dshaft_retention_pilot_depth = 8.5; // placeholder radial access/depth
actuator_coupler_to_bearing_gap = shaft_thrust_washer_t
    +shaft_retainer_endplay+shaft_retainer_ring_t+0.5;
actuator_axial_gap = bearing_h+actuator_coupler_to_bearing_gap
    +actuator_coupler_l;
shaft_drive_extension = actuator_pivot_shaft_engagement
    +actuator_coupler_to_bearing_gap;
actuator_coupler_motor_bore_d = actuator_output_shaft_d+0.2;
actuator_coupler_pivot_bore_d = pivot_shaft_d+0.2;
actuator_coupler_set_screw_d = 2.5; // schematic M3 tapped-hole pilot; verify vendor coupling
actuator_guard_shaft_hole_d = 11.8; // lower retainer clears; nominally below the 12.5 mm IP-20 limit
// Keep the actuator-guard end wall below the lower retention ring. The 0.2 mm
// margin is an axial study clearance; confirm with the selected ring/washer stack.
actuator_guard_bearing_clearance = shaft_thrust_washer_t
    +shaft_retainer_endplay+shaft_retainer_ring_t+0.2;
actuator_guard_top_z = -jaw_height/2-bearing_h-actuator_guard_bearing_clearance;
actuator_guard_lower_ring_gap = shaft_retainer_lower_groove_z
    -shaft_retainer_ring_t/2-actuator_guard_top_z;
actuator_shroud_wall = 9; // radial packaging margin for the reaction clamp and rails
actuator_shroud_end_wall = 1;
actuator_guard_fastener_d = 3;
actuator_guard_fastener_clearance = 3.2;
actuator_guard_fastener_head_d = 5.5;
actuator_guard_fastener_head_h = 2.4;
actuator_guard_fastener_radius_x = actuator_body_d/2+actuator_shroud_wall+2.75;
actuator_guard_insert_od = 4.5;
actuator_guard_insert_l = 4;
actuator_guard_split_flange_h = 8;
actuator_guard_split_flange_w = 8.5;
actuator_guard_screw_z_inset = 10;
actuator_guard_inner_d = 34;
actuator_guard_outer_d = actuator_body_d+2*actuator_shroud_wall;
actuator_guard_bottom_extension = 4;
actuator_reaction_ring_inner_d = 20.5;
actuator_reaction_ring_outer_d = 28.5;
actuator_reaction_ring_h = 6;
actuator_reaction_rail_x_offset = 13;
actuator_reaction_rail_radial_t = 2.2;
actuator_reaction_rail_width = 4;
actuator_reaction_foot_size = 8;
actuator_reaction_foot_h = 3;
actuator_reaction_insert_od = 4.5;
actuator_reaction_insert_bore_d = 3;
actuator_reaction_insert_l = 3.6;
actuator_reaction_screw_d = 3;
actuator_reaction_screw_l = 6;
actuator_reaction_screw_head_d = 5.5;
actuator_reaction_screw_head_h = 2.4;
actuator_reaction_ring_bolt_pitch_y = 21;
actuator_reaction_ring_bolt_d = 3;
actuator_reaction_ring_bolt_clearance = 3.2;
actuator_reaction_ring_bolt_head_d = 5.5;
actuator_reaction_ring_bolt_head_h = 2.4;
actuator_reaction_ring_nut_af = 5.5;
actuator_reaction_ring_nut_h = 2.4;
actuator_reaction_ring_flange_w = 6.4;
actuator_reaction_ring_flange_t = 4;
show_guard = true;
show_mount_plate = true;
show_reference_bay = false; // optional 250x150x150 mm ghost envelope; enable for context only
part_view = "assembly"; // [assembly, adapter_plate, support_yoke, bearing_set, jaw_assembly, fixed_contact, fixed_pad_only, fixed_keeper_strips_only, fixed_keeper_fasteners_only, fixed_pad_thread_inserts_only, pad_coupon, pad_coupon_pair, pad_retention_coupon, pad_retention_coupon_body_only, pad_retention_coupon_pad_only, pad_retention_coupon_keepers_only, moving_jaw_body_only, moving_pad_only, moving_keeper_strips_only, moving_keeper_fasteners_only, moving_pad_thread_inserts_only, jaw_frame_overlap, pad_overlap, pivot_shaft, axial_retention, actuator_reaction_mount, stop_sector, rotating_stop, stop_guard, stop_guard_enclosure_only, stop_guard_shell_print, stop_guard_floor_left_print, stop_guard_floor_right_print, stop_guard_lid_print, stop_guard_hardware_proxy, stop_guard_enclosure_clearance, stop_guard_clearance_samples, stop_guard_floor_structure_clearance, stop_guard_shell_floor_clearance, stop_guard_access_diagnostic, integrated_bridge, bridge_joint_fasteners, post_sector_fasteners, stop_block_fasteners, actuator_dshaft_coupler, rotating_stop_bridge_fasteners_overlap, rotating_stop_post_fasteners_overlap, rotating_stop_block_fasteners_overlap, stop_sector_fork_overlap, stop_bridge_fork_overlap, stop_bridge_plate_fork_overlap, stop_guard_overlap, actuator_package]
reference_bay_assumed_cm = [25,15,15]; // [length, width, height] interpreted as cm
reference_bay_panel_t = 3; // illustrative acrylic thickness in the overlay only
echo(str("Nominal mechanical stop range: ",stop_open_hard_limit_deg,
         " to ",stop_close_hard_limit_deg," degrees"));
echo(str("Estimated pad clearance at hard close stop: ",
         approx_pad_clearance(stop_close_hard_limit_deg)," mm"));
echo(str("Approx hook-to-fixed-pad clearance at hard close stop: ",
         approx_hook_clearance(stop_close_hard_limit_deg)," mm"));
jaw_opening_mm = jaw_gap-2*pad_size[0];
jaw_close_gap_mm = approx_pad_clearance(stop_close_hard_limit_deg);
jaw_available_closure_mm = jaw_opening_mm-jaw_close_gap_mm;
echo(str("Estimated pad opening at full open / hard close / closure travel: ",
         jaw_opening_mm," / ",jaw_close_gap_mm," / ",
         jaw_available_closure_mm," mm"));
if (target_max_grasp_width_mm > 0 && target_max_grasp_width_mm > jaw_opening_mm)
    echo(str("FIT SCREEN WARNING: max target width ",target_max_grasp_width_mm,
             " mm exceeds estimated open gap ",jaw_opening_mm," mm"));
if (target_min_grasp_width_mm > 0 && target_min_grasp_width_mm < jaw_close_gap_mm)
    echo(str("FIT SCREEN WARNING: min target width ",target_min_grasp_width_mm,
             " mm is below estimated hard-close gap ",jaw_close_gap_mm," mm"));
if (target_min_grasp_width_mm > 0 && target_max_grasp_width_mm > 0
        && target_min_grasp_width_mm > target_max_grasp_width_mm)
    echo("FIT SCREEN WARNING: minimum target width exceeds maximum target width");
study_envelope_x_min = -support_cross_tie_width/2;
study_envelope_x_max = max(jaw_gap/2+jaw_thickness/2+stop_guard_outer_d/2,
    jaw_gap/2+jaw_thickness/2+actuator_guard_fastener_radius_x
    +actuator_guard_split_flange_w/2);
study_envelope_y_min = -plate_t;
study_envelope_y_max = max(grip_end_y,
    pivot_y+hook_lip_center_y+hook_lip_width_y/2);
study_actuator_drop_below_face = show_ser203x_package_proxy
    ? ser203x_case_below_output_face : actuator_body_l;
study_envelope_z_min = -jaw_height/2-actuator_axial_gap
    -study_actuator_drop_below_face-actuator_guard_bottom_extension;
study_envelope_z_max = plate_h/2;
echo(str("Swept study envelope with adapter plate [X,Y,Z]: ",
         study_envelope_x_max-study_envelope_x_min," x ",
         study_envelope_y_max-study_envelope_y_min," x ",
         study_envelope_z_max-study_envelope_z_min,
         " mm; forward reach from mount plane: ",study_envelope_y_max," mm"));
actuator_motor_inner_face_z = -jaw_height/2-actuator_axial_gap;
actuator_reaction_ring_center_z = actuator_motor_inner_face_z-10;
actuator_reaction_ring_top_z = actuator_reaction_ring_center_z
    +actuator_reaction_ring_h/2;
actuator_reaction_rail_top_z = -jaw_height/2-bearing_h;
actuator_reaction_rail_bottom_z = actuator_reaction_ring_top_z-0.5;
actuator_reaction_rail_h = actuator_reaction_rail_top_z
    -actuator_reaction_rail_bottom_z;
actuator_coupler_lower_z = actuator_motor_inner_face_z;
actuator_coupler_upper_z = actuator_coupler_lower_z+actuator_coupler_l;
actuator_pivot_shaft_bottom_z = -jaw_height/2-bearing_h-shaft_drive_extension;
actuator_pivot_coupler_overlap = max(0,
    actuator_coupler_upper_z-actuator_pivot_shaft_bottom_z);
actuator_motor_shaft_tip_z = actuator_motor_inner_face_z
    +actuator_motor_shaft_engagement;
actuator_motor_coupler_overlap = max(0,
    actuator_motor_shaft_tip_z-actuator_coupler_lower_z);
actuator_coupler_to_lower_bearing_gap = -jaw_height/2-bearing_h
    -actuator_coupler_upper_z;
echo(str("Nominal pivot shaft overlap in coupling proxy: ",
         actuator_pivot_coupler_overlap," mm (proxy blind-bore engagement)"));
echo(str("Nominal actuator shaft overlap in coupling proxy: ",
         actuator_motor_coupler_overlap," mm (verify from actuator drawing)"));
echo(str("Coupler web / clearance to lower bearing ear: ",
         actuator_coupler_web," / ",actuator_coupler_to_lower_bearing_gap," mm"));
echo(str("Upper stop retainer ring center = ",stop_upper_ring_z,
         " mm; lower retainer stack remains inherited from main study"));
echo("New SER coupler shield is separate from the retained stop-sector guard; verify both assembled interfaces.");
integrated_stop_overlap_diagnostics();

module round_box(size, r=2) {
    minkowski() {
        cube([size[0]-2*r, size[1]-2*r, size[2]-2*r], center=true);
        sphere(r=r);
    }
}

module d_profile_bore(d, flat_x, h) {
    difference() {
        cylinder(d=d,h=h,center=true);
        translate([flat_x+5,0,0]) cube([10,10,h+0.2],center=true);
    }
}

function stop_slot_points(r_outer,r_inner,a_start,a_end) = concat(
    [for (a=[a_start:1:a_end]) [-r_outer*sin(a),r_outer*cos(a)]],
    [for (a=[a_end:-1:a_start]) [-r_inner*sin(a),r_inner*cos(a)]]
);

module mount_plate() {
    difference() {
        translate([0, -plate_t/2, 0]) cube([plate_w, plate_t, plate_h], center=true);
        for (x=[-mount_hole_pitch_x/2, mount_hole_pitch_x/2])
            for (z=[-mount_hole_pitch_z/2, mount_hole_pitch_z/2])
                translate([x, -plate_t, z]) rotate([-90,0,0])
                    cylinder(d=mount_hole_d, h=plate_t*2);
        // Counterbored M3 pattern fastens both support cheeks to this plate.
        for (side=[-1,1])
            for (z=[-frame_mount_z_pitch/2,frame_mount_z_pitch/2]) {
                x = side*(jaw_gap/2+jaw_thickness/2);
                translate([x,-plate_t,z]) rotate([-90,0,0])
                    cylinder(d=frame_mount_screw_d+frame_mount_screw_clearance,
                             h=plate_t*2);
                translate([x,-plate_t+frame_mount_head_h/2,z]) rotate([-90,0,0])
                    cylinder(d=frame_mount_head_d+0.3,
                             h=frame_mount_head_h+0.1,center=true);
            }
    }
}

module pad_thread_insert_recess(zside=1) {
    // Tappex M3 reference hole: pilot depth plus a shallow reduced-head seat.
    translate([0,0,zside*(jaw_height/2-pad_thread_insert_hole_depth/2)])
        cylinder(d=pad_thread_insert_pilot_d,
                 h=pad_thread_insert_hole_depth+0.02,center=true);
    translate([0,0,zside*(jaw_height/2-pad_thread_insert_head_t/2)])
        cylinder(d=pad_thread_insert_head_d+0.10,
                 h=pad_thread_insert_head_t+0.02,center=true);
}

module pad_thread_insert_hardware(screw_x,center_y) {
    for (zside=[-1,1]) {
        y_offset = keeper_screw_y_offset_mm(zside);
        for (yside=[-1,1]) {
            y_pos = center_y+yside*y_offset;
            body_center_z = zside*(jaw_height/2-pad_thread_insert_head_t
                -pad_thread_insert_l/2);
            head_center_z = zside*(jaw_height/2-pad_thread_insert_head_t/2);
            color([0.72,0.75,0.77])
                translate([screw_x,y_pos,body_center_z])
                    difference() {
                        cylinder(d=pad_thread_insert_od,
                                 h=pad_thread_insert_l,center=true);
                        cylinder(d=pad_thread_insert_thread_bore_d,
                                 h=pad_thread_insert_l+0.2,center=true);
                    }
            color([0.72,0.75,0.77])
                translate([screw_x,y_pos,head_center_z])
                    difference() {
                        cylinder(d=pad_thread_insert_head_d,
                                 h=pad_thread_insert_head_t,center=true);
                        cylinder(d=pad_thread_insert_thread_bore_d,
                                 h=pad_thread_insert_head_t+0.2,center=true);
                    }
        }
    }
}

module support_frame() {
    pivot_x=jaw_gap/2+jaw_thickness/2;
    bracket_center_y=support_depth-bearing_bracket_rear_overlap
                     +bearing_bracket_depth/2;
    difference() {
        union() {
            // Two side cheeks transfer clamp loads back to the bolt-on plate.
            for (side=[-1,1])
                translate([side*(jaw_gap/2 + jaw_thickness/2), support_depth/2, 0])
                    cube([jaw_thickness, support_depth, support_cheek_height], center=true);
            // Extend the left reaction rail to the fixed anvil so it is load-connected.
            translate([-jaw_gap/2-jaw_thickness/2,
                       (support_depth + grip_end_y)/2, 0])
                cube([jaw_thickness, grip_end_y - support_depth, support_cheek_height], center=true);
            // Fixed jaw is the left-side reaction member.
            translate([-jaw_gap/2-jaw_thickness/2, grip_center_y, 0])
                round_box([jaw_thickness, grip_length, jaw_height], 2);
            // Stiff cross tie behind the pivot: keep clear of the open bay/lid.
            translate([0, support_depth/2, 10])
                cube([support_cross_tie_width, 10, 10], center=true);
        }
        // Blind vertical pilot holes for keeper-strip fasteners at the fixed insert.
        for (zside=[-1,1]) {
            y_offset = keeper_screw_y_offset_mm(zside);
            for (yside=[-1,1])
                translate([-jaw_gap/2-jaw_thickness/2,
                           grip_center_y+yside*y_offset,0])
                    pad_thread_insert_recess(zside);
        }
        // Insert bores start at the plate face and run into each structural cheek.
        for (side=[-1,1])
            for (z=[-frame_mount_z_pitch/2,frame_mount_z_pitch/2])
                translate([side*(jaw_gap/2+jaw_thickness/2),
                           frame_mount_insert_l/2,z])
                    rotate([-90,0,0])
                        cylinder(d=frame_mount_insert_od+0.2,
                                 h=frame_mount_insert_l+0.2,center=true);
        // Two blind insert pockets on each bearing-ear face transfer pivot
        // loads into the right yoke cheek; depth matches replaceable inserts.
        for (side=[-1,1])
            for (y=[bearing_mount_y_back,bearing_mount_y_front])
                translate([jaw_gap/2+jaw_thickness/2,y,
                           side*(jaw_height/2-frame_mount_insert_l/2)])
                    cylinder(d=frame_mount_insert_od+0.2,
                             h=frame_mount_insert_l+0.2,center=true);
        // Seat the upper bearing ear and wider SER lower bridge into the right
        // cheek instead of leaving intersecting solids in the assembly. These
        // are packaging reliefs only; remaining wall section needs load review.
        translate([pivot_x,bracket_center_y,
                   jaw_height/2+bearing_h/2])
            cube([bearing_bracket_width+0.4,bearing_bracket_depth+0.4,
                  bearing_h+0.4],center=true);
        translate([pivot_x,pivot_y+ser_mount_bridge_center_y,
                   actuator_motor_inner_face_z+ser_mount_bridge_bottom_z
                   +ser_mount_bridge_t/2])
            cube([ser_mount_bridge_x+0.4,ser_mount_bridge_y+0.4,
                  ser_mount_bridge_t+0.4],center=true);
    }
}

module frame_mount_inserts() {
    for (side=[-1,1])
        for (z=[-frame_mount_z_pitch/2,frame_mount_z_pitch/2]) {
            x = side*(jaw_gap/2+jaw_thickness/2);
            color([0.78,0.57,0.30])
                translate([x,frame_mount_insert_l/2,z])
                    rotate([-90,0,0])
                        difference() {
                            cylinder(d=frame_mount_insert_od,
                                     h=frame_mount_insert_l,center=true);
                            cylinder(d=frame_mount_insert_bore_d,
                                     h=frame_mount_insert_l+0.2,center=true);
                        }
        }
}

module frame_mount_fasteners() {
    shank_center_y = -plate_t+frame_mount_head_h+frame_mount_screw_l/2;
    head_center_y = -plate_t+frame_mount_head_h/2;
    for (side=[-1,1])
        for (z=[-frame_mount_z_pitch/2,frame_mount_z_pitch/2]) {
            x = side*(jaw_gap/2+jaw_thickness/2);
            color([0.68,0.71,0.74])
                translate([x,shank_center_y,z]) rotate([-90,0,0])
                    cylinder(d=frame_mount_screw_d,h=frame_mount_screw_l,center=true);
            color([0.75,0.78,0.80])
                translate([x,head_center_y,z]) rotate([-90,0,0])
                    cylinder(d=frame_mount_head_d,h=frame_mount_head_h,center=true);
        }
}

module fixed_pad_only() {
    translate([-jaw_gap/2 + pad_size[0]/2,
               grip_center_y, 0]) pad_insert(1,fixed_pad_style);
}

module fixed_keeper_strips_only() {
    keeper_strips(-jaw_gap/2,grip_center_y,-jaw_gap/2-jaw_thickness/2,
                  -jaw_gap/2+pad_size[0]/2,1);
}

module fixed_keeper_fasteners_only() {
    keeper_fasteners(-jaw_gap/2-jaw_thickness/2,grip_center_y);
}

module fixed_pad_thread_inserts_only() {
    pad_thread_insert_hardware(-jaw_gap/2-jaw_thickness/2,grip_center_y);
}

module contact_pads() {
    // Complete fixed contact subassembly; separate views are available for
    // the pad and keeper parts when preparing unpowered geometry mockups.
    fixed_pad_only();
    fixed_keeper_strips_only();
    fixed_keeper_fasteners_only();
    fixed_pad_thread_inserts_only();
}

module keeper_strips(center_x,center_y,screw_x,pad_center_x,open_side) {
    difference() {
        union() {
            for (zside=[-1,1])
                translate([center_x,center_y,
                           zside*(pad_size[2]/2+retainer_thickness/2)])
                    round_box([jaw_thickness+pad_size[0],pad_size[1]+2,
                               retainer_thickness],0.5);
            // Short end fences join the keeper strips and capture the pad's
            // exposed face edges while leaving the central contact zone open.
            for (yside=[-1,1])
                translate([pad_center_x+open_side*(pad_size[0]/2+retainer_thickness/2),
                           center_y+yside*(pad_size[1]/2+retainer_thickness/2),0])
                    round_box([retainer_thickness,retainer_thickness,
                               pad_size[2]+2*retainer_thickness],0.3);
        }
        for (zside=[-1,1]) {
            y_offset = keeper_screw_y_offset_mm(zside);
            for (yside=[-1,1])
                translate([screw_x,center_y+yside*y_offset,
                           zside*(pad_size[2]/2+retainer_thickness/2)])
                    cylinder(d=retainer_screw_d+0.4,
                             h=retainer_thickness+1,center=true);
        }
    }
}

module keeper_fasteners(screw_x,center_y) {
    for (zside=[-1,1]) {
        y_offset = keeper_screw_y_offset_mm(zside);
        for (yside=[-1,1]) {
            y_pos = center_y+yside*y_offset;
            // M3 x 6 low-head fastener proxy; insert is modeled separately.
            color([0.68,0.71,0.74])
                translate([screw_x,y_pos,zside*(pad_size[2]/2
                    +retainer_thickness-retainer_screw_l/2)])
                    cylinder(d=retainer_screw_d,h=retainer_screw_l,center=true);
            color([0.75,0.78,0.80])
                translate([screw_x,y_pos,
                           zside*(pad_size[2]/2+retainer_thickness+retainer_head_h/2)])
                    cylinder(d=retainer_head_d,h=retainer_head_h,center=true);
        }
    }
}

module pad_coupon_pair() {
    // Standalone fit coupons: channels face inward across the entered gap.
    coupon_center_x = pad_size[0]/2+pad_coupon_pair_gap_mm/2;
    translate([-coupon_center_x,0,0]) pad_insert(1,fixed_pad_style);
    translate([ coupon_center_x,0,0]) pad_insert(-1,moving_pad_style);
}

module pad_insert(open_side=1,style=insert_style) {
    color([0.93,0.67,0.25])
        difference() {
            round_box(pad_size, 1.5);
            if (style == "round_channel")
                translate([open_side*(pad_size[0]/2-2), 0, 0])
                    rotate([90,0,0])
                        cylinder(r=pad_channel_radius,
                                 h=pad_size[1]+2, center=true);
            else if (style == "v_channel")
                rotate([90,0,0])
                    linear_extrude(height=pad_size[1]+2, center=true)
                        polygon(points=[
                            [open_side*(pad_size[0]/2+0.1),-pad_size[2]/2-1],
                            [open_side*(pad_size[0]/2+0.1), pad_size[2]/2+1],
                            [open_side*(pad_size[0]/2-5),0]
                        ]);
        }
}

module moving_jaw_body_only() {
    pivot_x = jaw_gap/2 + jaw_thickness/2;
    pad_local_y = grip_center_y-pivot_y;
    translate([pivot_x,pivot_y,0]) rotate([0,0,jaw_angle]) {
        color([0.62,0.73,0.82])
            difference() {
                union() {
                    cylinder(d=16,h=jaw_height,center=true);
                    translate([0,jaw_length/2,0])
                        round_box([jaw_thickness,jaw_length,jaw_height],2);
                    // Blunt hook lip at the nose. No blade or pointed tooth.
                    translate([hook_lip_center_x,hook_lip_center_y,0])
                        round_box([hook_lip_width_x,hook_lip_width_y,
                                   jaw_height-4],2);
                }
                d_profile_bore(pivot_shaft_d+0.4,
                               pivot_shaft_flat_x+pivot_shaft_key_clearance,
                               jaw_height+1);
                for (zside=[-1,1]) {
                    y_offset = keeper_screw_y_offset_mm(zside);
                    for (yside=[-1,1])
                        translate([0,pad_local_y+yside*y_offset,0])
                            pad_thread_insert_recess(zside);
            }
            }
    }
}

module moving_pad_only() {
    pivot_x = jaw_gap/2 + jaw_thickness/2;
    pad_local_y = grip_center_y-pivot_y;
    translate([pivot_x,pivot_y,0]) rotate([0,0,jaw_angle])
        translate([-jaw_thickness/2-pad_size[0]/2,pad_local_y,0])
            pad_insert(-1,moving_pad_style);
}

module moving_keeper_strips_only() {
    pivot_x = jaw_gap/2 + jaw_thickness/2;
    pad_local_y = grip_center_y-pivot_y;
    translate([pivot_x,pivot_y,0]) rotate([0,0,jaw_angle])
        keeper_strips(-jaw_thickness/2,pad_local_y,
                      0,
                      -jaw_thickness/2-pad_size[0]/2,-1);
}

module moving_keeper_fasteners_only() {
    pivot_x = jaw_gap/2 + jaw_thickness/2;
    pad_local_y = grip_center_y-pivot_y;
    translate([pivot_x,pivot_y,0]) rotate([0,0,jaw_angle])
        keeper_fasteners(0,pad_local_y);
}

module moving_pad_thread_inserts_only() {
    pivot_x = jaw_gap/2 + jaw_thickness/2;
    pad_local_y = grip_center_y-pivot_y;
    translate([pivot_x,pivot_y,0]) rotate([0,0,jaw_angle])
        pad_thread_insert_hardware(0,pad_local_y);
}

module moving_jaw() {
    // Complete moving-jaw subassembly. The body, pad, keepers, and fasteners
    // are also exposed separately for mockup and print-orientation studies.
    moving_jaw_body_only();
    moving_pad_only();
    moving_keeper_strips_only();
    moving_keeper_fasteners_only();
    moving_pad_thread_inserts_only();
}

module pad_retention_coupon_body() {
    difference() {
        round_box([jaw_thickness,pad_size[1]+2,jaw_height],1.5);
        for (zside=[-1,1]) {
            y_offset = keeper_screw_y_offset_mm(zside);
            for (yside=[-1,1])
                translate([0,yside*y_offset,0])
                    pad_thread_insert_recess(zside);
        }
    }
}

module pad_retention_coupon() {
    // Assembly visualization. Hardware solids are proxies; do not print this
    // combined view as a real insert-fit coupon.
    pad_retention_coupon_body();
    translate([-jaw_thickness/2-pad_size[0]/2,0,0])
        pad_insert(-1,moving_pad_style);
    keeper_strips(-jaw_thickness/2,0,0,
                  -jaw_thickness/2-pad_size[0]/2,-1);
    keeper_fasteners(0,0);
    pad_thread_insert_hardware(0,0);
}

module pad_retention_coupon_body_only() {
    // Printable rail coupon with open pilot bores for real threaded inserts.
    pad_retention_coupon_body();
}

module pad_retention_coupon_pad_only() {
    // Printable contact insert, centered at the origin.
    pad_insert(-1,moving_pad_style);
}

module pad_retention_coupon_keepers_only() {
    // Printable keeper strips in the same relative position as the coupon.
    keeper_strips(-jaw_thickness/2,0,0,
                  -jaw_thickness/2-pad_size[0]/2,-1);
}

module pivot_bearing_brackets() {
    // Two extended bearing ears carry the pivot beyond the cheek edge.
    // The rear overlap is backed by two M3 fasteners per ear into yoke inserts.
    pivot_x = jaw_gap/2 + jaw_thickness/2;
    bracket_center_y = support_depth-bearing_bracket_rear_overlap
                       + bearing_bracket_depth/2;
    for (side=[1]) {
        bearing_z = side*(jaw_height/2 + bearing_h/2);
        color([0.48,0.61,0.71])
            difference() {
                translate([pivot_x, bracket_center_y, bearing_z])
                    cube([bearing_bracket_width,bearing_bracket_depth,bearing_h], center=true);
                translate([pivot_x, pivot_y, bearing_z])
                    cylinder(d=pivot_shaft_d+bearing_hole_clearance,
                             h=bearing_h+1, center=true);
                for (y=[bearing_mount_y_back,bearing_mount_y_front]) {
                    translate([pivot_x,y,bearing_z])
                        cylinder(d=bearing_mount_clearance,
                                 h=bearing_h+0.2,center=true);
                    translate([pivot_x,y,
                               side*(jaw_height/2+bearing_h
                               -bearing_mount_head_h/2)])
                        cylinder(d=bearing_mount_head_d,
                                 h=bearing_mount_head_h+0.1,center=true);
                }
                if (side > 0)
                    for (x=[-6,6])
                        translate([pivot_x+x,pivot_y+stop_guard_mount_y,
                                   bearing_z])
                            cylinder(d=stop_guard_base_screw_clearance,
                                     h=bearing_h+0.2,center=true);
                if (side < 0)
                    for (mount_side=[-1,1])
                        translate([pivot_x+mount_side*actuator_reaction_rail_x_offset,
                                   pivot_y,
                                   -jaw_height/2-bearing_h
                                   +actuator_reaction_insert_l/2])
                            cylinder(d=actuator_reaction_insert_od+0.2,
                                     h=actuator_reaction_insert_l+0.2,
                                     center=true);
            }
    }
    // Replaceable sleeves are shown in dark blue; select material/fit after loads
    // and fabrication process are known.
    for (side=[1]) {
        bearing_z = side*(jaw_height/2 + bearing_h/2);
        color([0.22,0.40,0.53])
            difference() {
                translate([pivot_x,pivot_y,bearing_z])
                    cylinder(d=12,h=bearing_h-0.2,center=true);
                translate([pivot_x,pivot_y,bearing_z])
                    cylinder(d=pivot_shaft_d+0.2,h=bearing_h+0.2,center=true);
            }
    }
}

module bearing_ear_inserts() {
    pivot_x = jaw_gap/2+jaw_thickness/2;
    for (side=[-1,1])
        for (y=[bearing_mount_y_back,bearing_mount_y_front])
            color([0.78,0.57,0.30])
                translate([pivot_x,y,
                           side*(jaw_height/2-frame_mount_insert_l/2)])
                    difference() {
                        // These inserts enter the cheek from the top/bottom face.
                        cylinder(d=frame_mount_insert_od,
                                 h=frame_mount_insert_l,center=true);
                        cylinder(d=frame_mount_insert_bore_d,
                                 h=frame_mount_insert_l+0.2,center=true);
                    }
}

module bearing_ear_fasteners() {
    pivot_x = jaw_gap/2+jaw_thickness/2;
    for (side=[-1,1])
        for (y=[bearing_mount_y_back,bearing_mount_y_front]) {
            color([0.68,0.71,0.74]) {
                translate([pivot_x,y,
                           side*(jaw_height/2+bearing_h
                           -bearing_mount_screw_l/2)])
                    cylinder(d=bearing_mount_screw_d,
                             h=bearing_mount_screw_l,center=true);
                translate([pivot_x,y,
                           side*(jaw_height/2+bearing_h
                           -bearing_mount_head_h/2)])
                    cylinder(d=bearing_mount_head_d,
                             h=bearing_mount_head_h,center=true);
            }
        }
}

module pivot_through_shaft() {
    pivot_x = jaw_gap/2 + jaw_thickness/2;
    // Round bearing lands remain circular; the keyed sections co-rotate with the jaw.
    shaft_bottom_z = -jaw_height/2-bearing_h-shaft_drive_extension;
    shaft_top_z = jaw_height/2+bearing_h+shaft_top_extension;
    shaft_l = shaft_top_z-shaft_bottom_z;
    shaft_center_z = (shaft_top_z+shaft_bottom_z)/2;
    translate([pivot_x,pivot_y,0]) rotate([0,0,jaw_angle])
    color([0.75,0.78,0.80])
        difference() {
            translate([0,0,shaft_center_z])
                cylinder(d=pivot_shaft_d,h=shaft_l,center=true);
            // Matched circlip-style groove placeholders sit outboard of both bearings.
            for (groove_z=[shaft_retainer_upper_groove_z,
                           shaft_retainer_lower_groove_z,stop_upper_ring_z])
                translate([0,0,groove_z])
                    cylinder(d=shaft_retainer_groove_d,
                             h=shaft_retainer_groove_w,center=true);
            translate([pivot_shaft_flat_x+5,0,0])
                cube([10,10,jaw_height],center=true);
            translate([pivot_shaft_flat_x+5,0,
                       jaw_height/2+bearing_h+shaft_top_extension/2])
                cube([10,10,shaft_top_extension],center=true);
            // Short drive flat engages the pivot-side coupling set screw;
            // both round bearing lands stay intact.
            translate([pivot_shaft_flat_x+5,0,
                       -jaw_height/2-bearing_h-shaft_drive_extension/2])
                cube([10,10,shaft_drive_extension],center=true);
        }
}

module pivot_axial_retention() {
    pivot_x = jaw_gap/2 + jaw_thickness/2;
    for (side=[-1,1]) {
        bearing_face_z = side*(jaw_height/2+bearing_h);
        washer_z = bearing_face_z+side*shaft_thrust_washer_t/2;
        ring_z = side*(jaw_height/2+bearing_h+shaft_thrust_washer_t
                       +shaft_retainer_endplay+shaft_retainer_ring_t/2);
        color([0.68,0.74,0.78])
            translate([pivot_x,pivot_y,washer_z])
                difference() {
                    cylinder(d=shaft_retainer_washer_od,
                             h=shaft_thrust_washer_t,center=true);
                    cylinder(d=shaft_retainer_washer_id,
                             h=shaft_thrust_washer_t+0.2,center=true);
                }
        // Split ring proxy; select a real ring to match the shaft groove and axial load.
        color([0.83,0.68,0.35])
            translate([pivot_x,pivot_y,ring_z])
                difference() {
                    cylinder(d=shaft_retainer_ring_od,
                             h=shaft_retainer_ring_t,center=true);
                    cylinder(d=shaft_retainer_groove_d,
                             h=shaft_retainer_ring_t+0.2,center=true);
                    translate([shaft_retainer_ring_od/2,0,0])
                        cube([shaft_retainer_ring_od,1.0,
                              shaft_retainer_ring_t+0.2],center=true);
                }
    }
}

function integrated_slot_points(ro,ri,a0,a1,n=80) = concat(
    [for (i=[0:n]) [ro*cos(a0+(a1-a0)*i/n),ro*sin(a0+(a1-a0)*i/n)]],
    [for (i=[n:-1:0]) [ri*cos(a0+(a1-a0)*i/n),ri*sin(a0+(a1-a0)*i/n)]]);

module integrated_sector_pin_slot() {
    translate([0,0,stop_sector_center_z])
        linear_extrude(height=stop_sector_t+0.4,center=true)
            polygon(points=integrated_slot_points(stop_sector_slot_outer_r,stop_sector_slot_inner_r,
                stop_sector_slot_start_deg,stop_sector_slot_end_deg));
}
module integrated_bridge_pin_relief() {
    // Swept relief clears the lower cross-pin head through the full jaw sweep.
    translate([0,0,(stop_bridge_plate_bottom_z+stop_bridge_plate_top_z)/2])
        linear_extrude(height=stop_bridge_plate_t+0.4,center=true)
            polygon(points=integrated_slot_points(30.5,15.5,-25,max_jaw_angle_deg+25));
}
module integrated_bridge_plate() {
    color([0.33,0.45,0.54]) translate([(jaw_gap/2+jaw_thickness/2),pivot_y,0]) difference() {
        translate([0,0,(stop_bridge_plate_bottom_z+stop_bridge_plate_top_z)/2])
            difference() {
                cylinder(d=stop_bridge_plate_outer_d,h=stop_bridge_plate_t,center=true);
                cylinder(d=stop_bridge_plate_inner_d,h=stop_bridge_plate_t+0.3,center=true);
            }
        integrated_bridge_pin_relief();
        for (x=[-6,6])
            translate([x,stop_guard_mount_y,(stop_bridge_plate_bottom_z+stop_bridge_plate_top_z)/2])
                cylinder(d=stop_bridge_mount_hole_d,h=stop_bridge_plate_t+0.4,center=true);
    }
}
module integrated_bridge_support() {
    color([0.34,0.46,0.55]) translate([(jaw_gap/2+jaw_thickness/2),pivot_y,0])
        for (a=stop_bridge_post_angles) rotate([0,0,a]) {
            difference() {
                translate([stop_bridge_r,0,(stop_bridge_post_bottom_z+stop_sector_bottom_z)/2])
                    cylinder(d=stop_bridge_post_d,h=stop_bridge_post_h,center=true);
                // Insert pocket for the placeholder M3-class post-to-sector screw.
                translate([stop_bridge_r,0,(stop_bridge_post_bottom_z+stop_sector_bottom_z)/2])
                    cylinder(d=joint_thread_insert_od+0.2,
                             h=stop_bridge_post_h+0.2,center=true);
            }
            translate([stop_bridge_r,0,stop_bridge_post_bottom_z-0.5])
                cylinder(d=stop_bridge_foot_d,h=1,center=true);
        }
}
module fixed_stop_sector() {
    color([0.42,0.52,0.61]) translate([(jaw_gap/2+jaw_thickness/2),pivot_y,0]) difference() {
        union() {
            translate([0,0,stop_sector_center_z]) cylinder(d=stop_sector_od,h=stop_sector_t,center=true);
            for (a=stop_bridge_post_angles) rotate([0,0,a])
                translate([stop_bridge_r,0,stop_sector_center_z]) cube([10,12,stop_sector_t],center=true);
        }
        translate([0,0,stop_sector_center_z]) cylinder(d=stop_sector_id,h=stop_sector_t+0.4,center=true);
        integrated_sector_pin_slot();
        for (a=stop_bridge_post_angles) rotate([0,0,a])
            translate([stop_bridge_r,0,stop_sector_center_z])
                cylinder(d=stop_bridge_mount_hole_d,h=stop_sector_t+0.4,center=true);
        for (a=stop_block_angles) rotate([0,0,a])
            translate([stop_block_fastener_radius,0,stop_sector_center_z])
                cylinder(d=3.2,h=stop_sector_t+0.4,center=true);
    }
    for (a=stop_block_angles) translate([(jaw_gap/2+jaw_thickness/2),pivot_y,0]) rotate([0,0,a])
        translate([stop_radius,0,stop_sector_top_z+stop_block_height/2])
            color([0.9,0.42,0.12]) difference() {
                cube([stop_block_radial,stop_block_tangent,stop_block_height],center=true);
                translate([stop_block_radial/2-3,0,0]) cylinder(d=joint_screw_clearance_d,h=stop_block_height+0.4,center=true);
            // Recess the placeholder low-profile screw head flush to keep it
            // out of the rotating fork sweep; verify real block strength/fastener.
            translate([stop_block_radial/2-3,0,
                       stop_block_height/2-joint_stop_head_recess_h/2])
                cylinder(d=joint_stop_head_recess_d,
                         h=joint_stop_head_recess_h+0.2,center=true);
            }
}
module integrated_fork_cheek(zc) {
    difference() {
        hull() {
            translate([0,0,zc]) cylinder(d=stop_fork_boss_d,h=stop_fork_cheek_t,center=true);
            translate([stop_radius,0,zc]) cylinder(d=stop_pin_d+4,h=stop_fork_cheek_t,center=true);
        }
        translate([0,0,zc]) d_profile_bore(pivot_shaft_d+0.2,pivot_shaft_flat_x+pivot_shaft_key_clearance,stop_fork_cheek_t+0.3);
        translate([stop_radius,0,zc]) cylinder(d=stop_pin_d+0.3,h=stop_fork_cheek_t+0.3,center=true);
    }
}
module rotating_stop_arm_at(angle) {
    color([0.2,0.43,0.62]) translate([(jaw_gap/2+jaw_thickness/2),pivot_y,0]) rotate([0,0,angle]) {
        integrated_fork_cheek(stop_fork_lower_center_z);
        integrated_fork_cheek(stop_fork_upper_center_z);
        difference() {
            translate([0,0,(stop_fork_lower_center_z+stop_fork_upper_center_z)/2])
                cylinder(d=stop_fork_boss_d,h=stop_fork_upper_center_z-stop_fork_lower_center_z+stop_fork_cheek_t,center=true);
            translate([0,0,(stop_fork_lower_center_z+stop_fork_upper_center_z)/2])
                d_profile_bore(pivot_shaft_d+0.2,pivot_shaft_flat_x+pivot_shaft_key_clearance,
                    stop_fork_upper_center_z-stop_fork_lower_center_z+stop_fork_cheek_t+0.3);
        }
        translate([stop_radius,0,stop_fork_pin_center_z]) {
            color([0.76,0.78,0.81]) cylinder(d=stop_pin_d,h=stop_fork_pin_length,center=true);
            color([0.76,0.78,0.81]) for (s=[-1,1])
                translate([0,0,s*(stop_fork_pin_length/2+1)]) cylinder(d=stop_pin_head_d,h=2,center=true);
        }
    }
}
module rotating_stop_arm() { rotating_stop_arm_at(jaw_angle); }
module integrated_upper_fork_retention() {
    color([0.68,0.74,0.78]) translate([(jaw_gap/2+jaw_thickness/2),pivot_y,stop_fork_upper_center_z+stop_fork_cheek_t/2+stop_upper_washer_t/2])
        difference() {
            cylinder(d=12,h=stop_upper_washer_t,center=true);
            cylinder(d=pivot_shaft_d+0.2,h=stop_upper_washer_t+0.2,center=true);
        }
    color([0.83,0.68,0.35]) translate([(jaw_gap/2+jaw_thickness/2),pivot_y,stop_upper_ring_z])
        difference() {
            cylinder(d=shaft_retainer_ring_od,h=shaft_retainer_ring_t,center=true);
            cylinder(d=shaft_retainer_groove_d,h=shaft_retainer_ring_t+0.2,center=true);
            translate([shaft_retainer_ring_od/2,0,0]) cube([shaft_retainer_ring_od,1,shaft_retainer_ring_t+0.2],center=true);
        }
}
module joint_screw_proxy(x,y,z_bottom,z_top,z_washer,z_head) {
    // Simplified vertical screw, washer, and head; all dimensions are placeholders.
    color([0.72,0.75,0.78]) translate([x,y,(z_bottom+z_top)/2])
        cylinder(d=joint_screw_d,h=z_top-z_bottom,center=true);
    color([0.72,0.75,0.78]) translate([x,y,z_washer])
        difference() {
            cylinder(d=joint_screw_washer_od,h=joint_screw_washer_t,center=true);
            cylinder(d=joint_screw_clearance_d,h=joint_screw_washer_t+0.2,center=true);
        }
    color([0.72,0.75,0.78]) translate([x,y,z_head])
        cylinder(d=joint_screw_head_d,h=joint_screw_head_h,center=true);
}
module joint_nut_proxy(x,y,z_center) {
    // Across-flats nut proxy shown with a hexagonal exterior and clearance bore.
    color([0.70,0.73,0.76]) translate([x,y,z_center])
        difference() {
            cylinder(d=joint_nut_af/cos(30),h=joint_nut_h,$fn=6,center=true);
            cylinder(d=joint_screw_clearance_d,h=joint_nut_h+0.2,center=true);
        }
}
module bridge_joint_fasteners() {
    // Pair passes through the bridge plate and upper bearing bracket cross-holes.
    pivot_x=jaw_gap/2+jaw_thickness/2;
    for (x=[-6,6]) {
        joint_screw_proxy(pivot_x+x,pivot_y+stop_guard_mount_y,
            6,stop_bridge_plate_top_z,
            stop_bridge_plate_top_z+joint_screw_washer_t/2,
            stop_bridge_plate_top_z+joint_screw_washer_t+joint_screw_head_h/2);
        joint_nut_proxy(pivot_x+x,pivot_y+stop_guard_mount_y,
            8-joint_nut_h/2);
    }
}
module post_sector_fasteners() {
    // Four screws enter insert proxies in the bridge posts through sector bosses.
    pivot_x=jaw_gap/2+jaw_thickness/2;
    for (a=stop_bridge_post_angles) {
        x=pivot_x+stop_bridge_r*cos(a);
        y=pivot_y+stop_bridge_r*sin(a);
        color([0.78,0.59,0.31]) translate([x,y,
            (stop_bridge_post_bottom_z+stop_sector_bottom_z)/2])
            difference() {
                cylinder(d=joint_thread_insert_od,h=joint_thread_insert_l,center=true);
                cylinder(d=joint_thread_insert_id,h=joint_thread_insert_l+0.2,center=true);
            }
        joint_screw_proxy(x,y,stop_bridge_post_bottom_z,stop_sector_top_z,
            stop_sector_top_z+joint_screw_washer_t/2,
            stop_sector_top_z+joint_screw_washer_t+joint_screw_head_h/2);
    }
}
module stop_block_fasteners() {
    // Through-bolts clamp each replaceable stop block to the drilled sector.
    pivot_x=jaw_gap/2+jaw_thickness/2;
    for (a=stop_block_angles) {
        x=pivot_x+stop_block_fastener_radius*cos(a);
        y=pivot_y+stop_block_fastener_radius*sin(a);
        block_top_z=stop_sector_top_z+stop_block_height;
        head_h=joint_stop_head_recess_h;
        head_bottom_z=block_top_z-head_h;
        // Placeholder low-profile head sits flush in the block counterbore.
        color([0.72,0.75,0.78]) translate([x,y,
            (stop_sector_bottom_z-joint_nut_h+head_bottom_z)/2])
            cylinder(d=joint_screw_d,
                h=head_bottom_z-(stop_sector_bottom_z-joint_nut_h),center=true);
        color([0.72,0.75,0.78]) translate([x,y,block_top_z-head_h/2])
            cylinder(d=joint_screw_head_d,h=head_h,center=true);
        joint_nut_proxy(x,y,stop_sector_bottom_z-joint_nut_h/2);
    }
}
module stop_guard_shell_body() {
    pivot_x=jaw_gap/2+jaw_thickness/2;
    translate([pivot_x,pivot_y,0]) {
        // Full 360-degree radial wall. The previous jaw-following 62-degree
        // wedge is removed because it left the moving stop accessible from
        // the side. Fork sweep radius is <= stop_radius + stop_pin_d/2 =
        // 27 mm; the guard wall inner radius is 42 mm.
        stop_guard_radial_wall();

        // Narrow lower perimeter flange ties into the shell wall while
        // clearing bridge posts (r <= 40 mm). It is not a bottom floor.
        translate([0,0,stop_guard_bottom_z+stop_guard_bottom_flange_t/2])
            difference() {
                cylinder(d=stop_guard_bottom_flange_outer_d,
                         h=stop_guard_bottom_flange_t,center=true);
                cylinder(d=stop_guard_bottom_flange_inner_d,
                         h=stop_guard_bottom_flange_t+0.2,center=true);
                for (a=stop_guard_floor_mount_angles)
                    rotate([0,0,a])
                        translate([stop_guard_floor_mount_radius,0,0])
                            cylinder(d=stop_guard_floor_screw_clearance_d,
                                     h=stop_guard_bottom_flange_t+0.2,
                                     center=true);
            }

        // Four hollow bosses carry removable lid screws. The selectable insert
        // pocket is a generic packaging proxy; verify the chosen insert and
        // printed pilot with its supplier data and a material-specific coupon.
        for (a=[45,135,225,315])
            rotate([0,0,a])
                translate([stop_guard_lid_screw_radius,0,
                           stop_guard_top_z-stop_guard_boss_h/2])
                    difference() {
                        cylinder(d=stop_guard_boss_d,h=stop_guard_boss_h,
                                 center=true);
                        cylinder(d=stop_guard_thread_pilot_d,
                                 h=stop_guard_boss_h+0.2,center=true);
                        if (stop_guard_lid_fastener_style == "heat_set_insert")
                            translate([0,0,stop_guard_top_z
                                          -stop_guard_insert_length/2
                                          -(stop_guard_top_z-stop_guard_boss_h/2)])
                                cylinder(d=stop_guard_insert_pilot_d,
                                         h=stop_guard_insert_length+0.2,
                                         center=true);
                    }

        // Four perimeter bosses support removable split lower panels. The
        // default retains the coupon-matched 6.5/2.5/3.2 mm self-tapping
        // geometry. Optional captive-nut or heat-set-insert styles are explicit
        // prototype alternatives; neither is selected hardware.
        for (a=stop_guard_floor_mount_angles)
            rotate([0,0,a])
                translate([stop_guard_floor_mount_radius,0,
                    (stop_guard_floor_bottom_z+stop_guard_floor_boss_top_z)/2])
                    difference() {
                        cylinder(d=stop_guard_floor_boss_d,
                                 h=stop_guard_floor_boss_h,center=true);
                        if (stop_guard_floor_fastener_style == "self_tapping")
                            cylinder(d=stop_guard_thread_pilot_d,
                                     h=stop_guard_floor_boss_h+0.2,center=true);
                        else {
                            cylinder(d=stop_guard_floor_screw_clearance_d,
                                     h=stop_guard_floor_boss_h+0.2,center=true);
                            if (stop_guard_floor_fastener_style == "captive_nut")
                                translate([0,0,
                                    (stop_guard_floor_boss_top_z
                                     -joint_nut_h/2)
                                     -(stop_guard_floor_bottom_z
                                       +stop_guard_floor_boss_h/2)])
                                    cylinder(d=joint_nut_af/cos(30),
                                             h=joint_nut_h+0.2,
                                             $fn=6,center=true);
                            else if (stop_guard_floor_fastener_style == "heat_set_insert")
                                translate([0,0,
                                    (stop_guard_floor_boss_top_z
                                     -stop_guard_insert_length/2)
                                     -(stop_guard_floor_bottom_z
                                       +stop_guard_floor_boss_h/2)])
                                    cylinder(d=stop_guard_insert_pilot_d,
                                             h=stop_guard_insert_length+0.2,
                                             center=true);
                        }
                    }

    }
}

module stop_guard_enclosure_body() {
    stop_guard_shell_body();
    pivot_x=jaw_gap/2+jaw_thickness/2;
    translate([pivot_x,pivot_y,0]) stop_guard_lower_floor();
}

module stop_guard_shell_print() {
    pivot_x=jaw_gap/2+jaw_thickness/2;
    translate([-pivot_x,-pivot_y,0]) stop_guard_shell_body();
}

module stop_guard_floor_panel_print(side=1) {
    pivot_x=jaw_gap/2+jaw_thickness/2;
    translate([-pivot_x,-pivot_y,-stop_guard_floor_bottom_z])
        stop_guard_lower_floor_panel(side);
}

module stop_guard_lower_floor() {
    for (side=[-1,1]) stop_guard_lower_floor_panel(side);
    stop_guard_lower_floor_fasteners();
}

module stop_guard_lower_floor_panel(side=1) {
    bracket_d=stop_guard_floor_edge_clearance;
    difference() {
            intersection() {
                translate([0,0,stop_guard_floor_bottom_z+stop_guard_floor_t/2])
                    cylinder(d=stop_guard_floor_outer_d,
                             h=stop_guard_floor_t,center=true);
                translate([side*25,0,stop_guard_floor_bottom_z+stop_guard_floor_t/2])
                    cube([stop_guard_floor_outer_d/2-stop_guard_floor_seam,
                          stop_guard_floor_outer_d+2,stop_guard_floor_t+0.2],
                         center=true);
            }
            // Close-fit rectangular relief surrounds the upper bearing ear;
            // the bracket occupies this entire nominal cutout in the assembly.
            translate([0,support_depth-bearing_bracket_rear_overlap
                       +bearing_bracket_depth/2-pivot_y,
                       stop_guard_floor_bottom_z+stop_guard_floor_t/2])
                cube([bearing_bracket_width+2*bracket_d,
                      bearing_bracket_depth+2*bracket_d,
                      stop_guard_floor_t+0.4],center=true);
            // A 12.4 mm installation channel receives the 12 mm yoke cheek
            // and connects the bracket relief to the rear perimeter.
            channel_outer_y=-stop_guard_floor_outer_d/2-0.2;
            channel_inner_y=support_depth-bearing_bracket_rear_overlap
                -pivot_y-bracket_d/2;
            channel_length=channel_inner_y-channel_outer_y;
            translate([0,(channel_outer_y+channel_inner_y)/2,
                       stop_guard_floor_bottom_z+stop_guard_floor_t/2])
                cube([12+2*bracket_d,channel_length,stop_guard_floor_t+0.4],center=true);
            // The left fixed-reaction rail grazes the panel's outer edge.
            // Its close-fit relief is filled by the existing 12 mm rail.
            translate([-2*(jaw_gap/2+jaw_thickness/2),
                       (support_depth+grip_end_y)/2-pivot_y,
                       stop_guard_floor_bottom_z+stop_guard_floor_t/2])
                cube([jaw_thickness+2*bracket_d,
                      grip_end_y-support_depth+2*bracket_d,
                      stop_guard_floor_t+0.4],center=true);
            // The 84 x 10 mm cross-tie crosses the floor plane. This relief
            // is fully backed by that structural beam, with 0.2 mm nominal
            // side/top clearances; it is not an open cutout after assembly.
            translate([-jaw_gap/2-jaw_thickness/2,
                       support_depth/2-pivot_y,
                       stop_guard_floor_bottom_z+stop_guard_floor_t/2])
                cube([support_cross_tie_width+2*bracket_d,
                      10+2*bracket_d,stop_guard_floor_t+0.4],center=true);
            for (a=stop_guard_floor_mount_angles)
                rotate([0,0,a]) {
                    translate([stop_guard_floor_mount_radius,0,
                               stop_guard_floor_bottom_z+stop_guard_floor_t/2])
                     cylinder(d=stop_guard_floor_boss_d+2*stop_guard_floor_boss_clearance,
                                 h=stop_guard_floor_t+0.4,center=true);
                }
        }
}

module stop_guard_lower_floor_fasteners() {
    for (a=stop_guard_floor_mount_angles) rotate([0,0,a])
        translate([stop_guard_floor_mount_radius,0,0]) {
                translate([0,0,(stop_guard_floor_bottom_z-stop_guard_floor_head_t
                    +stop_guard_floor_boss_top_z)/2])
                    color([0.72,0.75,0.78])
                        cylinder(d=stop_guard_floor_screw_d,
                            h=stop_guard_floor_boss_h+stop_guard_floor_head_t,
                            center=true);
                translate([0,0,stop_guard_floor_bottom_z-stop_guard_floor_head_t/2])
                    color([0.72,0.75,0.78])
                        difference() {
                            cylinder(d=stop_guard_floor_head_d,
                                     h=stop_guard_floor_head_t,center=true);
                            translate([0,0,-stop_guard_floor_head_t/2
                                          +stop_guard_fastener_socket_depth/2])
                                cylinder(d=stop_guard_fastener_socket_af/cos(30),
                                         h=stop_guard_fastener_socket_depth,
                                         $fn=6,center=true);
                        }
            }
}

module stop_guard_lower_floor_structure_clearance() {
    pivot_x=jaw_gap/2+jaw_thickness/2;
    intersection() {
        translate([pivot_x,pivot_y,0]) stop_guard_lower_floor();
        union() {
            mount_plate();
            support_frame();
            frame_mount_inserts();
            frame_mount_fasteners();
            pivot_bearing_brackets();
            bearing_ear_inserts();
            bearing_ear_fasteners();
    ser203x_topmount_package();

            actuator_output_shaft_proxy();
            integrated_bridge_plate();
            integrated_bridge_support();
            bridge_joint_fasteners();
            pivot_through_shaft();
            pivot_axial_retention();
        }
    }
}

module stop_guard_shell_floor_clearance() {
    pivot_x=jaw_gap/2+jaw_thickness/2;
    intersection() {
        translate([pivot_x,pivot_y,0]) stop_guard_shell_body();
        translate([pivot_x,pivot_y,0]) union() {
            stop_guard_lower_floor_panel(-1);
            stop_guard_lower_floor_panel(1);
        }
    }
}

module stop_guard_radial_wall() {
    slot_w=12+2*stop_guard_floor_edge_clearance;
    difference() {
        difference() {
            translate([0,0,(stop_guard_bottom_z+stop_guard_top_z)/2])
                cylinder(d=stop_guard_outer_d,
                         h=stop_guard_top_z-stop_guard_bottom_z,center=true);
            translate([0,0,(stop_guard_bottom_z+stop_guard_top_z)/2])
                cylinder(d=stop_guard_inner_d,
                         h=stop_guard_top_z-stop_guard_bottom_z+0.2,center=true);
        }
        // The radial notch receives the right support cheek only through its
        // modeled height; the radial wall continues above the cheek to close
        // the former 12.4 x 12.0 mm side aperture.
        translate([0,-44,(stop_guard_bottom_z+support_cheek_top_z)/2])
            cube([slot_w,10,support_cheek_top_z-stop_guard_bottom_z+0.2],center=true);
        // The cross-tie occupies its complete notched footprint through z=15.
        // Keep the wall continuous above z=15.2 and let the beam back the notch.
        translate([-jaw_gap/2-jaw_thickness/2,
                   support_depth/2-pivot_y,
                   (stop_guard_bottom_z+15.2)/2])
            cube([support_cross_tie_width+2*stop_guard_floor_edge_clearance,
                  10+2*stop_guard_floor_edge_clearance,
                  15.2-stop_guard_bottom_z+0.2],center=true);
    }
}

module stop_guard_wall_support_clearance() {
    pivot_x=jaw_gap/2+jaw_thickness/2;
    intersection() {
        translate([pivot_x,pivot_y,0]) stop_guard_radial_wall();
        union() {
            mount_plate(); support_frame(); frame_mount_inserts(); frame_mount_fasteners();
            pivot_bearing_brackets(); bearing_ear_inserts(); bearing_ear_fasteners();
        }
    }
}

module stop_guard_lower_floor_clearance_vs(target) {
    pivot_x=jaw_gap/2+jaw_thickness/2;
    intersection() {
        translate([pivot_x,pivot_y,0]) stop_guard_lower_floor();
        if (target=="support") union() {
            mount_plate(); support_frame(); frame_mount_inserts(); frame_mount_fasteners();
        }
        else if (target=="bearing") union() {
            pivot_bearing_brackets(); bearing_ear_inserts(); bearing_ear_fasteners();
        }
        else if (target=="actuator") union() {
            ser203x_topmount_package(); selected_actuator_coupler_proxy(); actuator_output_shaft_proxy();
        }
        else if (target=="bridge") union() {
            integrated_bridge_plate(); integrated_bridge_support(); bridge_joint_fasteners();
        }
        else if (target=="shaft") union() { pivot_through_shaft(); pivot_axial_retention(); }
    }
}

module stop_guard_lid() {
    pivot_x=jaw_gap/2+jaw_thickness/2;
    translate([pivot_x,pivot_y,0])
        color([0.18,0.2,0.22,0.22])
        difference() {
            translate([0,0,stop_guard_top_z+stop_guard_cap_t/2])
                cylinder(d=stop_guard_cap_outer_d,h=stop_guard_cap_t,
                         center=true);
            // The top cover has its own smaller shaft aperture. The lower
            // removable floor keeps the larger washer-clearance opening.
            translate([0,0,stop_guard_top_z+stop_guard_cap_t/2])
                cylinder(d=stop_guard_lid_shaft_hole_d,
                         h=stop_guard_cap_t+0.2,center=true);
            for (a=[45,135,225,315]) rotate([0,0,a]) {
                translate([stop_guard_lid_screw_radius,0,
                           stop_guard_top_z+stop_guard_cap_t/2])
                    cylinder(d=stop_guard_lid_screw_clearance_d,
                             h=stop_guard_cap_t+0.2,center=true);
                // Counterbore leaves a nominal 1.5 mm lid web; fastener
                // head/protrusion and inspection remain to be checked.
                translate([stop_guard_lid_screw_radius,0,
                           stop_guard_top_z+stop_guard_cap_t
                           -stop_guard_lid_head_t/2])
                    cylinder(d=stop_guard_lid_head_d,
                             h=stop_guard_lid_head_t+0.2,center=true);
            }
        }
}

module stop_guard_lid_fasteners() {
    pivot_x=jaw_gap/2+jaw_thickness/2;
    translate([pivot_x,pivot_y,0])
        for (a=[45,135,225,315]) rotate([0,0,a]) {
            translate([stop_guard_lid_screw_radius,0,
                       stop_guard_top_z-stop_guard_boss_h/2
                       +(stop_guard_cap_t-stop_guard_lid_head_t)/2])
                color([0.72,0.75,0.78])
                    cylinder(d=stop_guard_lid_screw_d,
                             h=stop_guard_boss_h+stop_guard_cap_t
                               -stop_guard_lid_head_t,center=true);
            translate([stop_guard_lid_screw_radius,0,
                       stop_guard_top_z+stop_guard_cap_t
                       -stop_guard_lid_head_t/2])
                color([0.72,0.75,0.78])
                    difference() {
                        cylinder(d=stop_guard_lid_head_d,
                                 h=stop_guard_lid_head_t,center=true);
                        translate([0,0,stop_guard_lid_head_t/2
                                      -stop_guard_fastener_socket_depth/2])
                            cylinder(d=stop_guard_fastener_socket_af/cos(30),
                                     h=stop_guard_fastener_socket_depth,
                                     $fn=6,center=true);
                    }
    }
}

module stop_guard_sector_clearance() {
    intersection() {
        stop_guard_enclosure_body();
        union() {
            rotating_stop_arm();
            pivot_through_shaft();
            pivot_axial_retention();
            integrated_upper_fork_retention();
            fixed_stop_sector();
            integrated_bridge_support();
        }
    }
}

module stop_guard_enclosure_clearance(angle=jaw_angle) {
    intersection() {
        union() { stop_guard_enclosure_body(); stop_guard_lid(); stop_guard_lid_fasteners(); }
        union() {
            rotating_stop_arm_at(angle);
            pivot_through_shaft();
            pivot_axial_retention();
            integrated_upper_fork_retention();
            fixed_stop_sector();
            integrated_bridge_support();
        }
    }
}

module stop_guard_access_diagnostic() {
    echo(str("Radial wall: full 360 deg; nominal annular gap to stop-sector OD = ",
             stop_guard_inner_d/2-stop_sector_od/2," mm; circumferential side seam = 0 mm nominal."));
    echo(str("Removable lid perimeter seam = 0 mm nominal; top shaft aperture = ",
             stop_guard_lid_shaft_hole_d," mm; four screw passages = ",
             stop_guard_lid_screw_clearance_d," mm; counterbores = ",
             stop_guard_lid_head_d," x ",stop_guard_lid_head_t,
             " mm; nominal residual lid web = ",
             stop_guard_cap_t-stop_guard_lid_head_t-0.2," mm."));
    echo(str("Split lower panels: central shaft opening = ",
        actuator_guard_shaft_hole_d," mm; panel-to-panel seam = ",
        stop_guard_floor_seam," mm nominal; outer panel edge/skirt face seam = 0 mm nominal."));
    echo(str("Bearing-bracket relief = ",
        bearing_bracket_width+2*stop_guard_floor_edge_clearance," x ",
        bearing_bracket_depth+2*stop_guard_floor_edge_clearance,
        " mm around ",bearing_bracket_width," x ",bearing_bracket_depth,
        " mm bracket; maximum nominal perimeter gap = ",
        stop_guard_floor_edge_clearance," mm."));
    echo(str("Yoke-cheek installation channel = ",
        12+2*stop_guard_floor_edge_clearance," mm around 12 mm cheek; maximum nominal side gap = ",
        stop_guard_floor_edge_clearance," mm each side. The cheek occupies the channel in assembly."));
    echo(str("Left fixed-rail relief = ",jaw_thickness+2*stop_guard_floor_edge_clearance,
        " mm around ",jaw_thickness," mm rail; nominal side gap = ",
        stop_guard_floor_edge_clearance," mm each side."));
    echo(str("Cross-tie relief = ",support_cross_tie_width+2*stop_guard_floor_edge_clearance,
        " x ",10+2*stop_guard_floor_edge_clearance,
        " mm around ",support_cross_tie_width," x 10 mm beam; 0.2 mm nominal edge gaps, beam top z=15 mm, wall resumes z=15.2 mm."));
    echo(str("Radial wall resumes at z = ",support_cheek_top_z,
        " mm, above the modeled ",support_cheek_height,
        " mm support cheek; the former side port is closed by solid wall."));
    echo(str("Floor fastener style = ",stop_guard_floor_fastener_style,
        "; boss OD/height = ",stop_guard_floor_boss_d," x ",
        stop_guard_floor_boss_h," mm; panel boss relief = ",
        stop_guard_floor_boss_d+2*stop_guard_floor_boss_clearance,
        " mm; underside head flange = ",stop_guard_floor_head_d," mm."));
    if (stop_guard_floor_fastener_style == "self_tapping")
        echo(str("Self-tapping pilot/nominal thread engagement = ",
            stop_guard_thread_pilot_d," / ",stop_guard_floor_boss_h,
            " mm; printed-plastic retention and service life are untested."));
    else if (stop_guard_floor_fastener_style == "captive_nut")
        echo(str("Captive-nut proxy = AF ",joint_nut_af," x ",joint_nut_h,
            " mm; screw clearance ",stop_guard_floor_screw_clearance_d,
            " mm. Select and verify real nut/screw dimensions and retention."));
    else if (stop_guard_floor_fastener_style == "heat_set_insert")
        echo(str("Heat-set insert proxy pilot/length = ",
            stop_guard_insert_pilot_d," / ",stop_guard_insert_length,
            " mm; verify the selected insert datasheet and test retention."));
    echo(str("Lid fastener style = ",stop_guard_lid_fastener_style,
        "; insert pilot/length = ",stop_guard_insert_pilot_d," / ",
        stop_guard_insert_length," mm when enabled. No actual insert or screw is selected."));
    echo("Top lid is removable with four placeholder screws; recessed driver access is modeled. This is a service panel, not an IP-20 acceptance test.");
    echo(str("Floor top z = ",
        stop_guard_floor_bottom_z+stop_guard_floor_t,
        " mm; lower cross-pin head bottom z = ",
        stop_fork_pin_center_z-(stop_fork_pin_length/2+1)-1,
        " mm; nominal head-to-floor clearance = ",
        (stop_fork_pin_center_z-(stop_fork_pin_length/2+1)-1)
            -(stop_guard_floor_bottom_z+stop_guard_floor_t),
        " mm. Upper bearing-bracket top = ",jaw_height/2+bearing_h,
        " mm; bracket/cheek reliefs are fitted to support geometry."));
    echo("The split floor is modeled as two removable panels with close-fit cutouts around the existing upper bracket and right yoke cheek; check them against the full structure with stop_guard_floor_structure_clearance.");
    echo("All gaps are nominal packaging targets; assembled fit, tolerance stack, debris/probe access, water sealing, materials, and physical inspection are unverified. No inspection-compliance claim.");
    echo("Aperture numbers are nominal packaging targets only; manufacturing tolerances, tool/probe paths, retained hardware, materials, and physical inspection are unverified. No inspection-compliance claim.");
    echo("Compile part_view=stop_guard_clearance_samples to check the guard/floor against the fork, shaft retention, stop sector, and bridge at 5-degree increments plus 22 and 44 deg; empty result means no modeled solid intersection at those sampled poses only.");
}

module stop_guard_enclosure_clearance_samples() {
    for (sample_angle=[0:5:40]) {
        echo(str("Checking enclosure against fork and retainers at jaw angle ",sample_angle," deg"));
        stop_guard_enclosure_clearance(sample_angle);
    }
    echo("Checking enclosure against fork and retainers at jaw angle 44 deg");
    stop_guard_enclosure_clearance(44);
}

module stop_guard_enclosure_only() {
    stop_guard_enclosure_body();
    stop_guard_lid();
    stop_guard_lid_fasteners();
}

module stop_guard_lid_print() {
    pivot_x=jaw_gap/2+jaw_thickness/2;
    translate([-pivot_x,-pivot_y,-stop_guard_top_z]) stop_guard_lid();
}

module stop_guard_hardware_proxy() {
    pivot_x=jaw_gap/2+jaw_thickness/2;
    translate([-pivot_x,-pivot_y,0]) {
        stop_guard_lower_floor_fasteners();
        stop_guard_lid_fasteners();
    }
}

module stop_sector_guard() {
    if (show_guard) {
        color([0.18,0.2,0.22,0.18]) stop_guard_enclosure_body();
        stop_guard_lid();
        stop_guard_lid_fasteners();
    }
}
module integrated_stop_overlap_diagnostics() {
    echo(str("Stop plate/lower fork cheek nominal clearance = ",stop_sector_bottom_z-(stop_fork_lower_center_z+stop_fork_cheek_t/2)," mm"));
    echo(str("Upper fork cheek/stop-block nominal clearance = ",(stop_fork_upper_center_z-stop_fork_cheek_t/2)-(stop_sector_top_z+stop_block_height)," mm"));
    echo(str("Bridge post clearance to fork pin sweep = ",stop_bridge_r-stop_bridge_post_d/2-(stop_radius+stop_pin_d/2)," mm"));
    echo("Bridge plate cross-pin relief: radial sweep 15.5..30.5 mm, angular sweep -25..69 deg; >=1.5 mm nominal head clearance.");
    echo(str("Guard radial clearance to sector edge = ",stop_guard_inner_d/2-stop_sector_od/2," mm; radial wall window = ",stop_guard_window_deg," deg"));
    stop_guard_access_diagnostic();
    echo("Joint screws, washers, nuts, and insert proxies are illustrative placeholders only.");
    echo("Unresolved actuator, material, strength, vehicle mount, prop clearance, and guard access interfaces.");
    echo("UNPOWERED PACKAGING STUDY ONLY; not load-rated, fabrication-ready, or approved for powered use.");
}

module actuator_coupler_proxy() {
    // Two-sided blind-bore coupling proxy. The center web prevents the two
    // coaxial shaft ends from occupying the same volume. Shaft diameters,
    // engagements, retention, and rated torque must come from selected hardware.
    pivot_x = jaw_gap/2 + jaw_thickness/2;
    coupler_center_z = actuator_coupler_lower_z+actuator_coupler_l/2;
    motor_bore_center_z = actuator_coupler_lower_z
        +actuator_motor_shaft_engagement/2;
    pivot_bore_center_z = actuator_coupler_upper_z
        -actuator_pivot_shaft_engagement/2;
    color([0.82,0.72,0.42])
        translate([pivot_x,pivot_y,coupler_center_z])
            difference() {
                cylinder(d=actuator_coupler_d,h=actuator_coupler_l,center=true);
                translate([0,0,motor_bore_center_z-coupler_center_z])
                    cylinder(d=actuator_coupler_motor_bore_d,
                             h=actuator_motor_shaft_engagement+0.2,center=true);
                translate([0,0,pivot_bore_center_z-coupler_center_z])
                    cylinder(d=actuator_coupler_pivot_bore_d,
                             h=actuator_pivot_shaft_engagement+0.2,center=true);
                // Radial set-screw pilots, one for each shaft end. These are
                // schematic holes, not a specified clamp or torque rating.
                for (z=[motor_bore_center_z,pivot_bore_center_z])
                    translate([actuator_coupler_d/2-1.7,0,
                               z-coupler_center_z])
                        rotate([0,90,0])
                            cylinder(d=actuator_coupler_set_screw_d,
                                     h=5.2,center=true);
            }
}

function dshaft_coupler_flat_x(shaft_d,flat_depth,diametral_clearance) =
    shaft_d/2-flat_depth+diametral_clearance/2;

module dshaft_coupler_proxy() {
    // Optional adapted module: 6 mm motor D-shaft to the study's 8 mm pivot D-shaft.
    // Existing axial package dimensions are retained; engagements and every fit
    // feature below remain placeholders until checked against vendor STEP/hardware.
    pivot_x=jaw_gap/2+jaw_thickness/2;
    coupler_center_z=actuator_coupler_lower_z+actuator_coupler_l/2;
    motor_bore_center_z=actuator_coupler_lower_z+actuator_motor_shaft_engagement/2;
    pivot_bore_center_z=actuator_coupler_upper_z-actuator_pivot_shaft_engagement/2;
    motor_bore_d=actuator_output_shaft_d+dshaft_motor_diametral_clearance;
    pivot_bore_d=pivot_shaft_d+dshaft_pivot_diametral_clearance;
    motor_flat_x=dshaft_coupler_flat_x(actuator_output_shaft_d,
        dshaft_motor_flat_depth,dshaft_motor_diametral_clearance);
    pivot_flat_x=dshaft_coupler_flat_x(pivot_shaft_d,
        dshaft_pivot_flat_depth,dshaft_pivot_diametral_clearance);
    // The coupler and its D-shaped motor stub turn with the jaw/pivot shaft.
    // Without this rotation the two D profiles would bind as the jaw moves.
    translate([pivot_x,pivot_y,0]) rotate([0,0,jaw_angle])
        translate([0,0,coupler_center_z])
            color([0.82,0.68,0.36]) difference() {
                cylinder(d=dshaft_coupler_outer_d,h=actuator_coupler_l,center=true);
                translate([0,0,motor_bore_center_z-coupler_center_z])
                    d_profile_bore(motor_bore_d,motor_flat_x,
                        actuator_motor_shaft_engagement+0.2);
                translate([0,0,pivot_bore_center_z-coupler_center_z])
                    d_profile_bore(pivot_bore_d,pivot_flat_x,
                        actuator_pivot_shaft_engagement+0.2);
                // Radial pilots are unthreaded placeholders, not retention hardware.
                for (z=[motor_bore_center_z,pivot_bore_center_z])
                    translate([dshaft_coupler_outer_d/2
                               -dshaft_retention_pilot_depth/2+0.05,0,
                               z-coupler_center_z])
                        rotate([0,90,0])
                            cylinder(d=dshaft_retention_pilot_d,
                                h=dshaft_retention_pilot_depth+0.1,center=true);
            }
    echo(str("Optional D-shaft coupling proxy: OD ",dshaft_coupler_outer_d,
        " mm; motor D-bore ",motor_bore_d," mm; pivot D-bore ",pivot_bore_d,
        " mm; total axial package ",actuator_coupler_l," mm."));
    echo("Motor/pivot flats, bore clearances, engagement, hub wall, pilot retention, materials, and torque capacity are placeholders; no retention method is selected.");
}

module selected_actuator_coupler_proxy() {
    if (show_dshaft_coupler_interface) dshaft_coupler_proxy();
    else actuator_coupler_proxy();
}

module actuator_output_shaft_proxy() {
    // Output stub projects from the motor's upper face into its blind bore.
    pivot_x = jaw_gap/2+jaw_thickness/2;
    shaft_center_z = actuator_motor_inner_face_z
        +actuator_motor_shaft_engagement/2;
    translate([pivot_x,pivot_y,0]) rotate([0,0,jaw_angle])
    color([0.68,0.71,0.74]) translate([0,0,shaft_center_z])
        if (show_dshaft_coupler_interface)
            difference() {
                cylinder(d=actuator_output_shaft_d,
                    h=actuator_motor_shaft_engagement,center=true);
                // Symmetric Y span matches the D-bore cutter; only +X is removed.
                translate([dshaft_coupler_flat_x(actuator_output_shaft_d,
                           dshaft_motor_flat_depth,0)+actuator_output_shaft_d,0,0])
                    cube([2*actuator_output_shaft_d,
                          2*actuator_output_shaft_d,
                          actuator_motor_shaft_engagement+0.2],center=true);
            }
        else
            cylinder(d=actuator_output_shaft_d,
                     h=actuator_motor_shaft_engagement,center=true);
}

module actuator_reaction_half(side=1) {
    pivot_x = jaw_gap/2+jaw_thickness/2;
    ring_z = actuator_reaction_ring_center_z;
    foot_top_z = actuator_reaction_rail_top_z;
    foot_bottom_z = foot_top_z-actuator_reaction_foot_h;
    foot_center_z = (foot_top_z+foot_bottom_z)/2;
    rail_center_z = (actuator_reaction_rail_top_z
                     +actuator_reaction_rail_bottom_z)/2;
    color([0.48,0.59,0.66])
        difference() {
            union() {
                // Two-piece clamp band; each half is also tied to the lower
                // pivot ear by a rigid tangential rail and a bolted foot.
                intersection() {
                    difference() {
                        translate([pivot_x,pivot_y,ring_z])
                            cylinder(d=actuator_reaction_ring_outer_d,
                                     h=actuator_reaction_ring_h,center=true);
                        translate([pivot_x,pivot_y,ring_z])
                            cylinder(d=actuator_reaction_ring_inner_d,
                                     h=actuator_reaction_ring_h+0.2,center=true);
                    }
                    translate([pivot_x+side*actuator_reaction_ring_outer_d/2,
                               pivot_y,ring_z])
                        cube([actuator_reaction_ring_outer_d,
                              actuator_reaction_ring_outer_d*2,
                              actuator_reaction_ring_h+0.2],center=true);
                }
                for (yoff=[-actuator_reaction_ring_bolt_pitch_y/2,
                            actuator_reaction_ring_bolt_pitch_y/2])
                    translate([pivot_x+side*actuator_reaction_ring_flange_w/2,
                               pivot_y+yoff,ring_z])
                        cube([actuator_reaction_ring_flange_w,
                              actuator_reaction_ring_flange_t,
                              actuator_reaction_ring_h],center=true);
                // Rails stay outside the 20 mm actuator envelope and inside
                // the 34 mm guard cavity; slots in the guard cap clear them.
                translate([pivot_x+side*actuator_reaction_rail_x_offset,
                           pivot_y,rail_center_z])
                    cube([actuator_reaction_rail_radial_t,
                          actuator_reaction_rail_width,
                          actuator_reaction_rail_h],center=true);
                translate([pivot_x+side*actuator_reaction_rail_x_offset,
                           pivot_y,foot_center_z])
                    cube([actuator_reaction_foot_size,
                          actuator_reaction_foot_size,
                          actuator_reaction_foot_h],center=true);
            }
            // Preserve body clearance where the clamp lugs bridge the split.
            translate([pivot_x,pivot_y,ring_z])
                cylinder(d=actuator_reaction_ring_inner_d,
                         h=actuator_reaction_ring_h+0.2,center=true);
            for (yoff=[-actuator_reaction_ring_bolt_pitch_y/2,
                        actuator_reaction_ring_bolt_pitch_y/2]) {
                translate([pivot_x+side*actuator_reaction_ring_flange_w/2,
                           pivot_y+yoff,ring_z]) rotate([0,90,0])
                    cylinder(d=actuator_reaction_ring_bolt_clearance,
                             h=actuator_reaction_ring_flange_w+0.2,center=true);
                if (side > 0)
                    translate([pivot_x+actuator_reaction_ring_flange_w
                               -actuator_reaction_ring_bolt_head_h/2,
                               pivot_y+yoff,ring_z]) rotate([0,90,0])
                        cylinder(d=actuator_reaction_ring_bolt_head_d,
                                 h=actuator_reaction_ring_bolt_head_h+0.1,
                                 center=true);
                else
                    translate([pivot_x-actuator_reaction_ring_flange_w
                               +actuator_reaction_ring_nut_h/2,
                               pivot_y+yoff,ring_z]) rotate([0,90,0])
                        cylinder(d=actuator_reaction_ring_nut_af,
                                 h=actuator_reaction_ring_nut_h+0.1,
                                 $fn=6,center=true);
            }
            translate([pivot_x+side*actuator_reaction_rail_x_offset,
                       pivot_y,foot_center_z])
                cylinder(d=actuator_reaction_screw_d+0.2,
                         h=actuator_reaction_foot_h+0.2,center=true);
            translate([pivot_x+side*actuator_reaction_rail_x_offset,
                       pivot_y,foot_bottom_z+actuator_reaction_screw_head_h/2])
                cylinder(d=actuator_reaction_screw_head_d,
                         h=actuator_reaction_screw_head_h+0.1,center=true);
        }
}

module actuator_reaction_inserts() {
    pivot_x = jaw_gap/2+jaw_thickness/2;
    insert_z = -jaw_height/2-bearing_h+actuator_reaction_insert_l/2;
    for (side=[-1,1])
        color([0.78,0.57,0.30])
            translate([pivot_x+side*actuator_reaction_rail_x_offset,
                       pivot_y,insert_z])
                difference() {
                    cylinder(d=actuator_reaction_insert_od,
                             h=actuator_reaction_insert_l,center=true);
                    cylinder(d=actuator_reaction_insert_bore_d,
                             h=actuator_reaction_insert_l+0.2,center=true);
                }
}

module actuator_reaction_fasteners() {
    pivot_x = jaw_gap/2+jaw_thickness/2;
    ring_z = actuator_reaction_ring_center_z;
    for (yoff=[-actuator_reaction_ring_bolt_pitch_y/2,
                actuator_reaction_ring_bolt_pitch_y/2]) {
        color([0.68,0.71,0.74]) {
            translate([pivot_x,pivot_y+yoff,ring_z]) rotate([0,90,0])
                cylinder(d=actuator_reaction_ring_bolt_d,h=13.6,center=true);
            translate([pivot_x+actuator_reaction_ring_flange_w
                       +actuator_reaction_ring_bolt_head_h/2,
                       pivot_y+yoff,ring_z]) rotate([0,90,0])
                cylinder(d=actuator_reaction_ring_bolt_head_d,
                         h=actuator_reaction_ring_bolt_head_h,center=true);
            translate([pivot_x-actuator_reaction_ring_flange_w
                       -actuator_reaction_ring_nut_h/2,
                       pivot_y+yoff,ring_z]) rotate([0,90,0])
                difference() {
                    cylinder(d=actuator_reaction_ring_nut_af,
                             h=actuator_reaction_ring_nut_h,$fn=6,center=true);
                    cylinder(d=actuator_reaction_ring_bolt_d+0.2,
                             h=actuator_reaction_ring_nut_h+0.2,center=true);
                }
        }
    }
    for (side=[-1,1]) {
        foot_bottom_z = actuator_reaction_rail_top_z
                        -actuator_reaction_foot_h;
        color([0.68,0.71,0.74]) {
            translate([pivot_x+side*actuator_reaction_rail_x_offset,
                       pivot_y,foot_bottom_z+actuator_reaction_screw_l/2])
                cylinder(d=actuator_reaction_screw_d,
                         h=actuator_reaction_screw_l,center=true);
            translate([pivot_x+side*actuator_reaction_rail_x_offset,
                       pivot_y,foot_bottom_z+actuator_reaction_screw_head_h/2])
                cylinder(d=actuator_reaction_screw_head_d,
                         h=actuator_reaction_screw_head_h,center=true);
        }
    }
}

module actuator_reaction_mount() {
    actuator_reaction_half(1);
    actuator_reaction_half(-1);
    actuator_reaction_inserts();
    actuator_reaction_fasteners();
}

module actuator_proxy() {
    // Schematic coaxial rotary-drive envelope at the jaw hinge; type/rating TBD.
    // The optional vendor-dimensioned case replaces this small generic cylinder
    // for a fit comparison. Its connector is omitted and its guard/mount are not
    // redesigned; do not use the overlay as evidence of fit or compliance.
    motor_center_z = -jaw_height/2-actuator_axial_gap-actuator_body_l/2;
    pivot_x = jaw_gap/2+jaw_thickness/2;
    if (show_ser203x_package_proxy) {
        echo("SER203x/SER213x dimensional envelope active: connector omitted; generic reaction mount and Ø34 shroud remain unmodified and clash with this case.");
        translate([pivot_x,pivot_y,actuator_motor_inner_face_z-72.1])
            rotate([0,0,ser203x_package_rotation_deg])
                ser203x_housing_and_top_feature_proxy();
    } else {
        color([0.30,0.34,0.39])
            translate([pivot_x,pivot_y,motor_center_z])
                cylinder(d=actuator_body_d,h=actuator_body_l,center=true);
    }
}

module ser203x_housing_and_top_feature_proxy() {
    // Inline, review-only SER-203x/SER-213x case proxy. Dimensions follow the
    // current BTE drawing: 70 x 32 x 67 mm case, 24 mm top feature and four
    // Ø2.9 x 16 mm top holes on a 35 x 22 mm pattern. Corner radius and top
    // feature height are visual approximations. The moving D-shaft is supplied
    // separately by the gripper's coupler proxy. The connector and side holes
    // are omitted. This module makes the overlay independent of an exported STL.
    color([0.25,0.28,0.32])
        difference() {
            hull()
                for (x=[-32,32],y=[-13,13])
                    translate([x,y,0]) cylinder(r=3,h=67);
            for (x=[-17.5,17.5],y=[-11,11])
                translate([x,y,51]) cylinder(d=2.9,h=16.2);
        }
    color([0.36,0.39,0.43])
        translate([0,0,67]) cylinder(d=24,h=5.1);
}

module actuator_guard_half(positive_side=1) {
    motor_center_z = -jaw_height/2-actuator_axial_gap-actuator_body_l/2;
    guard_top_z = actuator_guard_top_z;
    guard_bottom_z = motor_center_z-actuator_body_l/2-actuator_guard_bottom_extension;
    guard_h = guard_top_z-guard_bottom_z;
    guard_center_z = (guard_top_z+guard_bottom_z)/2;
    cavity_bottom_z = guard_bottom_z+actuator_shroud_end_wall;
    cavity_top_z = guard_top_z-actuator_shroud_end_wall;
    cavity_h = cavity_top_z-cavity_bottom_z;
    guard_x = jaw_gap/2+jaw_thickness/2;
    screw_zs = [guard_bottom_z+actuator_guard_screw_z_inset,
                guard_center_z,
                guard_top_z-actuator_guard_screw_z_inset];
    if (show_guard)
        color([0.18,0.35,0.48,0.42])
            translate([guard_x,pivot_y,guard_center_z])
                difference() {
                    intersection() {
                        union() {
                            difference() {
                                cylinder(d=actuator_guard_outer_d,
                                         h=guard_h,center=true);
                                translate([0,0,(cavity_bottom_z+cavity_top_z)/2
                                           -guard_center_z])
                                    cylinder(d=actuator_guard_inner_d,
                                             h=cavity_h,center=true);
                                translate([0,0,(cavity_top_z+guard_top_z)/2
                                           -guard_center_z])
                                    cylinder(d=actuator_guard_shaft_hole_d,
                                             h=actuator_shroud_end_wall+0.2,
                                             center=true);
                                for (rail_side=[-1,1])
                                    translate([rail_side*actuator_reaction_rail_x_offset,
                                               0,(cavity_top_z+guard_top_z)/2
                                               -guard_center_z])
                                        cube([actuator_reaction_rail_radial_t+0.4,
                                              actuator_reaction_rail_width+0.4,
                                              actuator_shroud_end_wall+0.2],
                                             center=true);
                            }
                            // Paired seam rails leave room for cross-bolts and
                            // heat-set inserts while keeping all internal gaps covered.
                            for (side=[-1,1])
                                translate([side*actuator_guard_fastener_radius_x,
                                           0,0])
                                    cube([actuator_guard_split_flange_w,
                                          actuator_guard_split_flange_h,
                                          guard_h],center=true);
                        }
                        translate([0,positive_side*50,0])
                            cube([100,100,guard_h+2],center=true);
                    }
                    for (xside=[-1,1])
                        for (z_abs=screw_zs) {
                            z_local = z_abs-guard_center_z;
                            if (positive_side > 0) {
                                // Clearance hole and counterbore on the service side.
                                translate([xside*actuator_guard_fastener_radius_x,
                                           0,z_local]) rotate([90,0,0])
                                    cylinder(d=actuator_guard_fastener_clearance,
                                             h=actuator_guard_split_flange_h+0.2,
                                             center=true);
                                translate([xside*actuator_guard_fastener_radius_x,
                                           actuator_guard_split_flange_h/2
                                           -actuator_guard_fastener_head_h/2,
                                           z_local]) rotate([90,0,0])
                                    cylinder(d=actuator_guard_fastener_head_d,
                                             h=actuator_guard_fastener_head_h+0.1,
                                             center=true);
                            } else {
                                // Insert pockets enter from the opposite shell half.
                                translate([xside*actuator_guard_fastener_radius_x,
                                           -actuator_guard_split_flange_h/2
                                           +actuator_guard_insert_l/2,
                                           z_local]) rotate([90,0,0])
                                    cylinder(d=actuator_guard_insert_od,
                                             h=actuator_guard_insert_l+0.2,
                                             center=true);
                            }
                        }
                }
}

module actuator_guard_inserts() {
    motor_center_z = -jaw_height/2-actuator_axial_gap-actuator_body_l/2;
    guard_top_z = actuator_guard_top_z;
    guard_bottom_z = motor_center_z-actuator_body_l/2-actuator_guard_bottom_extension;
    guard_center_z = (guard_top_z+guard_bottom_z)/2;
    guard_x = jaw_gap/2+jaw_thickness/2;
    screw_zs = [guard_bottom_z+actuator_guard_screw_z_inset,
                guard_center_z,
                guard_top_z-actuator_guard_screw_z_inset];
    for (xside=[-1,1])
        for (z_abs=screw_zs)
            color([0.78,0.57,0.30])
                translate([guard_x+xside*actuator_guard_fastener_radius_x,
                           pivot_y-actuator_guard_split_flange_h/2
                           +actuator_guard_insert_l/2,
                           z_abs]) rotate([90,0,0])
                    difference() {
                        cylinder(d=actuator_guard_insert_od,
                                 h=actuator_guard_insert_l,center=true);
                        cylinder(d=actuator_guard_fastener_d,
                                 h=actuator_guard_insert_l+0.2,center=true);
                    }
}

module actuator_guard_fasteners() {
    motor_center_z = -jaw_height/2-actuator_axial_gap-actuator_body_l/2;
    guard_top_z = actuator_guard_top_z;
    guard_bottom_z = motor_center_z-actuator_body_l/2-actuator_guard_bottom_extension;
    guard_center_z = (guard_top_z+guard_bottom_z)/2;
    guard_x = jaw_gap/2+jaw_thickness/2;
    screw_zs = [guard_bottom_z+actuator_guard_screw_z_inset,
                guard_center_z,
                guard_top_z-actuator_guard_screw_z_inset];
    for (xside=[-1,1])
        for (z_abs=screw_zs) {
            color([0.68,0.71,0.74])
                translate([guard_x+xside*actuator_guard_fastener_radius_x,
                           actuator_guard_split_flange_h/2
                           -actuator_guard_fastener_head_h/2,
                           z_abs]) rotate([90,0,0])
                    cylinder(d=actuator_guard_fastener_head_d,
                             h=actuator_guard_fastener_head_h,center=true);
            color([0.68,0.71,0.74])
                translate([guard_x+xside*actuator_guard_fastener_radius_x,
                           -1.15,z_abs]) rotate([90,0,0])
                    cylinder(d=actuator_guard_fastener_d,h=5.5,center=true);
        }
}

module safety_guard() {
    // Two longitudinal shell halves split along the drive axis. Six M3
    // placeholder screws make the motor/coupler serviceable without removing
    // the pivot or opening the ROV electronics bay.
    actuator_guard_half(1);
    actuator_guard_half(-1);
}

module reference_bay_envelope() {
    // Approximate the written hull description only: 25 x 15 x 15 cm assumed,
    // with vehicle length along -Y, width along X, and height along Z. This is
    // a ghost structural frame, not a pressure housing or structural CAD; it is
    // shown only as a visual envelope; add the sealed electronics housing separately.
    if (show_reference_bay) {
        bay_l = reference_bay_assumed_cm[0]*10;
        bay_w = reference_bay_assumed_cm[1]*10;
        bay_h = reference_bay_assumed_cm[2]*10;
        bay_center_y = -bay_l/2;
        color([0.18,0.58,0.76,0.22]) {
            // Two vertical side plates and a horizontal centerline plate;
            // roof and bottom foam are intentionally omitted from this overlay.
            for (side=[-1,1])
                translate([side*(bay_w/2-reference_bay_panel_t/2),
                           bay_center_y,0])
                    cube([reference_bay_panel_t,bay_l,bay_h],center=true);
            translate([0,bay_center_y,0])
                cube([bay_w,bay_l,reference_bay_panel_t],center=true);
        }
    }
}

/* Integrated SER top-mount candidate. Local origin is the actuator output-face
   plane. Translation maps it to the existing motor-face datum so the D-shaft,
   coupler and pivot shaft stay coaxial. Local bridge z=10..14 maps to the lower
   bearing plane z=-12..-8. The widened bridge replaces the lower bearing ear;
   the upper ear remains from pivot_bearing_brackets(). Vehicle interface stays
   unverified and is not represented as a mount to the supplied body mesh. */
ser_mount_case_rotation_deg = 90;
ser_mount_top_feature_h = 5.1;
ser_mount_case_drop = 72.1;
ser_mount_plate_x = 36;
ser_mount_plate_y = 66;
ser_mount_plate_t = 3;
ser_mount_bridge_x = 48;
ser_mount_bridge_y = 40;
ser_mount_bridge_center_y = -12;
ser_mount_bridge_bottom_z = 10;
ser_mount_bridge_t = 4;
ser_mount_bridge_bore_d = 12.4;
ser_mount_post_x = 20;
ser_mount_post_y = 4;
ser_mount_post_section = [4,6];
ser_mount_plate_top_z = -ser_mount_top_feature_h+ser_mount_plate_t;
ser_mount_post_h = ser_mount_bridge_bottom_z-ser_mount_plate_top_z;
ser_mount_face_screw_clearance_d = 4;
ser_mount_face_screw_shaft_d = 3.5; // provisional self-tapping proxy for Ø2.9 blind holes
ser_mount_face_screw_head_d = 6.5;
ser_mount_face_screw_head_h = 2;
ser_mount_face_screw_l = 16; // under-head; engagement depends on plate stack
ser_mount_joint_clearance_d = 3.2;
ser_mount_joint_screw_d = 3;
ser_mount_joint_screw_l = 22; // provisional through-bolt stack length
ser_mount_joint_head_d = 5.5;
ser_mount_joint_head_h = 2.4;
ser_mount_joint_nut_af = 5.5;
ser_mount_joint_nut_h = 2.5;
ser_mount_joint_washer_d = 6;
ser_mount_joint_washer_t = 0.5;
ser_mount_guard_od = 34;
ser_mount_guard_id = 26;
assert(abs(ser_mount_case_drop-ser203x_case_below_output_face) < 0.01,
       "SER case drop must match the inline dimensional proxy");
assert(abs(ser_mount_bridge_bottom_z+actuator_motor_inner_face_z
           -(-jaw_height/2-bearing_h)) < 0.01,
       "SER bridge datum must coincide with the lower bearing plane");
assert(ser_mount_bridge_t == bearing_h,
       "SER bridge replaces one lower bearing ear only");
assert(ser_mount_guard_id > dshaft_coupler_outer_d,
       "Coupler guard bore must clear the D-shaft coupler envelope");

module ser_mount_case_local() {
    // BTE drawing envelope: 70 x 32 x 67 mm body, Ø24 x 5.1 mm output boss,
    // four Ø2.9 x 16 mm blind holes on a 35 x 22 mm pattern. Rounded corners,
    // connector, side holes and actual D-flat depth are not modeled.
    rotate([0,0,ser_mount_case_rotation_deg])
        color([0.22,0.38,0.52,0.42])
            difference() {
                hull()
                    for (x=[-32,32],y=[-13,13])
                        translate([x,y,-ser_mount_case_drop])
                            cylinder(r=3,h=67);
                for (x=[-17.5,17.5],y=[-11,11])
                    translate([x,y,-ser_mount_top_feature_h-16])
                        cylinder(d=2.9,h=16.2);
            }
    color([0.34,0.39,0.43])
        translate([0,0,-ser_mount_top_feature_h])
            cylinder(d=24,h=ser_mount_top_feature_h);
}

module ser_mount_face_plate_local() {
    difference() {
        translate([0,0,-ser_mount_top_feature_h+ser_mount_plate_t/2])
            union() {
                cube([ser_mount_plate_x,ser_mount_plate_y,ser_mount_plate_t],center=true);
                // Ears extend from x=±18 to x=±24, matching the 48 mm bridge.
                for (side=[-1,1])
                    translate([side*21,0,0])
                        cube([6,16,ser_mount_plate_t],center=true);
            }
        rotate([0,0,ser_mount_case_rotation_deg])
            for (x=[-17.5,17.5],y=[-11,11])
                translate([x,y,-ser_mount_top_feature_h+ser_mount_plate_t/2])
                    cylinder(d=ser_mount_face_screw_clearance_d,
                             h=ser_mount_plate_t+0.3,center=true);
        translate([0,0,-ser_mount_top_feature_h+ser_mount_plate_t/2])
            cylinder(d=26,h=ser_mount_plate_t+0.3,center=true);
        for (side=[-1,1],y=[-ser_mount_post_y,ser_mount_post_y])
            translate([side*ser_mount_post_x,y,
                       -ser_mount_top_feature_h+ser_mount_plate_t/2])
                cylinder(d=ser_mount_joint_clearance_d,
                         h=ser_mount_plate_t+0.3,center=true);
    }
}

module ser_mount_face_screws_local() {
    rotate([0,0,ser_mount_case_rotation_deg])
        for (x=[-17.5,17.5],y=[-11,11]) {
            color([0.70,0.72,0.75]) {
                translate([x,y,ser_mount_plate_top_z-ser_mount_face_screw_l/2])
                    cylinder(d=ser_mount_face_screw_shaft_d,
                             h=ser_mount_face_screw_l,center=true);
                translate([x,y,ser_mount_plate_top_z+ser_mount_face_screw_head_h/2])
                    cylinder(d=ser_mount_face_screw_head_d,
                             h=ser_mount_face_screw_head_h,center=true);
            }
        }
}

module ser_mount_bridge_local() {
    // Replaces the lower 32 x 40 mm bearing ear with a 48 x 40 mm bridge.
    // Its yoke fastener holes align with the existing bearing-ear pattern at
    // pivot_y-29 and pivot_y-23. The frame remains an unverified placeholder.
    difference() {
        color([0.20,0.37,0.52,0.58])
            translate([0,ser_mount_bridge_center_y,
                       ser_mount_bridge_bottom_z+ser_mount_bridge_t/2])
                cube([ser_mount_bridge_x,ser_mount_bridge_y,
                      ser_mount_bridge_t],center=true);
        translate([0,0,ser_mount_bridge_bottom_z+ser_mount_bridge_t/2])
            cylinder(d=ser_mount_bridge_bore_d,
                     h=ser_mount_bridge_t+0.3,center=true);
        for (y=[-29,-23])
            translate([0,y,ser_mount_bridge_bottom_z+ser_mount_bridge_t/2])
                cylinder(d=bearing_mount_clearance,
                         h=ser_mount_bridge_t+0.3,center=true);
        for (side=[-1,1],y=[-ser_mount_post_y,ser_mount_post_y])
            translate([side*ser_mount_post_x,y,
                       ser_mount_bridge_bottom_z+ser_mount_bridge_t/2])
                cylinder(d=ser_mount_joint_clearance_d,
                         h=ser_mount_bridge_t+0.3,center=true);
    }
    // Lower bearing sleeve replaces the lower sleeve suppressed with the ear.
    color([0.22,0.40,0.53])
        translate([0,0,ser_mount_bridge_bottom_z+ser_mount_bridge_t/2])
            difference() {
                cylinder(d=12,h=bearing_h-0.2,center=true);
                cylinder(d=pivot_shaft_d+0.2,h=bearing_h+0.2,center=true);
            }
}

module ser_mount_support_cage_local() {
    // Four posts and closed annular shield form one structural cage. The shield
    // tabs bridge to the posts; its four holes share the vertical fasteners.
    difference() {
        union() {
            for (side=[-1,1],y=[-ser_mount_post_y,ser_mount_post_y])
                translate([side*ser_mount_post_x,y,
                    (ser_mount_plate_top_z+ser_mount_bridge_bottom_z)/2])
                    cube([ser_mount_post_section[0],
                          ser_mount_post_section[1],
                          ser_mount_post_h],center=true);
            translate([0,0,(ser_mount_plate_top_z+ser_mount_bridge_bottom_z)/2])
                difference() {
                    cylinder(d=ser_mount_guard_od,
                             h=ser_mount_post_h,center=true);
                    cylinder(d=ser_mount_guard_id,
                             h=ser_mount_post_h+0.2,center=true);
                }
            for (side=[-1,1],y=[-ser_mount_post_y,ser_mount_post_y])
                translate([side*19.5,y,
                    (ser_mount_plate_top_z+ser_mount_bridge_bottom_z)/2])
                    cube([6,6,ser_mount_post_h],center=true);
        }
        for (side=[-1,1],y=[-ser_mount_post_y,ser_mount_post_y])
            translate([side*ser_mount_post_x,y,
                       (ser_mount_plate_top_z+ser_mount_bridge_bottom_z)/2])
                cylinder(d=ser_mount_joint_clearance_d,
                         h=ser_mount_post_h+0.3,center=true);
    }
}

module ser_mount_post_joint_hardware_local() {
    // M3 x 22 through-bolts and nuts are placeholders only. Confirm thread,
    // edge distances, tool access, material, corrosion and case clearance.
    screw_center_z=ser_mount_bridge_bottom_z+ser_mount_bridge_t
        -ser_mount_joint_screw_l/2;
    for (side=[-1,1],y=[-ser_mount_post_y,ser_mount_post_y]) {
        color([0.70,0.72,0.75]) {
            translate([side*ser_mount_post_x,y,screw_center_z])
                cylinder(d=ser_mount_joint_screw_d,
                         h=ser_mount_joint_screw_l,center=true);
            translate([side*ser_mount_post_x,y,
                       ser_mount_bridge_bottom_z+ser_mount_bridge_t
                       +ser_mount_joint_head_h/2])
                cylinder(d=ser_mount_joint_head_d,
                         h=ser_mount_joint_head_h,center=true);
        }
        color([0.68,0.71,0.74])
            translate([side*ser_mount_post_x,y,
                       -ser_mount_top_feature_h-ser_mount_joint_washer_t
                       -ser_mount_joint_nut_h/2])
                cylinder(d=ser_mount_joint_nut_af/cos(30),
                         h=ser_mount_joint_nut_h,$fn=6,center=true);
        color([0.72,0.74,0.76])
            translate([side*ser_mount_post_x,y,
                       -ser_mount_top_feature_h-ser_mount_joint_washer_t/2])
                difference() {
                    cylinder(d=ser_mount_joint_washer_d,
                             h=ser_mount_joint_washer_t,center=true);
                    cylinder(d=ser_mount_joint_screw_d+0.3,
                             h=ser_mount_joint_washer_t+0.2,center=true);
                }
    }
}

module ser203x_topmount_package() {
    pivot_x=jaw_gap/2+jaw_thickness/2;
    translate([pivot_x,pivot_y,actuator_motor_inner_face_z]) {
        ser_mount_case_local();
        ser_mount_face_plate_local();
        ser_mount_face_screws_local();
        ser_mount_bridge_local();
        ser_mount_support_cage_local();
        ser_mount_post_joint_hardware_local();
    }
}

module ser_mount_case_global() {
    pivot_x=jaw_gap/2+jaw_thickness/2;
    translate([pivot_x,pivot_y,actuator_motor_inner_face_z])
        ser_mount_case_local();
}

module ser_mount_structure_global() {
    pivot_x=jaw_gap/2+jaw_thickness/2;
    translate([pivot_x,pivot_y,actuator_motor_inner_face_z]) {
        ser_mount_face_plate_local();
        ser_mount_bridge_local();
        ser_mount_support_cage_local();
        ser_mount_post_joint_hardware_local();
    }
}

// Use jaw_angle_deg=0, 22, and max_jaw_angle_deg to screen the installed case
// against the moving jaw/contact assembly. This selector does not cover props,
// body, cables, deformation, tolerances, or continuous motion.
module ser_case_moving_jaw_interference() {
    intersection() {
        ser_mount_case_global();
        moving_jaw();
    }
}

// Screen fixed and rotating stop hardware plus the yoke against the mount
// structure at the currently selected jaw_angle_deg. Any expected shared
// attachment volume must be reviewed at the corresponding interface.
module ser_mount_stop_yoke_interference() {
    intersection() {
        ser_mount_structure_global();
        union() {
            support_frame();
            fixed_stop_sector();
            rotating_stop_arm();
            stop_sector_guard();
            integrated_bridge_plate();
            integrated_bridge_support();
        }
    }
}

module ser_coupler_guard_interference() {
    intersection() {
        selected_actuator_coupler_proxy();
        ser_mount_structure_global();
    }
}

// Check whether the long SER case intrudes into the yoke, adapter or retained
// stop enclosure. The face boss/plate mating interface is intentionally outside
// this selector; cable and connector envelopes are not modeled.
module ser_case_fixed_structure_interference() {
    intersection() {
        ser_mount_case_global();
        union() {
            mount_plate();
            support_frame();
            pivot_bearing_brackets();
            stop_sector_guard();
        }
    }
}

// Check the retained upper bearing ear against its matching seat in the yoke
// cheek. The lower bearing seat is covered by ser_mount_stop_yoke_interference.
module bearing_bracket_frame_interference() {
    intersection() {
        pivot_bearing_brackets();
        support_frame();
    }
}

module assembly() {
    reference_bay_envelope();
    if (show_mount_plate) color([0.73,0.80,0.85]) mount_plate();
    color([0.45,0.58,0.68]) support_frame();
    frame_mount_inserts();
    frame_mount_fasteners();
    pivot_bearing_brackets();
    ser203x_topmount_package();
    bearing_ear_inserts();
    bearing_ear_fasteners();
    integrated_bridge_plate();
    integrated_bridge_support();
    fixed_stop_sector();
    bridge_joint_fasteners();
    post_sector_fasteners();
    stop_block_fasteners();
    contact_pads();
    moving_jaw();
    pivot_through_shaft();
    pivot_axial_retention();
    rotating_stop_arm();
    integrated_upper_fork_retention();
    stop_sector_guard();
    selected_actuator_coupler_proxy();

    actuator_output_shaft_proxy();

}

module jaw_frame_overlap() {
    // Export shared volume between the moving jaw body and fixed support frame.
    // An empty mesh indicates no modeled overlap at this pose; it does not cover
    // pads, retainers, props, body, tolerance, deformation, or powered loads.
    intersection() {
        moving_jaw_body_only();
        support_frame();
    }
}

module pad_overlap() {
    // Isolate the two replaceable contact inserts to keep the pose check small.
    intersection() {
        moving_pad_only();
        fixed_pad_only();
    }
}

module actuator_package() {
    ser203x_topmount_package();
    selected_actuator_coupler_proxy();
    actuator_output_shaft_proxy();
}

if (part_view == "assembly") assembly();
else if (part_view == "adapter_plate") mount_plate();
else if (part_view == "support_yoke") support_frame();
else if (part_view == "bearing_set") {
    pivot_bearing_brackets();
    bearing_ear_inserts();
    bearing_ear_fasteners();
}
else if (part_view == "fixed_contact") contact_pads();
else if (part_view == "fixed_pad_only") fixed_pad_only();
else if (part_view == "fixed_keeper_strips_only") fixed_keeper_strips_only();
else if (part_view == "fixed_keeper_fasteners_only") fixed_keeper_fasteners_only();
else if (part_view == "fixed_pad_thread_inserts_only") fixed_pad_thread_inserts_only();
else if (part_view == "pad_coupon") pad_insert(1);
else if (part_view == "pad_coupon_pair") pad_coupon_pair();
else if (part_view == "pad_retention_coupon") pad_retention_coupon();
else if (part_view == "pad_retention_coupon_body_only") pad_retention_coupon_body_only();
else if (part_view == "pad_retention_coupon_pad_only") pad_retention_coupon_pad_only();
else if (part_view == "pad_retention_coupon_keepers_only") pad_retention_coupon_keepers_only();
else if (part_view == "jaw_assembly") moving_jaw();
else if (part_view == "moving_jaw_body_only") moving_jaw_body_only();
else if (part_view == "moving_pad_only") moving_pad_only();
else if (part_view == "moving_keeper_strips_only") moving_keeper_strips_only();
else if (part_view == "moving_keeper_fasteners_only") moving_keeper_fasteners_only();
else if (part_view == "moving_pad_thread_inserts_only") moving_pad_thread_inserts_only();
else if (part_view == "jaw_frame_overlap") jaw_frame_overlap();
else if (part_view == "pad_overlap") pad_overlap();
else if (part_view == "pivot_shaft") pivot_through_shaft();
else if (part_view == "axial_retention") pivot_axial_retention();
else if (part_view == "actuator_reaction_mount") {
    ser203x_topmount_package();
    pivot_bearing_brackets();
}
else if (part_view == "stop_sector") fixed_stop_sector();
else if (part_view == "rotating_stop") rotating_stop_arm();
else if (part_view == "stop_guard") stop_sector_guard();
else if (part_view == "stop_guard_enclosure_only") stop_guard_enclosure_only();
else if (part_view == "stop_guard_shell_print") stop_guard_shell_print();
else if (part_view == "stop_guard_floor_left_print") stop_guard_floor_panel_print(-1);
else if (part_view == "stop_guard_floor_right_print") stop_guard_floor_panel_print(1);
else if (part_view == "stop_guard_lid_print") stop_guard_lid_print();
else if (part_view == "stop_guard_hardware_proxy") stop_guard_hardware_proxy();
else if (part_view == "stop_guard_enclosure_clearance") stop_guard_enclosure_clearance();
else if (part_view == "stop_guard_clearance_samples") stop_guard_enclosure_clearance_samples();
else if (part_view == "stop_guard_floor_structure_clearance") stop_guard_lower_floor_structure_clearance();
else if (part_view == "stop_guard_shell_floor_clearance") stop_guard_shell_floor_clearance();
else if (part_view == "stop_guard_floor_vs_support") stop_guard_lower_floor_clearance_vs("support");
else if (part_view == "stop_guard_floor_vs_bearing") stop_guard_lower_floor_clearance_vs("bearing");
else if (part_view == "stop_guard_floor_vs_actuator") stop_guard_lower_floor_clearance_vs("actuator");
else if (part_view == "stop_guard_floor_vs_bridge") stop_guard_lower_floor_clearance_vs("bridge");
else if (part_view == "stop_guard_floor_vs_shaft") stop_guard_lower_floor_clearance_vs("shaft");
else if (part_view == "stop_guard_wall_vs_support") stop_guard_wall_support_clearance();
else if (part_view == "stop_guard_access_diagnostic") stop_guard_access_diagnostic();
else if (part_view == "integrated_bridge") { integrated_bridge_plate(); integrated_bridge_support(); }
else if (part_view == "actuator_dshaft_coupler") { dshaft_coupler_proxy(); actuator_output_shaft_proxy(); }
else if (part_view == "bridge_joint_fasteners") bridge_joint_fasteners();
else if (part_view == "post_sector_fasteners") { post_sector_fasteners(); integrated_bridge_support(); }
else if (part_view == "stop_block_fasteners") { stop_block_fasteners(); fixed_stop_sector(); }
// Empty intersections indicate the rotating stop does not overlap these fastener proxies
// at the sampled pose; they do not verify endpoint stop contact or dynamic clearance.
else if (part_view == "rotating_stop_bridge_fasteners_overlap") intersection() { rotating_stop_arm(); bridge_joint_fasteners(); }
else if (part_view == "rotating_stop_post_fasteners_overlap") intersection() { rotating_stop_arm(); post_sector_fasteners(); }
else if (part_view == "rotating_stop_block_fasteners_overlap") intersection() { rotating_stop_arm(); stop_block_fasteners(); }
else if (part_view == "integrated_stop_clearance") integrated_stop_overlap_diagnostics();
else if (part_view == "stop_sector_fork_overlap") intersection() { fixed_stop_sector(); rotating_stop_arm(); }
else if (part_view == "stop_bridge_fork_overlap") intersection() { integrated_bridge_support(); rotating_stop_arm(); }
else if (part_view == "stop_guard_overlap") intersection() { stop_sector_guard(); rotating_stop_arm(); }
else if (part_view == "stop_bridge_plate_fork_overlap") intersection() { integrated_bridge_plate(); rotating_stop_arm(); }
else if (part_view == "actuator_package") actuator_package();
else if (part_view == "ser_case_moving_jaw_interference") ser_case_moving_jaw_interference();
else if (part_view == "ser_mount_stop_yoke_interference") ser_mount_stop_yoke_interference();
else if (part_view == "ser_coupler_guard_interference") ser_coupler_guard_interference();
else if (part_view == "ser_case_fixed_structure_interference") ser_case_fixed_structure_interference();
else if (part_view == "bearing_bracket_frame_interference") bearing_bracket_frame_interference();

