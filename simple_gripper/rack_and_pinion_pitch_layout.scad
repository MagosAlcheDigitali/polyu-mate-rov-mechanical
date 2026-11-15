// Standalone simple-gripper drive and pitch cradle.
// Uses only the supplied clamp STL. Servo body intentionally omitted.
//
// Preview controls
tilt_angle_deg = 0;       // complete clamp and drive cradle pitch about X
rack_travel_mm = 0;       // rack and clamped center-rod travel, suggested +/-20
show_reference_mesh = true;
show_pitch_support = true;
$fn = 48;

// Approximate bounds for the supplied STL. Verify the central rod and body
// sections at the selected coupling/saddle stations before fabrication.
xmin = -96.265;
xmax = 49.270;
ymin = -38.000;
ymax = 14.445;
zmin = -14.192;
zmax = 175.678;
body_cx = (xmin+xmax)/2;
body_cy = (ymin+ymax)/2;
body_w = xmax-xmin;
body_d = ymax-ymin;

// Existing sliding rod interface. Adjust axis, diameter and coupling end to the STL.
rod_x = -22;
rod_y = -11;
existing_rod_d = 8;
coupler_z0 = zmin+8;
rod_coupler_od = 20;
rod_coupler_len = 18;
rear_sign = -1;           // -1: rack/servo at low-Z end; +1: high-Z end

// Rack drive. Rack sits beside the existing rod and clamps to it at the sleeve.
rack_length = 108;
rack_travel_limit = 20;
rack_w = 10;
rack_h = 8;
rack_x = rod_x + existing_rod_d/2 + rack_w/2 + 2;
assert(abs(rack_travel_mm)<=rack_travel_limit, "rack_travel_mm exceeds supported preview range");
rack_pitch = 4.712;       // module 1.5
tooth_depth = 3.3;
pinion_teeth = 16;
pinion_module = 1.5;
pinion_rp = pinion_module*pinion_teeth/2;
pinion_width = 10;
coupler_z = coupler_z0 + rack_travel_mm;
rack_rear_z = coupler_z0 + rear_sign*rack_length + rack_travel_mm;
rack_mid_z = (coupler_z+rack_rear_z)/2;
pinion_center = [rack_x+rack_w/2+tooth_depth+pinion_rp,
                 rod_y,
                 coupler_z0+rear_sign*rack_length*0.50];
gear_angle = -rear_sign*rack_travel_mm/pinion_rp*180/PI;
guide_z1 = coupler_z0 + rear_sign*22;
guide_z2 = coupler_z0 + rear_sign*78;

// Two-piece adjustable saddle bands clamp around the gripper body and attach
// it to the drive/pitch cradle. Set the opening dimensions to the body section
// at these stations; these are editable fit dimensions, not measured guarantees.
saddle_inner_w = body_w-8;
saddle_inner_d = body_d-8;
saddle_wall = 5;
saddle_band_t = 8;
saddle_station_1 = zmin+18;
saddle_station_2 = zmin+42;
saddle_outer_w = saddle_inner_w+2*saddle_wall;
saddle_outer_d = saddle_inner_d+2*saddle_wall;

// Cradle spine is behind the reference mesh on +Y. It carries both rack guides,
// the servo output datum and pitch trunnions so the drive tilts with the clamp.
cradle_plate_y = body_cy+saddle_outer_d/2+12;
cradle_plate_t = 6;
cradle_plate_z0 = min(coupler_z0,rack_rear_z)-20;
cradle_plate_z1 = max(zmax,saddle_station_2)+15;
cradle_plate_zc = (cradle_plate_z0+cradle_plate_z1)/2;
cradle_plate_h = cradle_plate_z1-cradle_plate_z0;
pitch_axis_z = 80;
pitch_ear_offset = saddle_outer_w/2+12;
pitch_axis_y = cradle_plate_y+16;
servo_plate_y = ymax+8;
servo_plate_t = 4;
servo_mount_hole_dx = 10;
servo_mount_hole_dz = 8;

module x_cylinder(d,h) { rotate([0,90,0]) cylinder(d=d,h=h,center=true); }
module y_cylinder(d,h) { rotate([90,0,0]) cylinder(d=d,h=h,center=true); }

module reference_clamp() {
    if (show_reference_mesh)
        color([0.72,0.75,0.79,1])
            import("../Michelangelo Dealberti FInal Clamp Design.stl", convexity=10);
}

// Separate halves let the printed band fit around the existing gripper.
// Bolts along Y join the halves and squeeze the adjustable body opening.
module saddle_half(zc, upper=true) {
    color(upper ? [0.94,0.58,0.16] : [0.88,0.42,0.12])
    difference() {
        intersection() {
            difference() {
                translate([body_cx,body_cy,zc])
                    cube([saddle_outer_w,saddle_outer_d,saddle_band_t],center=true);
                translate([body_cx,body_cy,zc])
                    cube([saddle_inner_w,saddle_inner_d,saddle_band_t+2],center=true);
            }
            translate([body_cx,body_cy+(upper?1:-1)*saddle_outer_d/4,zc])
                cube([saddle_outer_w+2,saddle_outer_d/2+1,saddle_band_t+2],center=true);
        }
        for (sx=[-1,1])
            translate([body_cx+sx*(saddle_inner_w/2+saddle_wall/2),body_cy,zc])
                y_cylinder(4.3,saddle_outer_d+2);
    }
}

module saddle_bolts(zc) {
    color([0.20,0.22,0.24])
    for (sx=[-1,1]) {
        translate([body_cx+sx*(saddle_inner_w/2+saddle_wall/2),
                   body_cy,zc])
            y_cylinder(4,saddle_outer_d+6);
        translate([body_cx+sx*(saddle_inner_w/2+saddle_wall/2),
                   body_cy+saddle_outer_d/2+1.5,zc])
            y_cylinder(7,3);
        translate([body_cx+sx*(saddle_inner_w/2+saddle_wall/2),
                   body_cy-saddle_outer_d/2-1.5,zc])
            difference() {
                rotate([90,0,0]) cylinder(d=7,h=3,center=true,$fn=6);
                y_cylinder(4.3,5);
            }
    }
}

module split_saddles() {
    for (zc=[saddle_station_1,saddle_station_2]) {
        saddle_half(zc,false);
        saddle_half(zc,true);
        saddle_bolts(zc);
    }
}

module cradle_spine() {
    color([0.30,0.33,0.37])
    union() {
        translate([body_cx,cradle_plate_y,cradle_plate_zc])
            cube([saddle_outer_w+32,cradle_plate_t,cradle_plate_h],center=true);
        for (zc=[saddle_station_1,saddle_station_2])
            translate([body_cx,(body_cy+saddle_outer_d/2+cradle_plate_y)/2,zc])
                cube([saddle_outer_w,saddle_wall+cradle_plate_t,saddle_band_t],center=true);
        // Rigid crossbar joins pitch journals to the same saddle-mounted spine.
        translate([body_cx,pitch_axis_y,pitch_axis_z])
            cube([2*pitch_ear_offset,14,16],center=true);
        for (s=[-1,1]) {
            // Side arms bridge the cradle spine to the separated pitch-yoke plane.
            translate([body_cx+s*pitch_ear_offset,
                       (cradle_plate_y+pitch_axis_y)/2,pitch_axis_z])
                cube([12,pitch_axis_y-cradle_plate_y+14,12],center=true);
            translate([body_cx+s*(pitch_ear_offset+13),pitch_axis_y,pitch_axis_z])
                x_cylinder(14,18);
        }
        // Outboard support for the pitch-link arm; it clears the gripper body.
        translate([body_cx+pitch_ear_offset-12,
                   (cradle_plate_y+pitch_axis_y)/2,pitch_axis_z])
            cube([8,pitch_axis_y-cradle_plate_y+12,8],center=true);
    }
}

module rod_coupler_and_rack() {
    rack_lo = min(coupler_z,rack_rear_z);
    rack_hi = max(coupler_z,rack_rear_z);
    color([0.16,0.35,0.70])
    union() {
        // Rack bar and teeth translate as one body.
        translate([rack_x,rod_y,rack_mid_z])
            cube([rack_w,rack_h,rack_hi-rack_lo],center=true);
        for (z=[rack_lo:rack_pitch:rack_hi])
            translate([rack_x+rack_w/2,rod_y,z])
                rotate([90,0,0])
                    linear_extrude(height=rack_h,center=true)
                        polygon(points=[[0,-rack_pitch/2],
                                        [2.2,-rack_pitch/2],
                                        [tooth_depth,0],
                                        [2.2,rack_pitch/2],
                                        [0,rack_pitch/2]]);
        // Split clamp sleeve fits over the gripper's existing center rod.
        // Two radial M3 screw holes lock it; the side arm joins the rack bar.
        translate([rod_x,rod_y,coupler_z])
        difference() {
            union() {
                cylinder(d=rod_coupler_od,h=rod_coupler_len,center=true);
                // Side web overlaps both the collar wall and rack bar, clear of the rod bore.
                translate([(rod_coupler_od/2+rack_x-rack_w/2-rod_x)/2,0,
                           -rear_sign*2])
                    cube([5,rack_h,rod_coupler_len-4],center=true);
            }
            cylinder(d=existing_rod_d+0.4,h=rod_coupler_len+2,center=true);
            for (sz=[-1,1])
                translate([0,rod_coupler_od/2-1,sz*5])
                    y_cylinder(3.2,12);
        }
        // Two modeled M3 radial screws bear on the existing rod.
        color([0.18,0.19,0.21])
        for (sz=[-1,1]) {
            translate([rod_x,rod_y+rod_coupler_od/2-3,coupler_z+sz*5])
                y_cylinder(3,8);
            translate([rod_x,rod_y+rod_coupler_od/2+0.8,coupler_z+sz*5])
                y_cylinder(5.5,1.6);
        }
    }
}

module rack_guide(zc) {
    color([0.92,0.58,0.14])
    union() {
        difference() {
            translate([rack_x,rod_y,zc]) cube([30,24,10],center=true);
            translate([rack_x+2,rod_y,zc]) cube([rack_w+7,rack_h+2,12],center=true);
        }
        translate([rack_x,(rod_y+cradle_plate_y)/2,zc])
            cube([8,cradle_plate_y-rod_y,8],center=true);
    }
}

module pinion_and_servo_interface() {
    // Pinion includes a cross-pin hole so it cannot spin freely on the output shaft.
    color([0.88,0.60,0.12])
    translate(pinion_center)
        rotate([0,gear_angle,0])
            difference() {
                union() {
                    cylinder(d=2*pinion_rp-2,h=pinion_width,center=true);
                    cylinder(d=14,h=pinion_width+4,center=true);
                    for (a=[0:360/pinion_teeth:359])
                        rotate([0,a,0])
                            translate([pinion_rp,0,0])
                                cube([3,pinion_width,2.2],center=true);
                }
                y_cylinder(4,pinion_width+6);
                x_cylinder(3.2,18);
            }

    // Metal cross-pin locks gear to the shaft; the shaft is drilled to match.
    color([0.18,0.19,0.21])
    translate(pinion_center)
        rotate([0,gear_angle,0])
            x_cylinder(3,16);

    // Shaft joins pinion to the generic servo mounting datum; servo is not modeled.
    color([0.25,0.27,0.30])
    difference() {
        translate([pinion_center[0],
                   (pinion_center[1]+servo_plate_y)/2,
                   pinion_center[2]])
            y_cylinder(4,servo_plate_y-pinion_center[1]+2);
        translate(pinion_center)
            rotate([0,gear_angle,0])
                x_cylinder(3.2,18);
    }

    color([0.42,0.44,0.47])
    difference() {
        translate([pinion_center[0],servo_plate_y,pinion_center[2]])
            cube([36,servo_plate_t,34],center=true);
        translate([pinion_center[0],servo_plate_y,pinion_center[2]])
            y_cylinder(6,servo_plate_t+2);
        for (dx=[-1,1],dz=[-1,1])
            translate([pinion_center[0]+dx*servo_mount_hole_dx,
                       servo_plate_y,pinion_center[2]+dz*servo_mount_hole_dz])
                y_cylinder(3.4,servo_plate_t+2);
    }
}

module moving_pitch_control_arm() {
    // Pin-hole row accepts a pushrod/servo linkage; no actuator is included.
    color([0.86,0.34,0.16])
    difference() {
        translate([body_cx+pitch_ear_offset-12,pitch_axis_y,pitch_axis_z-27])
            cube([6,10,54],center=true);
        for (dz=[-18,-32,-46])
            translate([body_cx+pitch_ear_offset-12,pitch_axis_y,pitch_axis_z+dz])
                x_cylinder(4.2,10);
    }
}

module pitch_cradle() {
    union() {
        split_saddles();
        cradle_spine();
        moving_pitch_control_arm();
    }
}

module fixed_pitch_yoke() {
    color([0.25,0.27,0.30])
    union() {
        translate([body_cx,pitch_axis_y,pitch_axis_z-82])
            cube([2*(pitch_ear_offset+14)+20,14,10],center=true);
        // Fixed pin lug for the pitch pushrod/servo linkage.
        difference() {
            translate([body_cx+pitch_ear_offset-12,pitch_axis_y,pitch_axis_z-70])
                cube([14,22,26],center=true);
            translate([body_cx+pitch_ear_offset-12,pitch_axis_y,pitch_axis_z-70])
                x_cylinder(4.2,16);
        }
        for (s=[-1,1])
            difference() {
                translate([body_cx+s*(pitch_ear_offset+14),pitch_axis_y,pitch_axis_z-34])
                    cube([12,30,100],center=true);
                // X-axis bearing holes are coaxial with the moving trunnions.
                translate([body_cx+s*(pitch_ear_offset+14),pitch_axis_y,pitch_axis_z])
                    x_cylinder(14.5,14);
            }
    }
}

module moving_gripper_and_drive() {
    // One rigid assembly: clamp, saddle, rack/rod coupling, pinion, and trunnions.
    // The X-axis journal remains coaxial with the pitch transform while it tilts.
    translate([body_cx,pitch_axis_y,pitch_axis_z])
        rotate([tilt_angle_deg,0,0])
        translate([-body_cx,-pitch_axis_y,-pitch_axis_z]) {
            reference_clamp();
            pitch_cradle();
            rod_coupler_and_rack();
            rack_guide(guide_z1);
            rack_guide(guide_z2);
            pinion_and_servo_interface();
        }
}

if (show_pitch_support) fixed_pitch_yoke();
moving_gripper_and_drive();
