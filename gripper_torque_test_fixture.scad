/*
  Bench-only torque lever and extended pivot shaft for gripper_study.scad.

  Coordinates follow the current study stack: jaw center z=0, 16 mm jaw,
  4 mm bearing ears, upper stop-sector plate from z=14.5 to 17.0 mm. The
  lever sits above that plate and replaces the production rotating stop arm,
  actuator, and drive guard during passive bench measurements.

  The test shaft retains the current bearing-retainer groove positions and
  adds an upper groove/washer/retaining-ring stack above the lever. Confirm
  these proxy dimensions against selected commercial hardware before machining.
  Install the extended shaft through the actual passive yoke/jaw stack and
  secure the yoke to a bench reaction fixture before applying force.

  The lever load point is 100 mm from the 8 mm D-shaft axis. Apply force
  perpendicular to the lever at the anchor hole and calculate T = F * r.
  At r = 0.100 m, 10 N gives 1 N*m.

  This is a geometry reference, not a load-rated fixture. FDM printing is for
  fit checks and low-force setup only. Machine the lever/hub and shaft from
  suitable material for actual force measurements, secure the bench rig, and
  stay within a controlled load limit. Do not attach this fixture to the ROV.
*/

$fn = 64;

shaft_d = 8;
shaft_flat_x = 3;
shaft_bore_clearance = 0.2;
lever_hub_od = 18;
lever_hub_h = 12;
lever_arm_radius = 100; // force-gauge anchor center radius
lever_arm_width = 12;
lever_arm_t = 6;
anchor_hole_d = 5.2;
set_screw_pilot_d = 2.5; // M3 tap drill; grub-screw proxy shown in assembly
test_shaft_bottom_z = -17;
test_shaft_top_z = 32.2;
test_shaft_l = test_shaft_top_z-test_shaft_bottom_z;
retainer_groove_d = 7.6; // Rotor Clip DSH-8 DIN 471 reference; verify selected ring/material
retainer_groove_w = 0.9; // DSH-8 minimum reference; use selected vendor tolerance
retainer_ring_od = 11;
retainer_ring_t = 0.8;
thrust_washer_od = 12;
thrust_washer_id = shaft_d+0.2;
thrust_washer_t = 0.5;
upper_retainer_groove_z = 31;
jaw_h = 16;
bearing_h = 4;
upper_bearing_face_z = jaw_h/2+bearing_h;
upper_ring_groove_z = upper_bearing_face_z+0.5+0.2+retainer_ring_t/2;
lower_ring_groove_z = -upper_ring_groove_z;
stop_plate_top_z = 17;
lever_bottom_z = stop_plate_top_z+1;
lever_center_z = lever_bottom_z+lever_hub_h/2;
lever_top_z = lever_bottom_z+lever_hub_h;
upper_washer_z = lever_top_z+thrust_washer_t/2;
part_view = "assembly"; // [assembly,lever,test_shaft,retainers]

module d_bore(d, flat_x, h) {
    difference() {
        cylinder(d=d, h=h, center=true);
        translate([flat_x+5,0,0]) cube([10,10,h+0.2], center=true);
    }
}

module torque_lever() {
    // The M3 pilot opens on +Y, with its entry at x=-1 clear of the +X arm.
    set_screw_x = -1.5;
    set_screw_start_y = shaft_d/2-0.2;
    set_screw_len = lever_hub_od/2-set_screw_start_y+0.2;
    difference() {
        union() {
            cylinder(d=lever_hub_od, h=lever_hub_h, center=true);
            translate([lever_arm_radius/2,0,0])
                cube([lever_arm_radius,lever_arm_width,lever_arm_t], center=true);
        }
        d_bore(shaft_d+shaft_bore_clearance,
               shaft_flat_x+shaft_bore_clearance,lever_hub_h+0.2);
        translate([lever_arm_radius,0,0])
            cylinder(d=anchor_hole_d,h=lever_arm_t+0.2,center=true);
        // Blind radial pilot contacts the round shaft; the D-bore keys torque.
        translate([set_screw_x,set_screw_start_y+set_screw_len/2,0])
            rotate([90,0,0]) cylinder(d=set_screw_pilot_d,
                                      h=set_screw_len,center=true);
    }
}

module extended_test_shaft() {
    shaft_center_z = (test_shaft_bottom_z+test_shaft_top_z)/2;
    difference() {
        translate([0,0,shaft_center_z])
            cylinder(d=shaft_d,h=test_shaft_l,center=true);
        // Bearing-retainer grooves match the current study's nominal z stack.
        for (z=[lower_ring_groove_z,upper_ring_groove_z,
                upper_retainer_groove_z])
            translate([0,0,z])
                cylinder(d=retainer_groove_d,h=retainer_groove_w,center=true);
        // D-flat through the moving jaw hub and test-lever hub only.
        for (span=[[-jaw_h/2,jaw_h/2],
                   [lever_bottom_z,lever_top_z]]) {
            translate([shaft_flat_x+5,0,(span[0]+span[1])/2])
                cube([10,10,span[1]-span[0]],center=true);
        }
    }
}

module retaining_ring(z) {
    color([0.83,0.68,0.35])
        translate([0,0,z])
            difference() {
                cylinder(d=retainer_ring_od,h=retainer_ring_t,center=true);
                cylinder(d=retainer_groove_d,h=retainer_ring_t+0.2,center=true);
                translate([retainer_ring_od/2,0,0])
                    cube([retainer_ring_od,1,retainer_ring_t+0.2],center=true);
            }
}

module thrust_washer(z) {
    color([0.68,0.74,0.78])
        translate([0,0,z])
            difference() {
                cylinder(d=thrust_washer_od,h=thrust_washer_t,center=true);
                cylinder(d=thrust_washer_id,h=thrust_washer_t+0.2,center=true);
            }
}

module grub_screw_proxy() {
    // M3 x 6 schematic set screw, entering from +Y into the lever hub.
    color([0.62,0.66,0.69])
        translate([-1.5,6.5,lever_center_z])
            rotate([90,0,0]) cylinder(d=3,h=6,center=true);
}

module retainer_set() {
    thrust_washer(upper_bearing_face_z+0.25);
    retaining_ring(upper_ring_groove_z);
    thrust_washer(-upper_bearing_face_z-0.25);
    retaining_ring(lower_ring_groove_z);
    thrust_washer(upper_washer_z);
    retaining_ring(upper_retainer_groove_z);
}

module fixture_accessory() {
    color([0.70,0.73,0.76]) extended_test_shaft();
    retainer_set();
    color([0.25,0.52,0.72])
        translate([0,0,lever_center_z]) torque_lever();
    grub_screw_proxy();
}

if (part_view == "assembly") fixture_accessory();
else if (part_view == "lever") torque_lever();
else if (part_view == "test_shaft") extended_test_shaft();
else if (part_view == "retainers") retainer_set();
