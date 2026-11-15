/*
  Replaceable hard-stop architecture layout for the PolyU MATE ROV jaw.

  This is an unpowered packaging study only. It illustrates a fixed annular
  sector with separate stop blocks and a moving double-supported cross-pin.
  The pin, clearances, support spacing, fasteners, material, and load path are
  not selected or rated. Do not use this model as a powered stop or print it
  as a load-bearing component. Integrate and resize only after actuator peak
  torque, impact case, yoke geometry, manufacturing process, and prop loads
  are known. See powered_stop_prototype_module.md.

  Preview controls:
    jaw_angle_deg : display pose between the illustrative stop faces
    part_view     : assembly, fixed_sector, moving_fork, pin, stop_blocks
*/

$fn = 64;

// Display-only envelopes; no structural ratings are implied.
pivot_shaft_d = 8.5;
sector_id = 20;
sector_od = 64;
sector_t = 3;
sector_center_z = -3;
stop_radius = 23;
stop_pin_d = 8;
stop_pin_length = 21;
fork_cheek_t = 3;
fork_cheek_gap = 9;
fork_reach_w = 7;
fork_boss_d = 16;
stop_block_radial = 17;
stop_block_tangent = 4.5;
stop_block_height = 3;
stop_open_deg = 8;
stop_close_deg = 52;
jaw_angle_deg = 30;
stop_contact_angle_offset_deg = asin(
    (stop_pin_d/2+stop_block_tangent/2)/stop_radius);
stop_block_open_deg = stop_open_deg-stop_contact_angle_offset_deg;
stop_block_close_deg = stop_close_deg+stop_contact_angle_offset_deg;
fork_axial_clearance = 1.5;
sector_bottom_z = sector_center_z-sector_t/2;
sector_top_z = sector_center_z+sector_t/2;
block_top_z = stop_block_height/2;
fork_lower_center_z = sector_bottom_z-fork_axial_clearance-fork_cheek_t/2;
fork_upper_center_z = block_top_z+fork_axial_clearance+fork_cheek_t/2;
part_view = "assembly"; // [assembly,fixed_sector,moving_fork,pin,stop_blocks]

PI = 3.141592653589793;
function sind(a) = sin(a);
function cosd(a) = cos(a);
actual_clevis_clear_gap = fork_upper_center_z-fork_cheek_t/2
    -(fork_lower_center_z+fork_cheek_t/2);
echo(str("Conceptual clevis clear gap between cheeks: ",
         actual_clevis_clear_gap," mm (layout only)"));
echo(str("Block center offset from nominal contact pose: ",
         stop_contact_angle_offset_deg," degrees (layout only)"));
if (abs(actual_clevis_clear_gap-fork_cheek_gap)>0.01)
    echo(str("LAYOUT WARNING: derived clevis gap differs from target ",
             fork_cheek_gap," mm"));

module fixed_sector() {
    difference() {
        union() {
            translate([0,0,sector_center_z])
                cylinder(d=sector_od, h=sector_t, center=true);
            // Four flat mounting ears suggest attachment to a structural yoke.
            for (a=[0:90:270])
                rotate([0,0,a])
                    translate([sector_od/2-2,0,sector_center_z])
                        cube([12,14,sector_t], center=true);
        }
        translate([0,0,sector_center_z])
            cylinder(d=sector_id, h=sector_t+0.4, center=true);
        for (a=[0:90:270])
            rotate([0,0,a])
                translate([sector_od/2+2,0,0])
                    translate([0,0,sector_center_z])
                        cylinder(d=5.2,h=sector_t+0.4,center=true);
        // Counterbores for a keyed seat and vertical retaining bolt at each stop.
        for (a=[stop_block_open_deg,stop_block_close_deg])
            rotate([0,0,a]) {
                translate([stop_radius-7.5,0,sector_center_z])
                    cylinder(d=3.2,h=sector_t+0.4,center=true);
                translate([stop_radius-1.5,0,
                           sector_center_z+sector_t/2-0.5])
                    cube([4.2,4.2,1.2],center=true);
            }
    }
}

module one_stop_block(angle_deg) {
    rotate([0,0,angle_deg])
        translate([stop_radius,0,0]) {
            color([0.9,0.48,0.12])
                difference() {
                    union() {
                        cube([stop_block_radial,stop_block_tangent,
                              stop_block_height],center=true);
                        // Shallow key transfers tangential reaction into the sector.
                        translate([-1.5,0,-stop_block_height/2-0.5])
                            cube([4,4,1],center=true);
                    }
                    translate([-7.5,0,0])
                        cylinder(d=3.2,h=sector_t+stop_block_height+0.4,
                                 center=true);
                }
            // One retaining-bolt proxy; the key blocks rotation in this layout study.
            color([0.55,0.55,0.58])
                translate([-7.5,0,sector_center_z+stop_block_height/2])
                    cylinder(d=3,h=sector_t+stop_block_height,center=true);
            color([0.72,0.73,0.75])
                translate([-7.5,0,block_top_z+0.6])
                    cylinder(d=5.5,h=1.2,center=true);
        }
}

module stop_blocks() {
    one_stop_block(stop_block_open_deg);
    one_stop_block(stop_block_close_deg);
}

module fixed_sector_assembly() {
    color([0.34,0.39,0.43]) fixed_sector();
    stop_blocks();
}

module fork_cheek(z_center) {
    difference() {
        union() {
            hull() {
                translate([0,0,z_center])
                    cylinder(d=fork_boss_d,h=fork_cheek_t,center=true);
                rotate([0,0,jaw_angle_deg])
                    translate([stop_radius,0,z_center])
                        cylinder(d=stop_pin_d+4,h=fork_cheek_t,center=true);
            }
        }
        translate([0,0,z_center])
            cylinder(d=pivot_shaft_d+0.4,h=fork_cheek_t+0.4,center=true);
        rotate([0,0,jaw_angle_deg])
            translate([stop_radius,0,z_center])
                cylinder(d=stop_pin_d+0.5,h=fork_cheek_t+0.4,center=true);
    }
}

module moving_fork() {
    hub_center_z = (fork_upper_center_z+fork_lower_center_z)/2;
    hub_height = fork_upper_center_z-fork_lower_center_z+fork_cheek_t;
    color([0.2,0.48,0.68]) {
        fork_cheek(fork_upper_center_z);
        fork_cheek(fork_lower_center_z);
        // Both cheeks join at the pivot hub, inside the sector's clear bore.
        difference() {
            translate([0,0,hub_center_z])
                cylinder(d=fork_boss_d,h=hub_height,center=true);
            translate([0,0,hub_center_z])
                cylinder(d=pivot_shaft_d+0.4,h=hub_height+0.4,
                         center=true);
        }
    }
}

module retained_pin() {
    z_shift = -1.5;
    color([0.78,0.79,0.81])
        rotate([0,0,jaw_angle_deg])
            translate([stop_radius,0,z_shift]) {
                cylinder(d=stop_pin_d,h=stop_pin_length,center=true);
                // Simplified removable-head envelopes; choose real hardware later.
                for (z=[-9,9])
                    translate([0,0,z]) cylinder(d=stop_pin_d+4,h=2,center=true);
            }
}

module assembly() {
    fixed_sector_assembly();
    moving_fork();
    retained_pin();
    // Visual reference for pivot axis; not a shaft drawing.
    color([0.14,0.16,0.18,0.45])
        cylinder(d=pivot_shaft_d,h=25,center=true);
}

if (part_view=="assembly") assembly();
else if (part_view=="fixed_sector") fixed_sector_assembly();
else if (part_view=="moving_fork") moving_fork();
else if (part_view=="pin") retained_pin();
else if (part_view=="stop_blocks") stop_blocks();
else assembly();
