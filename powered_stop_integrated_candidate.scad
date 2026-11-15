/*
  Integrated replacement-stop packaging candidate for gripper_study.scad.

  Status: unpowered geometry concept only. This file does not replace or alter
  the main gripper source. No pin, block, bridge, yoke, bearing, actuator,
  coupling, fastener or material is sized or load-rated. Do not power this
  candidate or use it as a fabrication release.

  Geometry in this file is pivot-local (pivot axis at [0,0,0]).
  Coordinate mapping copied from the current study:
    pivot axis in the main vehicle/tool model = [jaw_gap/2 + jaw_thickness/2,
                  support_depth + pivot_forward_offset, 0] = [27,59,0] mm.
    jaw hub = z -8..+8 mm; upper bearing = z +8..+12 mm.

  Candidate change: replace the thin slotted disk/single printed pin with a
  fixed annular stop sector and captured stop blocks, plus a moving fork with
  a vertical pin supported by two cheeks. The fork rotates with the D-profile
  shaft; a longer shaft extension and upper retainer are proposed packaging
  changes. The guard/yoke still need redesign before any integration claim.

  Diagnostic views: assembly, assembly_world, stack, sector, fork, bridge,
  guard_envelope, sector_fork_overlap, sector_plate_fork_overlap,
  bridge_fork_overlap, fork_shaft_overlap.
*/

$fn = 64;

// Current main-study pivot datum inputs (millimetres).
jaw_gap = 42;
jaw_thickness = 12;
support_depth = 39;
pivot_forward_offset = 20;
jaw_height = 16;
pivot_shaft_d = 8;
bearing_h = 4;
max_jaw_angle_deg = 44;
main_shaft_top_z = jaw_height/2+bearing_h+12.5;
upper_retainer_washer_t = 0.5;
upper_retainer_endplay = 0.2;
upper_retainer_ring_t = 0.8;

pivot_x = jaw_gap/2 + jaw_thickness/2;
pivot_y = support_depth + pivot_forward_offset;

// Packaging choices only; pin/block/support dimensions require load sizing.
sector_id = 24;
sector_od = 64;
sector_t = 4;
sector_center_z = 20;
sector_bottom_z = sector_center_z-sector_t/2;
sector_top_z = sector_center_z+sector_t/2;

stop_radius = 23;
stop_pin_d = 8;
stop_pin_head_d = 12;
fork_cheek_t = 3;
fork_boss_d = 20;
pivot_shaft_flat_x = 3;
fork_shaft_clearance = 0.4;
fork_shaft_flat_x = pivot_shaft_flat_x+0.2;
fork_lower_center_z = 16;
fork_upper_center_z = 27;
fork_pin_length = fork_upper_center_z-fork_lower_center_z+fork_cheek_t;
fork_pin_center_z = (fork_upper_center_z+fork_lower_center_z)/2;
upper_retainer_ring_z = fork_upper_center_z+fork_cheek_t/2
    +upper_retainer_washer_t+upper_retainer_endplay+upper_retainer_ring_t/2;
candidate_shaft_top_z = upper_retainer_ring_z+upper_retainer_ring_t/2+1;
candidate_shaft_extension_delta = candidate_shaft_top_z-main_shaft_top_z;
fork_clearance = 1.0;

block_radial = 17;
block_tangent = 9;
block_height = 2.5;
block_angles = [0,max_jaw_angle_deg];
pin_contact_offset_deg = asin((stop_pin_d/2+block_tangent/2)/stop_radius);
block_angles_adjusted = [block_angles[0]-pin_contact_offset_deg,
                         block_angles[1]+pin_contact_offset_deg];
block_fastener_radius = stop_radius-block_radial/2+3;
sector_slot_clearance = 0.8;
sector_slot_inner_r = stop_radius-(stop_pin_d+sector_slot_clearance)/2;
sector_slot_outer_r = stop_radius+(stop_pin_d+sector_slot_clearance)/2;
sector_slot_angle_margin_deg = asin(
    (stop_pin_d/2+sector_slot_clearance/2)/sector_slot_inner_r);
sector_slot_start_deg = -sector_slot_angle_margin_deg;
sector_slot_end_deg = max_jaw_angle_deg+sector_slot_angle_margin_deg;

// The support landing pads stay outside the jaw's nominal swept pin radius.
// They model a NEW yoke bridge, not the existing bearing-bracket screw pattern.
bridge_r = 36;
bridge_boss_d = 8;
bridge_boss_h = sector_bottom_z-12.5;
bridge_boss_angles = [100,150,210,260];
bridge_foot_d = 10;
bridge_foot_h = 3;
bridge_mount_hole_d = 4.2; // placeholder; no host fastener selected
bridge_foot_radial_gap_mm = bridge_r-bridge_foot_d/2
    -(stop_radius+stop_pin_d/2);

// A clear inspection ring envelope. The true guard needs a swept radial
// window and access-path study; this cylinder is not an IP-20 guard check.
guard_id = 84;
guard_od = 92;
guard_bottom_z = 14;
guard_top_z = 33;
guard_t = (guard_od-guard_id)/2;
guard_window_angle = 62;

// Nominal axial/radial checks only. These establish a packaging gap, not fit
// with manufactured parts or a tolerance stack.
existing_retainer_top_z = 13.5;
fork_lower_bottom_z = fork_lower_center_z-fork_cheek_t/2;
fork_lower_top_z = fork_lower_center_z+fork_cheek_t/2;
fork_upper_bottom_z = fork_upper_center_z-fork_cheek_t/2;
block_top_z = sector_top_z+block_height;
hub_radial_clearance = (sector_id-fork_boss_d)/2;
bridge_to_fork_radial_clearance = bridge_r-bridge_foot_d/2
    -(stop_radius+(stop_pin_d+4)/2);

part_view = "assembly"; // [assembly,assembly_world,stack,sector,fork,bridge,guard_envelope,sector_fork_overlap,sector_plate_fork_overlap,bridge_fork_overlap,fork_shaft_overlap]
show_reference_stack = true;
show_guard_envelope = false;
jaw_angle_deg = 22;

module annulus(d1,d2,h,zc=0) {
    translate([0,0,zc]) difference() {
        cylinder(d=d1,h=h,center=true);
        cylinder(d=d2,h=h+0.2,center=true);
    }
}

module d_profile_bore(d,flat_x,h) {
    difference() {
        cylinder(d=d,h=h,center=true);
        translate([flat_x+5,0,0]) cube([10,10,h+0.2],center=true);
    }
}

function sector_slot_points(r_outer,r_inner,a_start,a_end) = concat(
    [for (a=[a_start:1:a_end]) [r_outer*cos(a),r_outer*sin(a)]],
    [for (a=[a_end:-1:a_start]) [r_inner*cos(a),r_inner*sin(a)]]
);

module sector_pin_slot() {
    translate([0,0,sector_center_z-(sector_t+0.4)/2])
        linear_extrude(height=sector_t+0.4)
            polygon(points=sector_slot_points(sector_slot_outer_r,
                        sector_slot_inner_r,sector_slot_start_deg,
                        sector_slot_end_deg));
}

module bearing_and_jaw_reference() {
    // Simplified context solids at the actual main-study axial stations.
    color([0.45,0.56,0.65])
        translate([0,0,0]) cylinder(d=16,h=jaw_height,center=true);
    for (s=[-1,1]) {
        color([0.24,0.43,0.55,0.7])
            annulus(12, pivot_shaft_d+0.2,bearing_h,
                    s*(jaw_height/2+bearing_h/2));
    }
    // Existing upper washer/retainer envelope retained below the new sector.
    color([0.7,0.72,0.75])
        annulus(12,pivot_shaft_d+0.2,0.5,12.25);
    color([0.86,0.66,0.3])
        annulus(11,pivot_shaft_d+0.2,0.8,13.1);
}

module pivot_shaft_reference() {
    // Existing upper drive-flat section extended to carry and axially retain
    // the proposed fork. Shaft material/finish and grooving remain unselected.
    shaft_bottom_z = -jaw_height/2-bearing_h;
    shaft_length = candidate_shaft_top_z-shaft_bottom_z;
    rotate([0,0,jaw_angle_deg])
        color([0.75,0.78,0.80])
            difference() {
                translate([0,0,(shaft_bottom_z+candidate_shaft_top_z)/2])
                    cylinder(d=pivot_shaft_d,h=shaft_length,center=true);
                // Match the main model's D flat through the jaw hub and
                // extended upper drive section, keeping bearing lands round.
                translate([pivot_shaft_flat_x+5,0,0])
                    cube([10,10,jaw_height],center=true);
                translate([pivot_shaft_flat_x+5,0,
                           (jaw_height/2+bearing_h
                            +candidate_shaft_top_z)/2])
                    cube([10,10,candidate_shaft_top_z
                            -(jaw_height/2+bearing_h)],center=true);
                for (groove_z=[13.1,upper_retainer_ring_z])
                    translate([0,0,groove_z])
                        cylinder(d=7.6,h=0.9,center=true);
            }
}

module upper_fork_retention_proxy() {
    // Uses the same simplified washer/ring dimensions as the existing pivot
    // study. The ring is not its full lug outline and is not load-rated.
    color([0.68,0.74,0.78])
        translate([0,0,fork_upper_center_z+fork_cheek_t/2
                       +upper_retainer_washer_t/2])
            difference() {
                cylinder(d=12,h=upper_retainer_washer_t,center=true);
                cylinder(d=pivot_shaft_d+0.2,
                         h=upper_retainer_washer_t+0.2,center=true);
            }
    color([0.83,0.68,0.35])
        translate([0,0,upper_retainer_ring_z])
            difference() {
                cylinder(d=11,h=upper_retainer_ring_t,center=true);
                cylinder(d=7.6,h=upper_retainer_ring_t+0.2,center=true);
                translate([5.5,0,0])
                    cube([11,1,upper_retainer_ring_t+0.2],center=true);
            }
}

module sector_plate() {
    difference() {
        union() {
            translate([0,0,sector_center_z])
                cylinder(d=sector_od,h=sector_t,center=true);
            // Four mounting ears for a new yoke bridge interface.
            for (a=bridge_boss_angles)
                rotate([0,0,a])
                    translate([bridge_r,0,sector_center_z])
                        cube([10,12,sector_t],center=true);
        }
        translate([0,0,sector_center_z])
            cylinder(d=sector_id,h=sector_t+0.4,center=true);
        // The pin crosses the fixed sector through this curved clearance slot.
        sector_pin_slot();
        for (a=bridge_boss_angles)
            rotate([0,0,a])
                translate([bridge_r,0,sector_center_z])
                    cylinder(d=bridge_mount_hole_d,h=sector_t+0.4,
                             center=true);
        // Block fastener holes share the mounting radius used by each block.
        for (a=block_angles_adjusted)
            rotate([0,0,a])
                translate([block_fastener_radius,0,sector_center_z])
                    cylinder(d=3.2,h=sector_t+0.4,center=true);
    }
}

module one_stop_block(a) {
    rotate([0,0,a]) translate([stop_radius,0,sector_top_z+block_height/2]) {
        color([0.9,0.42,0.12])
            difference() {
                cube([block_radial,block_tangent,block_height],center=true);
                // Retained fastener placeholder, not a selected screw.
                translate([-block_radial/2+3,0,0])
                    cylinder(d=3.2,h=block_height+0.4,center=true);
            }
    }
}

module fixed_sector() {
    color([0.42,0.52,0.61]) sector_plate();
    for (a=block_angles_adjusted) one_stop_block(a);
}

module bridge_support() {
    // Four standoffs lift the sector clear of the upper retaining-ring stack.
    // Their anchor frame has to be designed into a revised structural yoke.
    for (a=bridge_boss_angles) {
        rotate([0,0,a]) {
            color([0.34,0.46,0.55])
                translate([bridge_r,0,12.5+bridge_boss_h/2])
                    cylinder(d=bridge_boss_d,h=bridge_boss_h,center=true);
            color([0.34,0.46,0.55])
                translate([bridge_r,0,12.5-bridge_foot_h/2])
                    cylinder(d=bridge_foot_d,h=bridge_foot_h,center=true);
        }
    }
}

module fork_cheek(zc) {
    difference() {
        hull() {
            translate([0,0,zc])
                cylinder(d=fork_boss_d,h=fork_cheek_t,center=true);
            translate([stop_radius,0,zc])
                cylinder(d=stop_pin_d+4,h=fork_cheek_t,center=true);
        }
        translate([0,0,zc])
            d_profile_bore(pivot_shaft_d+fork_shaft_clearance,
                           fork_shaft_flat_x,fork_cheek_t+0.3);
        translate([stop_radius,0,zc])
            cylinder(d=stop_pin_d+0.3,h=fork_cheek_t+0.3,center=true);
    }
}

module moving_fork() {
    // Two cheeks and their hub form one rotating carrier on the keyed pivot.
    rotate([0,0,jaw_angle_deg]) {
        color([0.2,0.43,0.62]) {
            fork_cheek(fork_lower_center_z);
            fork_cheek(fork_upper_center_z);
            difference() {
                translate([0,0,(fork_lower_center_z+fork_upper_center_z)/2])
                    cylinder(d=fork_boss_d,
                             h=fork_upper_center_z-fork_lower_center_z
                               +fork_cheek_t,center=true);
                translate([0,0,(fork_lower_center_z+fork_upper_center_z)/2])
                    d_profile_bore(pivot_shaft_d+fork_shaft_clearance,
                             fork_shaft_flat_x,
                             fork_upper_center_z-fork_lower_center_z
                               +fork_cheek_t+0.3);
            }
        }
        // Retained cross-pin proxy; rotates as one with the jaw and keyed hub.
        translate([stop_radius,0,fork_pin_center_z]) {
            color([0.76,0.78,0.81])
                cylinder(d=stop_pin_d,h=fork_pin_length,center=true);
            color([0.76,0.78,0.81])
                for (s=[-1,1])
                    translate([0,0,s*(fork_pin_length/2+1)])
                        cylinder(d=stop_pin_head_d,h=2,center=true);
        }
    }
}

module fixed_yoke_reference() {
    // Abstract bearing support datum only; not a valid structural reaction model.
    color([0.33,0.4,0.46,0.65])
        // Relative to the pivot, this matches the main upper bearing ear's
        // center (y=-12 mm), but it is only a simplified non-structural proxy.
        translate([0,-12,10]) cube([32,40,4],center=true);
}

module guard_envelope() {
    // Transparent visual envelope only: leaves a large jaw sweep window.
    color([0.18,0.2,0.22,0.18])
        difference() {
            annulus(guard_od,guard_id,guard_top_z-guard_bottom_z,
                    (guard_top_z+guard_bottom_z)/2);
            // The radial opening shown is not assessed against inspection probes.
            translate([0,0,guard_bottom_z-0.5])
                linear_extrude(height=guard_top_z-guard_bottom_z+1)
                    rotate(jaw_angle_deg-guard_window_angle/2)
                        polygon(points=[[0,0],
                            [guard_od*cos(guard_window_angle),
                             guard_od*sin(guard_window_angle)],
                            [guard_od,0]]);
        }
}

module candidate_assembly() {
    if (show_reference_stack) {
        bearing_and_jaw_reference();
        fixed_yoke_reference();
    }
    pivot_shaft_reference();
    upper_fork_retention_proxy();
    bridge_support();
    fixed_sector();
    moving_fork();
    if (show_guard_envelope) guard_envelope();
}

module candidate_world_assembly() {
    // Position the pivot-local layout at the main-study pivot coordinate.
    translate([pivot_x,pivot_y,0]) candidate_assembly();
}

module stack_view() {
    bearing_and_jaw_reference();
    fixed_yoke_reference();
    pivot_shaft_reference();
    upper_fork_retention_proxy();
    bridge_support();
    fixed_sector();
    moving_fork();
}

echo(str("Candidate pivot datum [x,y] = [",pivot_x,",",pivot_y,"] mm"));
echo("Geometry is pivot-local; select assembly_world to place it in main-study coordinates");
echo(str("Main shaft top z = ",main_shaft_top_z,
         " mm; candidate shaft top z = ",candidate_shaft_top_z,
         " mm; extension change = ",candidate_shaft_extension_delta," mm"));
echo(str("Stop-sector z range = ",sector_bottom_z,"..",sector_top_z," mm"));
echo(str("Fork cheek clear space around sector = ",
         fork_upper_center_z-fork_cheek_t/2
           -(fork_lower_center_z+fork_cheek_t/2)," mm"));
echo(str("Nominal upper retainer-to-lower-cheek axial gap = ",
         fork_lower_bottom_z-existing_retainer_top_z," mm"));
echo(str("Nominal lower-cheek-to-sector gap = ",
         sector_bottom_z-fork_lower_top_z," mm"));
echo(str("Nominal stop-block-to-upper-cheek gap = ",
         fork_upper_bottom_z-block_top_z," mm"));
echo(str("Sector bore-to-moving-hub radial gap = ",
         hub_radial_clearance," mm"));
echo(str("Bridge support foot-to-fork swept radial gap = ",
         bridge_to_fork_radial_clearance," mm"));
if (fork_lower_bottom_z <= existing_retainer_top_z)
    echo("LAYOUT WARNING: lower fork cheek overlaps upper retainer envelope");
if (sector_bottom_z <= fork_lower_top_z)
    echo("LAYOUT WARNING: lower fork cheek overlaps fixed sector");
if (fork_upper_bottom_z <= block_top_z)
    echo("LAYOUT WARNING: upper fork cheek overlaps stop-block envelope");
if (hub_radial_clearance <= 0)
    echo("LAYOUT WARNING: sector bore overlaps moving hub envelope");
if (bridge_to_fork_radial_clearance <= 0)
    echo("LAYOUT WARNING: bridge support enters moving-fork swept envelope");
echo("UNPOWERED PACKAGING STUDY ONLY; no load, fit, guard, or fabrication approval");

if (part_view=="assembly") candidate_assembly();
else if (part_view=="assembly_world") candidate_world_assembly();
else if (part_view=="stack") stack_view();
else if (part_view=="sector") fixed_sector();
else if (part_view=="fork") moving_fork();
else if (part_view=="bridge") bridge_support();
else if (part_view=="guard_envelope") guard_envelope();
else if (part_view=="sector_fork_overlap")
    intersection() { fixed_sector(); moving_fork(); }
else if (part_view=="sector_plate_fork_overlap")
    intersection() { sector_plate(); moving_fork(); }
else if (part_view=="bridge_fork_overlap")
    intersection() { bridge_support(); moving_fork(); }
else if (part_view=="fork_shaft_overlap")
    intersection() { moving_fork(); pivot_shaft_reference(); }
else candidate_assembly();

