// Standalone simple-gripper drive and pitch cradle.
// Uses only the supplied clamp STL. Servo body intentionally omitted.
//
// Preview controls
tilt_angle_deg = 0;       // complete clamp and drive cradle pitch about X
rack_travel_mm = 0;       // rack and clamped center-rod travel, suggested +/-20
show_reference_mesh = true;
show_pitch_support = true;
show_pitch_link = true;       // pin-to-pin pitch actuator interface (actuator body omitted)
$fn = 48;

// Approximate bounds for the supplied STL. Verify the central rod and body
// sections at the selected coupling and guide-clip stations before fabrication.
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
rod_x = -21.305;  // midpoint of the supplied STL's two long guide plates
rod_y = -10.2;    // midpoint between the guide-plate centerlines; verify against the rod
existing_rod_d = 8;
coupler_z0 = zmin+8;
rod_coupler_od = 18; // 1.2 mm side clearance in the measured 20.4 mm rail gap
rod_coupler_len = 18;
rear_sign = -1;           // -1: rack/servo at low-Z end; +1: high-Z end

// Rack drive. Rack sits beside the existing rod and clamps to it at the sleeve.
rack_length = 128; // provisional extension to keep both guides on the rack at +/-20 mm travel
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
pinion_distance_mm = 54; // preserve the original gear datum while extending the rack
pinion_outer_radius = pinion_rp+1.5; // approximate tooth-tip radius for guide keep-out only
rack_guide_z_t = 10;
rack_guide_clearance_mm = 2;
rack_guide_distances_mm = [76,100]; // from sleeve center along the rack
rack_guide_support_w = 4;
rack_guide_support_clearance_mm = 1;
coupler_z = coupler_z0 + rack_travel_mm;
rack_rear_z = coupler_z0 + rear_sign*rack_length + rack_travel_mm;
rack_mid_z = (coupler_z+rack_rear_z)/2;
pinion_center = [rack_x+rack_w/2+tooth_depth/2+pinion_rp,
                 rod_y,
                 coupler_z0+rear_sign*pinion_distance_mm];
gear_angle = rack_travel_mm/pinion_rp*180/PI; // positive rack Z travel requires positive pinion rotation
guide_z1 = coupler_z0 + rear_sign*rack_guide_distances_mm[0];
guide_z2 = coupler_z0 + rear_sign*rack_guide_distances_mm[1];
guide_min_from_sleeve_mm = rack_travel_limit+rod_coupler_len/2
    +rack_guide_z_t/2+rack_guide_clearance_mm;
guide_max_from_rack_tail_mm = rack_length-rack_travel_limit
    -rack_guide_z_t/2-rack_guide_clearance_mm;
guide_min_from_pinion_mm = pinion_outer_radius+rack_guide_z_t/2
    +rack_guide_clearance_mm;
assert(rack_guide_distances_mm[0]>=guide_min_from_sleeve_mm,
       "Near rack guide collides with the moving sleeve at full travel.");
assert(rack_guide_distances_mm[1]<=guide_max_from_rack_tail_mm,
       "Far rack guide leaves the rack at full travel.");
assert(abs(rack_guide_distances_mm[0]-pinion_distance_mm)>=guide_min_from_pinion_mm,
       "Near rack guide enters the pinion keep-out.");
assert(abs(rack_guide_distances_mm[1]-pinion_distance_mm)>=guide_min_from_pinion_mm,
       "Far rack guide enters the pinion keep-out.");
assert(rack_guide_distances_mm[1]-rack_guide_distances_mm[0]>=rack_guide_z_t
       +rack_guide_clearance_mm,
       "Rack guide stations overlap or have insufficient spacing.");

// The STL contains two long, thin parallel guide plates. Their measured
// bounds define split clips. Confirm they are stationary before fabrication.
guide_plate_xmin = -50.604;
guide_plate_xmax = 7.995;
guide_plate_y_centers = [1.300,-21.700];
guide_plate_thickness = 2.6;
guide_plate_cx = (guide_plate_xmin+guide_plate_xmax)/2;
rail_clip_clearance = 0.5;
rail_clip_inner_w = guide_plate_xmax-guide_plate_xmin+rail_clip_clearance;
rail_clip_inner_d = guide_plate_thickness+rail_clip_clearance;
rail_clip_wall = 3;
rail_clip_band_t = 8;
rail_clip_outer_w = rail_clip_inner_w+2*rail_clip_wall;
rail_clip_outer_d = rail_clip_inner_d+2*rail_clip_wall;
rail_clip_stations = [12,28];

// Rear spine stays beyond the mesh's Y maximum and supports the rail clips,
// rack guides, servo datum and pitch trunnions as one moving cradle.
cradle_plate_y = 20;
cradle_plate_t = 6;
cradle_plate_z0 = min(coupler_z0,rack_rear_z)-20;
cradle_plate_z1 = max(zmax,rail_clip_stations[1])+15;
cradle_plate_zc = (cradle_plate_z0+cradle_plate_z1)/2;
cradle_plate_h = cradle_plate_z1-cradle_plate_z0;
pitch_axis_z = 80;
pitch_ear_offset = rail_clip_outer_w/2+12;
pitch_axis_y = cradle_plate_y+16;
servo_plate_y = ymax+8;
servo_plate_t = 4;
servo_output_end_y = servo_plate_y + servo_plate_t/2 + 8; // shaft engagement stub beyond the servo plate
shaft_len = servo_output_end_y - pinion_center[1];
servo_mount_hole_dx = 10;
servo_mount_hole_dz = 8;
pitch_link_pin_dz = -32;      // selected moving-arm pin offset below the pitch axis
pitch_link_body_d = 11;
pitch_link_rod_d = 6;
pitch_pin_d = 4;
pitch_link_sleeve_fraction = 0.62;
pinion_cross_pin_d = 2;   // leaves a usable wall through the 4 mm output shaft

module x_cylinder(d,h) { rotate([0,90,0]) cylinder(d=d,h=h,center=true); }
module y_cylinder(d,h) { rotate([90,0,0]) cylinder(d=d,h=h,center=true); }

module reference_clamp() {
    if (show_reference_mesh)
        color([0.72,0.75,0.79,1])
            import("../Michelangelo Dealberti FInal Clamp Design.stl", convexity=10);
}

// Two-piece channel clips grip the measured guide plates at two Z stations.
// Split bolts sit outside the plate edges; the center rod remains unobstructed.
module rail_clip_half(yc,zc,upper=true) {
    color(upper ? [0.94,0.58,0.16] : [0.88,0.42,0.12])
    difference() {
        intersection() {
            difference() {
                translate([guide_plate_cx,yc,zc])
                    cube([rail_clip_outer_w,rail_clip_outer_d,rail_clip_band_t],center=true);
                translate([guide_plate_cx,yc,zc])
                    cube([rail_clip_inner_w,rail_clip_inner_d,rail_clip_band_t+2],center=true);
            }
            translate([guide_plate_cx,yc+(upper?1:-1)*rail_clip_outer_d/4,zc])
                cube([rail_clip_outer_w+2,rail_clip_outer_d/2,rail_clip_band_t+2],center=true);
        }
        for (sx=[-1,1])
            translate([guide_plate_cx+sx*(rail_clip_inner_w/2+rail_clip_wall/2),yc,zc])
                y_cylinder(4.3,rail_clip_outer_d+2);
    }
}

module rail_clip_fasteners(yc,zc) {
    color([0.20,0.22,0.24])
    for (sx=[-1,1]) {
        translate([guide_plate_cx+sx*(rail_clip_inner_w/2+rail_clip_wall/2),yc,zc])
            y_cylinder(4,rail_clip_outer_d+6);
        translate([guide_plate_cx+sx*(rail_clip_inner_w/2+rail_clip_wall/2),
                   yc+rail_clip_outer_d/2+1.5,zc])
            y_cylinder(7,3);
        translate([guide_plate_cx+sx*(rail_clip_inner_w/2+rail_clip_wall/2),
                   yc-rail_clip_outer_d/2-1.5,zc])
            difference() {
                rotate([90,0,0]) cylinder(d=7,h=3,center=true,$fn=6);
                y_cylinder(4.3,5);
            }
    }
}

module rail_clip_station(yc,zc) {
    rail_clip_half(yc,zc,false);
    rail_clip_half(yc,zc,true);
    rail_clip_fasteners(yc,zc);
    // Rear support ribs attach the clip to the spine outside the moving rod axis.
    for (sx=[-1,1]) {
        support_x = guide_plate_cx+sx*(rail_clip_inner_w/2+rail_clip_wall/2);
        support_y0 = yc+rail_clip_outer_d/2;
        support_y1 = cradle_plate_y-cradle_plate_t/2;
        translate([support_x,(support_y0+support_y1)/2,zc])
            cube([8,support_y1-support_y0,rail_clip_band_t],center=true);
    }
}

module rail_clamps() {
    for (yc=guide_plate_y_centers)
        for (zc=rail_clip_stations)
            rail_clip_station(yc,zc);
}

module cradle_spine() {
    color([0.30,0.33,0.37])
    union() {
        translate([body_cx,cradle_plate_y,cradle_plate_zc])
            cube([rail_clip_outer_w+32,cradle_plate_t,cradle_plate_h],center=true);
        // Rigid crossbar joins pitch journals to the same rail-clip-mounted spine.
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
                    cube([7,rack_h,rod_coupler_len-4],center=true);
            }
            cylinder(d=existing_rod_d+0.4,h=rod_coupler_len+2,center=true);
            // Set-screw bores face away from the close guide-plate gap.
            for (sz=[-1,1])
                translate([-rod_coupler_od/2+0.75,0,sz*5])
                    x_cylinder(3.2,12);
        }
        // Two modeled M3 radial screws bear on the existing rod.
        color([0.18,0.19,0.21])
        for (sz=[-1,1]) {
            translate([rod_x-rod_coupler_od/2+3,rod_y,coupler_z+sz*5])
                x_cylinder(3,8);
            translate([rod_x-rod_coupler_od/2-0.8,rod_y,coupler_z+sz*5])
                x_cylinder(5.5,1.6);
        }
    }
}

module rack_guide(zc) {
    color([0.92,0.58,0.14])
    union() {
        difference() {
            translate([rack_x,rod_y,zc])
                cube([30,24,rack_guide_z_t],center=true);
            // The centered rack bar and its +X tooth profile fit within this
            // through-window; the side support stays behind the -X rack edge.
            translate([rack_x+2,rod_y,zc])
                cube([rack_w+7,rack_h+2,rack_guide_z_t+2],center=true);
        }
        translate([rack_x-rack_w/2-rack_guide_support_clearance_mm
                   -rack_guide_support_w/2,
                   (rod_y+cradle_plate_y)/2,zc])
            cube([rack_guide_support_w,cradle_plate_y-rod_y,
                  rack_guide_z_t-2],center=true);
    }
}

module rack_guide_overlap_diagnostic() {
    intersection() {
        rod_coupler_and_rack();
        union() {
            rack_guide(guide_z1);
            rack_guide(guide_z2);
        }
    }
}

module rack_pinion_overlap_diagnostic() {
    intersection() {
        pinion_and_servo_interface();
        union() {
            rack_guide(guide_z1);
            rack_guide(guide_z2);
        }
    }
}

module pinion_and_servo_interface() {
    // Pinion includes a cross-pin hole so it cannot spin freely on the output shaft.
    color([0.88,0.60,0.12])
    translate(pinion_center)
        rotate([0,gear_angle,0])
            difference() {
                union() {
                    // Pinion axis is Y: rack motion along Z then drives rotation about Y.
                    y_cylinder(2*pinion_rp-2,pinion_width);
                    y_cylinder(14,pinion_width+4);
                    for (a=[0:360/pinion_teeth:359])
                        rotate([0,a,0])
                            translate([pinion_rp,0,0])
                                cube([3,pinion_width,2.2],center=true);
                }
                y_cylinder(4,pinion_width+6);
                x_cylinder(pinion_cross_pin_d+0.2,18);
            }

    // A 2 mm metal cross-pin locks the gear to the shaft.
    color([0.18,0.19,0.21])
    translate(pinion_center)
        rotate([0,gear_angle,0])
            x_cylinder(pinion_cross_pin_d,16);

    // Shaft joins pinion to the generic servo mounting datum; servo is not modeled.
    color([0.25,0.27,0.30])
    difference() {
        translate([pinion_center[0],
                   (pinion_center[1]+servo_output_end_y)/2,
                   pinion_center[2]])
            y_cylinder(4,shaft_len);
        translate(pinion_center)
            rotate([0,gear_angle,0])
                x_cylinder(pinion_cross_pin_d+0.2,18);
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
    // Pin-hole row accepts the moving eye of the pitch actuator connection; no actuator is included.
    color([0.86,0.34,0.16])
    difference() {
        translate([body_cx+pitch_ear_offset-12,pitch_axis_y,pitch_axis_z-27])
            cube([6,10,54],center=true);
        for (dz=[-18,-32,-46])
            translate([body_cx+pitch_ear_offset-12,pitch_axis_y,pitch_axis_z+dz])
                x_cylinder(4.2,10);
    }
}

function pitch_fixed_pin() =
    [body_cx+pitch_ear_offset-12, pitch_axis_y, pitch_axis_z-70];

function pitch_moving_pin() =
    let(dz=pitch_link_pin_dz, a=tilt_angle_deg)
    [body_cx+pitch_ear_offset-12,
     pitch_axis_y-dz*sin(a),
     pitch_axis_z+dz*cos(a)];

// A pin-to-pin, telescoping actuator datum joins the fixed pitch yoke to the
// moving cradle arm. The actuator motor/body is intentionally omitted.
// Its length follows the pitch preview angle so the two interfaces stay joined.
module pitch_control_link() {
    p0 = pitch_fixed_pin();
    p1 = pitch_moving_pin();
    link_len = norm(p1-p0);
    link_angle = atan2(-(p1[1]-p0[1]),p1[2]-p0[2]);
    sleeve_len = link_len*pitch_link_sleeve_fraction;
    rod_start = link_len*(pitch_link_sleeve_fraction-0.12);
    color([0.72,0.30,0.13])
    translate(p0)
        rotate([link_angle,0,0]) {
            // Clevis eyes have X-axis bores matching the two lug pin axes.
            for (zpos=[0,link_len]) {
                translate([0,0,zpos])
                difference() {
                    sphere(d=13);
                    x_cylinder(4.4,16);
                }
            }
            // These overlapping telescoping members show the actuator stroke
            // envelope; replace with the selected actuator and end clevises.
            translate([0,0,sleeve_len/2])
                cylinder(d=pitch_link_body_d,h=sleeve_len,center=true);
            translate([0,0,(rod_start+link_len)/2])
                cylinder(d=pitch_link_rod_d,h=link_len-rod_start,center=true);
        }
    // Retaining pins pass through the fixed yoke, actuator eye, and moving arm.
    color([0.18,0.19,0.21])
    for (p=[p0,p1])
        translate(p) x_cylinder(pitch_pin_d,22);
}

module pitch_cradle() {
    union() {
        rail_clamps();
        cradle_spine();
        moving_pitch_control_arm();
    }
}

module fixed_pitch_yoke() {
    color([0.25,0.27,0.30])
    union() {
        // Fixed base plate has four through-holes to bolt the pitch yoke
        // to the vehicle-side support.
        difference() {
            translate([body_cx,pitch_axis_y,pitch_axis_z-82])
                cube([2*(pitch_ear_offset+14)+20,14,10],center=true);
            for (sx=[-1,1],sy=[-1,1])
                translate([body_cx+sx*pitch_ear_offset,
                           pitch_axis_y+sy*4,pitch_axis_z-82])
                    cylinder(d=5.2,h=12,center=true);
        }
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
    // One rigid assembly: clamp, rail clips, rack/rod coupling, pinion, and trunnions.
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

part_view = "assembly"; // [assembly,rack_guide_overlap,rack_pinion_overlap]
if (part_view=="rack_guide_overlap") rack_guide_overlap_diagnostic();
else if (part_view=="rack_pinion_overlap") rack_pinion_overlap_diagnostic();
else {
    if (show_pitch_support) fixed_pitch_yoke();
    moving_gripper_and_drive();
    if (show_pitch_support && show_pitch_link) pitch_control_link();
}

