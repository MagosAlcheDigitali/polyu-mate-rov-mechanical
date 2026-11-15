// Standalone simple-gripper drive and pitch cradle.
// Based only on the supplied clamp STL. Servo body intentionally omitted.
//
// Preview controls
tilt_angle_deg = 0;       // complete clamp/drive cradle pitch about X
rack_travel_mm = 0;       // rack and existing center rod travel, suggested +/-20
show_reference_mesh = true;
show_pitch_support = true;
$fn = 48;

// Approximate supplied STL bounds; adjust rod and saddle parameters to its actual
// central-rod end and body sections before manufacturing.
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

rod_x = -22;               // align to the STL's existing sliding center rod
rod_y = -11;
existing_rod_d = 8;        // measure the exposed rod; sleeve bore has clearance
rod_coupler_od = 20;
rod_coupler_len = 18;
coupler_z0 = zmin+8;       // locate at the exposed rod end on the rear of the STL
rear_sign = -1;            // -1: rear is low-Z; +1: rear is high-Z; flip if needed
rack_length = 108;
rack_travel_limit = 20;
rack_w = 10;
rack_h = 8;
rack_pitch = 4.712;        // module 1.5 rack pitch
tooth_depth = 3.3;
pinion_teeth = 16;
pinion_module = 1.5;
pinion_rp = pinion_module*pinion_teeth/2;
pinion_width = 10;
pinion_center_x = rod_x + rack_w/2 + tooth_depth + pinion_rp;
coupler_z = coupler_z0 + rack_travel_mm;
rack_rear_z = coupler_z0 + rear_sign*rack_length + rack_travel_mm;
rack_mid_z = (coupler_z+rack_rear_z)/2;
pinion_center = [pinion_center_x, rod_y, coupler_z0+rear_sign*rack_length*0.55];
gear_angle = -rear_sign*rack_travel_mm/pinion_rp*180/PI;
guide_z1 = coupler_z0 + rear_sign*24;
guide_z2 = coupler_z0 + rear_sign*66;

// Two split saddle bands wrap the gripper body and bolt to the moving cradle.
// Set these to the measured body cross-section at the selected band stations.
saddle_inner_w = body_w-8;
saddle_inner_d = body_d-8;
saddle_wall = 5;
saddle_band_t = 8;
saddle_station_1 = zmin+18;
saddle_station_2 = zmin+42;
saddle_outer_w = saddle_inner_w + 2*saddle_wall;
saddle_outer_d = saddle_inner_d + 2*saddle_wall;

// Backplate sits behind the STL on +Y. The rack guides and servo shaft datum
// are attached to it, so all drive parts move with the pitch cradle.
cradle_plate_y = body_cy + saddle_outer_d/2 + 12;
cradle_plate_t = 6;
cradle_plate_z0 = min(coupler_z0,rack_rear_z)-20;
cradle_plate_z1 = max(zmax,saddle_station_2)+15;
cradle_plate_zc = (cradle_plate_z0+cradle_plate_z1)/2;
cradle_plate_h = cradle_plate_z1-cradle_plate_z0;
pitch_axis_z = 80;
pitch_ear_offset = saddle_outer_w/2 + 18;
pitch_axis_y = cradle_plate_y;
servo_plate_y = ymax+8;
servo_plate_t = 4;
shaft_len = servo_plate_y - pinion_center[1] + servo_plate_t/2;
servo_mount_hole_dx = 10;
servo_mount_hole_dz = 8;

module x_cylinder(d,h) { rotate([0,90,0]) cylinder(d=d,h=h,center=true); }
module y_cylinder(d,h) { rotate([90,0,0]) cylinder(d=d,h=h,center=true); }

module reference_clamp() {
    if (show_reference_mesh)
        color([0.72,0.75,0.79,1])
            import("../Michelangelo Dealberti FInal Clamp Design.stl", convexity=10);
}

// Split, two-piece saddle band. The opening permits fitting around the supplied
// clamp without sliding a closed ring over the jaws. Two transverse bolts close it.
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

module split_saddles() {
    for (zc=[saddle_station_1,saddle_station_2]) {
        saddle_half(zc,false);
        saddle_half(zc,true);
    }
}

// Rectangular attachment spine joins both split saddle bands and carries the rack
// guides, pinion support, servo output datum, and pitch trunnion crossbar.
module cradle_spine() {
    color([0.30,0.33,0.37])
    union() {
        translate([body_cx,cradle_plate_y,cradle_plate_zc])
            cube([saddle_outer_w+20,cradle_plate_t,cradle_plate_h],center=true);
        for (zc=[saddle_station_1,saddle_station_2])
            translate([body_cx,(body_cy+saddle_outer_d/2+cradle_plate_y)/2,zc])
                cube([saddle_outer_w,saddle_wall+cradle_plate_t,saddle_band_t],center=true);
        // Crossbar is rigidly part of the moving cradle and carries both pitch pins.
        translate([body_cx,pitch_axis_y,pitch_axis_z])
            cube([2*pitch_ear_offset,14,16],center=true);
        for (s=[-1,1])
            translate([body_cx+s*pitch_ear_offset,pitch_axis_y,pitch_axis_z])
                x_cylinder(14,22);
    }
}

// Rack is rigidly joined to a split collar that clamps the existing center rod.
// Two radial set screws lock the collar to the measured rod diameter.
module rod_coupler() {
    color([0.96,0.51,0.12])
    translate([rod_x,rod_y,coupler_z]) {
        difference() {
            cylinder(d=rod_coupler_od,h=rod_coupler_len,center=true);
            cylinder(d=existing_rod_d+0.4,h=rod_coupler_len+2,center=true);
            for (sz=[-1,1])
                translate([rod_coupler_od/2,0,sz*5])
                    x_cylinder(3.2,rod_coupler_od+2);
        }
        // Rack tongue joins the collar at its proximal end.
        translate([pinion_center_x-rod_x-rack_w/2-tooth_depth,0,
                   rear_sign*(-rod_coupler_len/2-4)])
            cube([rack_w,rack_h,8],center=true);
    }
}

module rack_and_coupler() {
    rack_lo = min(coupler_z,rack_rear_z);
    rack_hi = max(coupler_z,rack_rear_z);
    color([0.16,0.35,0.70]) {
        translate([rod_x,rod_y,rack_mid_z])
            cube([rack_w,rack_h,rack_hi-rack_lo],center=true);
        for (z=[rack_lo:rack_pitch:rack_hi])
            translate([rod_x+rack_w/2,rod_y,z])
                rotate([90,0,0])
                    linear_extrude(height=rack_h,center=true)
                        polygon(points=[[0,-rack_pitch/2],
                                        [2.2,-rack_pitch/2],
                                        [tooth_depth,0],
                                        [2.2,rack_pitch/2],
                                        [0,rack_pitch/2]]);
    }
    rod_coupler();
}

// Fixed guides bolt to the moving cradle spine. Their channel supports the rack
// while leaving the tooth face exposed to the pinion.
module rack_guide(zc) {
    color([0.92,0.58,0.14])
    union() {
        difference() {
            translate([rod_x,rod_y,zc]) cube([30,24,10],center=true);
            translate([rod_x+2,rod_y,zc]) cube([rack_w+7,rack_h+2,12],center=true);
        }
        translate([rod_x,(rod_y+cradle_plate_y)/2,zc])
            cube([8,cradle_plate_y-rod_y,8],center=true);
    }
}

module pinion_and_servo_interface() {
    color([0.88,0.60,0.12])
    translate(pinion_center) {
        rotate([0,gear_angle,0])
            difference() {
                union() {
                    cylinder(d=2*pinion_rp-2,h=pinion_width,center=true);
                    for (a=[0:360/pinion_teeth:359])
                        rotate([0,a,0])
                            translate([pinion_rp,0,0])
                                cube([3,pinion_width,2.2],center=true);
                }
                y_cylinder(4,pinion_width+2);
            }
        // Shaft continues from the pinion to a generic servo mounting plate.
        color([0.25,0.27,0.30])
            y_cylinder(4,shaft_len);
    }
    color([0.42,0.44,0.47])
    difference() {
        translate([pinion_center_x,servo_plate_y,pinion_center[2]])
            cube([36,servo_plate_t,34],center=true);
        translate([pinion_center_x,servo_plate_y,pinion_center[2]])
            y_cylinder(6,servo_plate_t+2);
        for (dx=[-1,1],dz=[-1,1])
            translate([pinion_center_x+dx*servo_mount_hole_dx,
                       servo_plate_y,pinion_center[2]+dz*servo_mount_hole_dz])
                y_cylinder(3.4,servo_plate_t+2);
    }
}

// Moving trunnions are X-axis journals. Their axes stay coaxial with the X-axis
// pitch rotation and fit into the fixed yoke bearings.
module pitch_cradle() {
    split_saddles();
    cradle_spine();
}

module fixed_pitch_yoke() {
    color([0.25,0.27,0.30])
    union() {
        translate([body_cx,pitch_axis_y,pitch_axis_z-62])
            cube([2*pitch_ear_offset+20,14,10],center=true);
        for (s=[-1,1])
            difference() {
                translate([body_cx+s*pitch_ear_offset,pitch_axis_y,pitch_axis_z-28])
                    cube([12,30,60],center=true);
                translate([body_cx+s*pitch_ear_offset,pitch_axis_y,pitch_axis_z])
                    x_cylinder(14.5,14);
            }
    }
}

module moving_gripper_and_drive() {
    translate([body_cx,pitch_axis_y,pitch_axis_z])
        rotate([tilt_angle_deg,0,0])
        translate([-body_cx,-pitch_axis_y,-pitch_axis_z]) {
            reference_clamp();
            pitch_cradle();
            rack_and_coupler();
            rack_guide(guide_z1);
            rack_guide(guide_z2);
            pinion_and_servo_interface();
        }
}

if (show_pitch_support) fixed_pitch_yoke();
moving_gripper_and_drive();
