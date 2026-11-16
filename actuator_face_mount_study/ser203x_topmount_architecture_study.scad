// SER-203x/SER-213x top-face mount architecture study.
// Drawing-based interface envelope only; not vendor STEP or a load-rated release.
// Units: mm. Datum: output-shaft axis at (0,0), output-face plane z=0.

case_length = 70;
case_width = 32;
case_height = 67;
top_feature_d = 24;
top_feature_h = 5.1;
shaft_d = 6;
shaft_projection = 8;
hole_pitch_x = 35;
hole_pitch_y = 22;
hole_d = 2.9;
hole_depth = 16;
case_rotation_deg = 90; // narrow case dimension across the yoke

plate_length = 66; // long direction follows rotated case length
plate_width = 36;
plate_t = 3;
plate_ear_outer_x = 24;
plate_ear_y = 8;
plate_ear_hole_d = 3.2;
plate_bore_d = 26;

bridge_width = 48;
bridge_depth = 40;
bridge_center_y = -12; // existing lower-bearing bracket datum relative to pivot
bridge_t = 4;
bridge_bottom_z = 10;
bridge_bearing_bore_d = 12.4;
bearing_sleeve_od = 12.0;
bearing_sleeve_id = 8.4;

support_x = 20;
support_y = 4;
support_section_x = 4;
support_section_y = 6;
face_plate_top_z = -top_feature_h + plate_t; // case top is z=-5.1
support_bottom_z = face_plate_top_z;
support_top_z = bridge_bottom_z;
support_h = support_top_z-support_bottom_z;

coupler_od = 20; // placeholder pending vendor shaft and selected hub CAD
coupler_bore_d = 6.4;
coupler_bottom_z = 0;
coupler_top_z = shaft_projection;
guard_od = 34;
guard_id = 26;
guard_bottom_z = face_plate_top_z;
guard_top_z = bridge_bottom_z;

face_screw_clearance_d = 4.0;
face_screw_shaft_d = 3.5; // visual #6/M3.5 proxy
face_screw_head_d = 6.5;
face_screw_head_t = 2.0;
face_screw_total_length = 16; // provisional; manufacturer blind-hole depth is 16
bridge_yoke_hole_d = 3.2;
part_view = "assembly"; // [assembly,face_plate,bearing_bridge,bearing_stack,support_posts,coupler_guard,case_post_interference,post_guard_interference,coupler_guard_interference,plate_case_interference]

$fn = 64;

plate_corner_r = sqrt(pow(plate_length/2,2)+pow(plate_width/2,2));
bridge_min_y = bridge_center_y-bridge_depth/2;
bridge_max_y = bridge_center_y+bridge_depth/2;
assert(plate_corner_r <= 42-4,
       "Compact face plate fails the provisional same-plane Ø84 bore screen");
assert(guard_id > coupler_od && guard_od < 84,
       "Coupler guard envelope is inconsistent with the package screen");
assert(support_h > 0 && support_h <= 20,
       "Support post height is outside this packaging concept range");
assert(support_x-support_section_x/2 > case_width/2,
       "Support posts must clear the rotated SER case width");
assert(support_x-support_section_x/2 > guard_od/2,
       "Support posts must clear the coupler guard outer wall");
assert(support_x+support_section_x/2 < bridge_width/2,
       "Support posts must remain on the bearing bridge");
assert(support_y+support_section_y/2 < bridge_max_y
       && support_y-support_section_y/2 > bridge_min_y,
       "Support posts must remain on the bearing bridge");
echo(str("SER case rotation = ",case_rotation_deg,
         " degrees; 70 x 32 mm case, 67 mm tall."));
echo(str("Face plate = ",plate_width," x ",plate_length," x ",plate_t,
         " mm; corner radius ",plate_corner_r,
         " mm; provisional same-plane Ø84 bore corner margin = ",
         42-plate_corner_r," mm."));
echo(str("Support post height = ",support_h,
         " mm; case-side gap = ",support_x-support_section_x/2-case_width/2,
         " mm; guard-side gap = ",support_x-support_section_x/2-guard_od/2,
         " mm."));
echo("Mount path concept: four case top holes -> face plate -> four posts -> widened lower-bearing bridge -> yoke.");
echo("Stop impact path must remain through pivot/stop features into the yoke, independently of servo case screws.");

module ser_case() {
    rotate([0,0,case_rotation_deg])
        color([0.20,0.42,0.58,0.40])
            difference() {
                hull()
                    for (x=[-32,32],y=[-13,13])
                        translate([x,y,-case_height-top_feature_h])
                            cylinder(r=3,h=case_height);
                for (x=[-hole_pitch_x/2,hole_pitch_x/2],
                     y=[-hole_pitch_y/2,hole_pitch_y/2])
                    translate([x,y,-top_feature_h-hole_depth])
                        cylinder(d=hole_d,h=hole_depth+0.02);
            }
    color([0.34,0.39,0.43])
        translate([0,0,-top_feature_h]) cylinder(d=top_feature_d,h=top_feature_h);
}

module servo_output_and_coupler() {
    color([0.72,0.74,0.78])
        translate([0,0,shaft_projection/2])
            cylinder(d=shaft_d,h=shaft_projection,center=true);
    color([0.80,0.44,0.17,0.9])
        difference() {
            translate([0,0,(coupler_bottom_z+coupler_top_z)/2])
                cylinder(d=coupler_od,h=coupler_top_z-coupler_bottom_z,center=true);
            translate([0,0,(coupler_bottom_z+coupler_top_z)/2])
                cylinder(d=coupler_bore_d,h=coupler_top_z-coupler_bottom_z+0.2,center=true);
        }
    color([0.63,0.67,0.71])
        translate([0,0,17]) cylinder(d=8,h=20,center=true);
}

module face_mount_plate() {
    difference() {
        translate([0,0,-top_feature_h+plate_t/2])
            union() {
                cube([plate_width,plate_length,plate_t],center=true);
                for (side=[-1,1])
                    translate([side*(plate_width/2+(plate_ear_outer_x-plate_width/2)/2),0,0])
                        cube([plate_ear_outer_x-plate_width/2,2*plate_ear_y,plate_t],center=true);
            }
        // Case hole pattern rotates with the servo body.
        rotate([0,0,case_rotation_deg])
            for (x=[-hole_pitch_x/2,hole_pitch_x/2],
                 y=[-hole_pitch_y/2,hole_pitch_y/2])
                translate([x,y,-top_feature_h+plate_t/2])
                    cylinder(d=face_screw_clearance_d,h=plate_t+0.3,center=true);
        translate([0,0,-top_feature_h+plate_t/2])
            cylinder(d=plate_bore_d,h=plate_t+0.3,center=true);
        for (side=[-1,1],y=[-support_y,support_y])
            translate([side*support_x,y,-top_feature_h+plate_t/2])
                cylinder(d=plate_ear_hole_d,h=plate_t+0.3,center=true);
    }
}

module face_fasteners() {
    rotate([0,0,case_rotation_deg])
        for (x=[-hole_pitch_x/2,hole_pitch_x/2],
             y=[-hole_pitch_y/2,hole_pitch_y/2]) {
            color([0.70,0.72,0.75]) {
                translate([x,y,-top_feature_h+plate_t-face_screw_total_length/2])
                    cylinder(d=face_screw_shaft_d,h=face_screw_total_length,center=true);
                translate([x,y,-top_feature_h+plate_t+face_screw_head_t/2])
                    cylinder(d=face_screw_head_d,h=face_screw_head_t,center=true);
            }
        }
}

module support_posts() {
    for (side=[-1,1],y=[-support_y,support_y])
        color([0.62,0.47,0.24])
            translate([side*support_x,y,(support_bottom_z+support_top_z)/2])
                cube([support_section_x,support_section_y,support_h],center=true);
}

module bearing_bridge() {
    difference() {
        color([0.20,0.37,0.52,0.5])
            translate([0,bridge_center_y,bridge_bottom_z+bridge_t/2])
                cube([bridge_width,bridge_depth,bridge_t],center=true);
        translate([0,0,bridge_bottom_z+bridge_t/2])
            cylinder(d=bridge_bearing_bore_d,h=bridge_t+0.3,center=true);
        // Preserve the current two-fastener-per-ear yoke datum pattern.
        for (y=[-29,-23])
            translate([0,y,bridge_bottom_z+bridge_t/2])
                cylinder(d=bridge_yoke_hole_d,h=bridge_t+0.3,center=true);
        for (side=[-1,1],y=[-support_y,support_y])
            translate([side*support_x,y,bridge_bottom_z+bridge_t/2])
                cylinder(d=plate_ear_hole_d,h=bridge_t+0.3,center=true);
    }
}

module bearing_sleeve_and_pivot() {
    color([0.22,0.40,0.53])
        difference() {
            translate([0,0,bridge_bottom_z+bridge_t/2])
                cylinder(d=bearing_sleeve_od,h=bridge_t-0.2,center=true);
            translate([0,0,bridge_bottom_z+bridge_t/2])
                cylinder(d=bearing_sleeve_id,h=bridge_t+0.1,center=true);
        }
    color([0.70,0.72,0.75])
        translate([0,0,17]) cylinder(d=8,h=20,center=true);
}

module coupler_guard() {
    color([0.18,0.54,0.72,0.55])
        translate([0,0,(guard_bottom_z+guard_top_z)/2])
            difference() {
                cylinder(d=guard_od,h=guard_top_z-guard_bottom_z,center=true);
                cylinder(d=guard_id,h=guard_top_z-guard_bottom_z+0.2,center=true);
            }
}

module post_case_interference() { intersection() { support_posts(); ser_case(); } }
module post_guard_interference() { intersection() { support_posts(); coupler_guard(); } }
module coupler_guard_interference() { intersection() { servo_output_and_coupler(); coupler_guard(); } }
// A 0.01 mm offset avoids counting the intended plate/case mating face as volume.
module plate_case_interference() {
    intersection() { translate([0,0,0.01]) face_mount_plate(); ser_case(); }
}

module assembly() {
    ser_case();
    face_mount_plate();
    face_fasteners();
    support_posts();
    bearing_bridge();
    bearing_sleeve_and_pivot();
    servo_output_and_coupler();
    coupler_guard();
}

if (part_view=="assembly") assembly();
else if (part_view=="face_plate") face_mount_plate();
else if (part_view=="bearing_bridge") bearing_bridge();
else if (part_view=="bearing_stack") { bearing_bridge(); bearing_sleeve_and_pivot(); }
else if (part_view=="support_posts") support_posts();
else if (part_view=="coupler_guard") coupler_guard();
else if (part_view=="case_post_interference") post_case_interference();
else if (part_view=="post_guard_interference") post_guard_interference();
else if (part_view=="coupler_guard_interference") coupler_guard_interference();
else if (part_view=="plate_case_interference") plate_case_interference();
else assert(false,"Unknown part_view");

