/*
  Two-axis-convention tilt mount concept for the supplied clamp STL.
  Units: millimetres. The clamp is a mesh reference; this is not a print-ready assembly.

  Coordinate assumption from the STL bounds:
    X = clamp width, Y = front/back depth, Z = upright height.
  The hinge axis runs along X, allowing the clamp to pitch in the Y-Z plane.
  Positive/negative tilt is controlled with tilt_angle_deg.

  The saddle plate and its hole pattern are adjustable placeholders. Confirm the
  clamp's real mounting face and fastener locations before making mating parts.
*/

$fn = 48;

// Reference STL bounds measured from its binary mesh.
ref_min = [-96.26535, -38.0, -14.19218];
ref_max = [49.26962, 14.44486, 175.67841];
ref_center = [(ref_min[0]+ref_max[0])/2,
              (ref_min[1]+ref_max[1])/2,
              (ref_min[2]+ref_max[2])/2];
ref_origin = [-ref_center[0], -ref_center[1], -ref_center[2]];
ref_width = ref_max[0]-ref_min[0];
ref_depth = ref_max[1]-ref_min[1];
ref_height = ref_max[2]-ref_min[2];

// Motion and hinge
tilt_angle_deg = 0;       // [-30:1:30] set to preview tilt up/down
tilt_limit_deg = 30;      // travel range for the concept
angle_preview = min(tilt_limit_deg, max(-tilt_limit_deg, tilt_angle_deg));
pivot_z = -ref_height/2 + 18; // 18 mm above the lower STL bound
pivot_y = 0;
shaft_d = 10;             // illustrative pivot shaft; choose from load calculations
bearing_od = 20;
bearing_length = 10;
side_clearance = 3;

// Adjustable clamp-to-cradle interface (must match the real clamp)
saddle_w = ref_width - 12;
saddle_h = 132;
saddle_t = 8;
saddle_center_z = 2;
saddle_y = -ref_depth/2 - saddle_t/2;
mount_hole_d = 5.5;
mount_pitch_x = 90;
mount_pitch_z = 90;
mount_edge_margin_z = 18;

// Stationary support frame and mounting plate
frame_w = ref_width + 2*side_clearance + 2*14;
frame_depth = 78;
frame_t = 8;
cheek_t = 8;
cheek_y = -ref_depth/2 - 10;
base_t = 8;
base_w = frame_w + 20;
base_depth = 104;
base_z = pivot_z - 27;
cheek_top_z = pivot_z + 84;
frame_mount_hole_d = 5.5;
frame_mount_pitch_x = base_w - 28;
frame_mount_pitch_y = base_depth - 28;

// Side-mounted rotary actuator envelope only; no actuator is selected.
show_actuator_proxy = true;
actuator_size = [38, 42, 58];
actuator_offset_x = frame_w/2 + 18;
drive_hub_d = 22;
drive_hub_length = 14;

part_view = "assembly"; // [assembly, clamp_reference, moving_cradle, stationary_frame]

module x_cylinder(length, diameter) {
    rotate([0,90,0]) cylinder(h=length, d=diameter, center=true);
}

module saddle_plate() {
    // Plate lies behind the reference clamp. Hole locations are intentionally editable.
    difference() {
        translate([0, saddle_y, saddle_center_z])
            cube([saddle_w, saddle_t, saddle_h], center=true);
        for (x=[-mount_pitch_x/2, mount_pitch_x/2])
            for (z=[saddle_center_z-mount_pitch_z/2,
                    saddle_center_z+mount_pitch_z/2])
                translate([x, saddle_y, z])
                    rotate([90,0,0]) cylinder(h=saddle_t+1, d=mount_hole_d, center=true);
    }
}

module moving_cradle() {
    // Normalized STL is rotated with the cradle about the horizontal X hinge.
    translate([0,pivot_y,pivot_z])
        rotate([angle_preview,0,0])
            translate([0,-pivot_y,-pivot_z]) {
                translate(ref_origin)
                    import("Michelangelo Dealberti FInal Clamp Design.stl", convexity=10);
                saddle_plate();

                // Rear-side ribs tie the saddle plate to both pivot bosses.
                for (sx=[-1,1]) {
                    hull() {
                        translate([sx*(saddle_w/2-7), saddle_y, saddle_center_z-saddle_h/2+5])
                            cube([14,saddle_t,14], center=true);
                        translate([sx*(saddle_w/2-7), saddle_y, pivot_z+4])
                            cube([14,saddle_t,14], center=true);
                    }
                    // Rear-to-axis arm closes the path from the saddle ribs to the trunnions.
                    hull() {
                        translate([sx*(saddle_w/2-7), saddle_y, pivot_z])
                            cube([14,saddle_t,14], center=true);
                        translate([sx*(frame_w/2-cheek_t/2-side_clearance), pivot_y, pivot_z])
                            cube([14,14,14], center=true);
                    }
                    translate([sx*(frame_w/2-cheek_t/2-side_clearance), pivot_y, pivot_z])
                        x_cylinder(26, bearing_od-2);
                }

                // Output hub proxy couples the moving trunnion to a coaxial rotary drive.
                // The actuator spline/key and retention details are intentionally omitted.
                translate([frame_w/2+12, pivot_y, pivot_z])
                    x_cylinder(drive_hub_length, drive_hub_d);
            }
}

module fixed_frame() {
    // Vehicle-side base plate; hole pattern is a generic starting point.
    difference() {
        translate([0,cheek_y,base_z]) cube([base_w,base_depth,base_t], center=true);
        for (x=[-frame_mount_pitch_x/2, frame_mount_pitch_x/2])
            for (y=[cheek_y-frame_mount_pitch_y/2, cheek_y+frame_mount_pitch_y/2])
                translate([x,y,base_z]) cylinder(h=base_t+1,d=frame_mount_hole_d,center=true);
    }

    // Two cheeks with through-bearings carry the X-axis trunnions.
    for (sx=[-1,1]) {
        x = sx*(frame_w/2-cheek_t/2-side_clearance);
        difference() {
            translate([x,cheek_y, (base_z+base_t/2+cheek_top_z)/2])
                cube([cheek_t,frame_depth,cheek_top_z-(base_z+base_t/2)],center=true);
            translate([x,pivot_y,pivot_z]) x_cylinder(cheek_t+1,bearing_od+0.5);
        }
        translate([x,pivot_y,pivot_z]) x_cylinder(cheek_t,bearing_od);
    }

    // Fixed actuator reaction plate with a clearance opening around the output hub.
    difference() {
        translate([frame_w/2+5,cheek_y,pivot_z]) cube([4,58,72],center=true);
        translate([frame_w/2+5,cheek_y,pivot_z]) x_cylinder(5,drive_hub_d+3);
    }

    // Generic mount tabs for attaching the frame to a vehicle crossbar/plate.
    for (sx=[-1,1])
        translate([sx*(base_w/2-12), cheek_y+base_depth/2-10, base_z+base_t/2+4])
            cube([24,20,8],center=true);

    if (show_actuator_proxy)
        %translate([actuator_offset_x,cheek_y,pivot_z])
            cube(actuator_size,center=true);
}

module assembly() {
    color([0.76,0.78,0.82]) fixed_frame();
    color([0.18,0.56,0.82]) moving_cradle();
}

if (part_view == "assembly") assembly();
if (part_view == "clamp_reference")
    translate(ref_origin) import("Michelangelo Dealberti FInal Clamp Design.stl", convexity=10);
if (part_view == "moving_cradle") moving_cradle();
if (part_view == "stationary_frame") fixed_frame();

