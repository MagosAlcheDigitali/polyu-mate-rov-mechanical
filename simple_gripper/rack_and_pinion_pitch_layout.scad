// Standalone simple-gripper layout.
// Reference: ../Michelangelo Dealberti FInal Clamp Design.stl
// The servo body is intentionally omitted. A servo mounted behind the clamp
// drives the pinion through the adjustable output-shaft/mounting interface.
//
// Preview controls:
tilt_angle_deg = 0;      // pitch of complete gripper assembly, degrees
rack_travel_mm = 0;      // axial rod/rack travel; use -25..25 for preview
show_reference_mesh = true;
show_mechanism = true;
show_pitch_yoke = true;
$fn = 48;

// Approximate reference mesh bounds measured from the supplied STL.
xmin = -96.265;
xmax = 49.270;
ymin = -38.000;
ymax = 14.445;
zmin = -14.192;
zmax = 175.678;

pivot = [(xmin+xmax)/2, (ymin+ymax)/2, 80];
rod_x = -22;
rod_y = -11;
rod_d = 8;
rack_w = 10;
rack_h = 8;
rack_pitch = 4.712;      // module 1.5, matched to 16-tooth pinion
pinion_teeth = 16;
pinion_module = 1.5;
pinion_rp = pinion_module*pinion_teeth/2;
pinion_width = 10;
pinion_center = [rod_x + rack_w/2 + 3.3 + pinion_rp, rod_y, zmin-25];
gear_angle = -rack_travel_mm/pinion_rp*180/PI;
rack_start_z = zmin - 110 + rack_travel_mm;
rack_end_z = zmin + 68 + rack_travel_mm;
guide_z1 = zmin - 84;
guide_z2 = zmin - 54;

module y_cylinder(d,h) { rotate([90,0,0]) cylinder(d=d,h=h,center=true); }

module reference_clamp() {
    if (show_reference_mesh)
        color([0.72,0.75,0.79,1])
            import("../Michelangelo Dealberti FInal Clamp Design.stl", convexity=10);
}

module rod_and_rack() {
    // Round central push/pull rod enters the clamp; the rack extends behind it.
    color([0.18,0.45,0.82])
        translate([rod_x,rod_y,(rack_start_z+zmax)/2])
            cylinder(d=rod_d,h=zmax-(rack_start_z),center=true);
    color([0.16,0.35,0.70]) {
        translate([rod_x,rod_y,(rack_start_z+rack_end_z)/2])
            cube([rack_w,rack_h,rack_end_z-rack_start_z],center=true);
        for (z=[rack_start_z:rack_pitch:rack_end_z])
            translate([rod_x+rack_w/2,rod_y,z])
                rotate([90,0,0])
                    linear_extrude(height=rack_h,center=true)
                        polygon(points=[[0,-rack_pitch/2],
                                        [2.2,-rack_pitch/2],
                                        [3.3,0],
                                        [2.2,rack_pitch/2],
                                        [0,rack_pitch/2]]);
    }
    // Adjustable clevis placeholder at the rod nose: align with moving jaw pin.
    color([0.95,0.58,0.16])
        translate([rod_x,rod_y,zmax-13+rack_travel_mm])
            difference() {
                cube([20,12,16],center=true);
                translate([0,0,0]) y_cylinder(5,14);
            }
}

module guide(zc) {
    color([0.92,0.58,0.14])
    difference() {
        translate([rod_x,rod_y,zc]) cube([24,22,10],center=true);
        translate([rod_x,rod_y,zc]) cylinder(d=rod_d+0.8,h=12,center=true);
    }
}

module pinion() {
    color([0.88,0.60,0.12])
    translate(pinion_center) {
        rotate([0,gear_angle,0])
            union() {
                y_cylinder(2*pinion_rp-2, pinion_width);
                for (a=[0:360/pinion_teeth:359])
                    rotate([0,a,0])
                        translate([pinion_rp,0,0])
                            cube([3.0,pinion_width,2.2],center=true);
            }
        // Through-bore on the pinion axis for the servo output adapter/shaft.
        color([0.22,0.22,0.24])
        difference() {
            y_cylinder(10,pinion_width+1);
            y_cylinder(4,pinion_width+2);
        }
        // Generic mounting datum behind the pinion; pattern remains adjustable.
        color([0.42,0.44,0.47,0.8])
            translate([0,9,0]) cube([32,3,30],center=true);
    }
}

module moving_pitch_trunnions() {
    color([0.30,0.32,0.35])
    for (s=[-1,1])
        translate([pivot[0],pivot[1]+s*29,pivot[2]])
            y_cylinder(12,18);
}

module inner_gripper_assembly() {
    // This transform pitches only this standalone gripper and its drive.
    translate(pivot) rotate([tilt_angle_deg,0,0]) translate(-pivot) {
        reference_clamp();
        if (show_mechanism) {
            rod_and_rack();
            guide(guide_z1);
            guide(guide_z2);
            pinion();
            moving_pitch_trunnions();
        }
    }
}

module pitch_yoke() {
    // Independent fixed support for the up/down pitch axis; not a vehicle model.
    color([0.25,0.27,0.30])
    union() {
        translate([pivot[0],pivot[1],pivot[2]-52])
            cube([190,78,10],center=true);
        for (s=[-1,1])
            difference() {
                translate([pivot[0],pivot[1]+s*32,pivot[2]-24])
                    cube([18,12,58],center=true);
                translate([pivot[0],pivot[1]+s*32,pivot[2]])
                    y_cylinder(12.4,14);
            }
    }
}

if (show_pitch_yoke) pitch_yoke();
inner_gripper_assembly();
