// Standalone drive and pitch cradle for the supplied simple clamp STL.
// The existing square center member is captured by a split saddle; no surrogate
// center rod or servo body is modeled.
$fn = 48;

// Preview controls
tilt_angle_deg = 0;   // complete gripper + rack drive about the X pitch axis
rack_travel_mm = 0;   // slide the saddle/rack along the existing center member, +/-20

// STL bounds and member geometry from simple_gripper/reference_mesh_components.md.
// Component 5 is the 20 x 20 mm square center member running along Y.
xmin = -96.265;
xmax = 49.270;
ymin = -38.000;
ymax = 14.445;
zmin = -14.192;
zmax = 175.678;
body_cx = (xmin+xmax)/2;
body_w = xmax-xmin;
member_x = -26.397;
member_z = 61.751;
member_y0 = -38.000;
member_y1 = 14.445;
member_yc = (member_y0+member_y1)/2;
member_square = 20;
assert(abs(rack_travel_mm)<=20, "rack_travel_mm must stay within +/-20 mm");

// Rack and pinion: rack slides along Y beside the existing member.
// Its teeth face +Z; pinion axis is X, perpendicular to the rack travel.
rack_direction = -1;       // motor and rack tail are behind the clamp (-Y)
rack_x = member_x + 22;
rack_z = member_z;
rack_w = 10;
rack_h = 8;
rack_length = 100;
rack_pitch = 4.712;        // module 1.5
rack_tooth_depth = 3.3;
rack_tooth_width = 2.2;
pinion_teeth = 16;
pinion_module = 1.5;
pinion_rp = pinion_module*pinion_teeth/2;
pinion_width = 10;
pinion_y = member_yc + rack_direction*48;
pinion_z = rack_z + rack_h/2 + 1.5 + pinion_rp;
coupler_y = member_yc + rack_travel_mm;
rack_tail_y = coupler_y + rack_direction*rack_length;
rack_mid_y = (coupler_y+rack_tail_y)/2;
gear_angle = -180/pinion_teeth + rack_travel_mm/pinion_rp*180/PI;

// Two-piece square clamp captures the existing center member at neutral and
// retains 17 mm of overlap at either end of the +/-20 mm preview stroke.
saddle_len = 22;
saddle_outer = 28;
saddle_bore = 20.6;
saddle_bolt_x = 12.3;
saddle_bolt_d = 3.4;

// Measured side rails from the supplied STL; clips attach the pitch cradle.
guide_plate_xmin = -50.604;
guide_plate_xmax = 7.995;
guide_plate_y_centers = [1.300,-21.700];
guide_plate_thickness = 2.6;
guide_plate_cx = (guide_plate_xmin+guide_plate_xmax)/2;
rail_clip_clearance = 0.5;
rail_clip_inner_w = guide_plate_xmax-guide_plate_xmin+rail_clip_clearance;
rail_clip_inner_d = guide_plate_thickness+rail_clip_clearance;
rail_clip_wall = 3;
rail_clip_outer_w = rail_clip_inner_w+2*rail_clip_wall;
rail_clip_outer_d = rail_clip_inner_d+2*rail_clip_wall;
rail_clip_band_t = 8;
rail_clip_stations = [12,28];
cradle_rail_x_offset = rail_clip_inner_w/2+rail_clip_wall/2;
cradle_rail_x = [guide_plate_cx-cradle_rail_x_offset,
                 guide_plate_cx+cradle_rail_x_offset];

// Rear guide frame and pinion/servo interface datum.
rear_frame_z = member_z-20;
rear_frame_end_y = member_yc-rack_length-32;
rack_guide_y = [member_yc-40, member_yc-76];
rack_guide_len = 12;
rack_guide_clearance = 0.5;
servo_output_d = 4;
shaft_clearance = 1.2;
servo_plate_t = 4;
servo_plate_x = rack_x+24;
shaft_end_x = servo_plate_x+servo_plate_t/2+8;
shaft_len = shaft_end_x-rack_x;
pitch_axis_y = 25;          // outside the STL envelope, on the rear cradle
pitch_axis_z = 80;
pitch_ear_offset = body_w/2+12;
pitch_left_x = body_cx-pitch_ear_offset;
pitch_right_x = body_cx+pitch_ear_offset;
pitch_pin_d = 4;
pitch_link_body_d = 11;
pitch_link_rod_d = 6;
pitch_link_pin_dz = -32;
pitch_link_sleeve_fraction = 0.62;

module x_cylinder(d,h) { rotate([0,90,0]) cylinder(d=d,h=h,center=true); }
module y_cylinder(d,h) { rotate([90,0,0]) cylinder(d=d,h=h,center=true); }
module z_cylinder(d,h) { cylinder(d=d,h=h,center=true); }

module reference_clamp() {
    color([0.72,0.75,0.79,1])
        import("../Michelangelo Dealberti FInal Clamp Design.stl", convexity=10);
}

// Split clip halves grip each measured long guide plate.
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

module rail_clip_station(yc,zc) {
    rail_clip_half(yc,zc,false);
    rail_clip_half(yc,zc,true);
    color([0.20,0.22,0.24])
    for (sx=[-1,1]) {
        translate([guide_plate_cx+sx*(rail_clip_inner_w/2+rail_clip_wall/2),yc,zc])
            y_cylinder(4,rail_clip_outer_d+6);
        translate([guide_plate_cx+sx*(rail_clip_inner_w/2+rail_clip_wall/2),
                   yc+rail_clip_outer_d/2+1.5,zc])
            y_cylinder(7,3);
    }
}

// Square clamshell saddle fits the existing 20 mm center member; the side web
// ties it directly to the translating rack.
module square_saddle_half(upper=true) {
    color(upper ? [0.96,0.52,0.12] : [0.86,0.38,0.10])
    difference() {
        intersection() {
            difference() {
                translate([member_x,coupler_y,member_z])
                    cube([saddle_outer,saddle_len,saddle_outer],center=true);
                translate([member_x,coupler_y,member_z])
                    cube([saddle_bore,saddle_len+2,saddle_bore],center=true);
            }
            translate([member_x,coupler_y,member_z+(upper?1:-1)*saddle_outer/4])
                cube([saddle_outer+2,saddle_len+2,saddle_outer/2-0.25],center=true);
        }
        for (sx=[-1,1])
            translate([member_x+sx*saddle_bolt_x,coupler_y,member_z])
                z_cylinder(saddle_bolt_d,saddle_outer+2);
    }
}

module square_saddle_fasteners() {
    color([0.18,0.19,0.21])
    for (sx=[-1,1]) {
        translate([member_x+sx*saddle_bolt_x,coupler_y,member_z])
            z_cylinder(3,saddle_outer+4);
        translate([member_x+sx*saddle_bolt_x,coupler_y,member_z+saddle_outer/2+1])
            z_cylinder(6,2);
        translate([member_x+sx*saddle_bolt_x,coupler_y,member_z-saddle_outer/2-1])
            rotate([0,0,30]) cylinder(d=6,h=2,center=true,$fn=6);
    }
}

module rack_and_saddle() {
    rack_lo = min(coupler_y,rack_tail_y);
    rack_hi = max(coupler_y,rack_tail_y);
    color([0.12,0.32,0.69])
    union() {
        translate([rack_x,rack_mid_y,rack_z])
            cube([rack_w,rack_length,rack_h],center=true);
        // Straight rack teeth face the pinion above the bar.
        for (i=[0:floor(rack_length/rack_pitch)])
            translate([rack_x,coupler_y+rack_direction*i*rack_pitch,
                       rack_z+rack_h/2+rack_tooth_depth/2])
                cube([rack_w,rack_tooth_width,rack_tooth_depth],center=true);
        // Solid web overlaps both the saddle and rack; it moves with the member.
        translate([member_x+18,coupler_y,member_z])
            cube([16,10,8],center=true);
    }
    square_saddle_half(false);
    square_saddle_half(true);
    square_saddle_fasteners();
}

// Fixed guide blocks allow the rack to slide along Y; their feet land on the
// two rear rails that are part of the tilting cradle.
module rack_guide(yc) {
    color([0.92,0.58,0.14])
    difference() {
        translate([rack_x,yc,rack_z+rack_tooth_depth/2])
            cube([24,rack_guide_len,18],center=true);
        translate([rack_x,yc,rack_z+rack_tooth_depth/2])
            cube([rack_w+rack_guide_clearance,
                  rack_guide_len+2,
                  rack_h+rack_tooth_depth+rack_guide_clearance],center=true);
    }
    for (sx=[-1,1])
        translate([rack_x+sx*9,yc,rear_frame_z+4])
            cube([6,rack_guide_len, rack_z-rack_tooth_depth/2-rear_frame_z-4],center=true);
}

module pinion_and_servo_interface() {
    // Pinion axis X. A transverse pin locks it to a generic 4 mm output shaft.
    color([0.88,0.60,0.12])
    translate([rack_x,pinion_y,pinion_z])
        rotate([gear_angle,0,0])
            difference() {
                union() {
                    x_cylinder(2*pinion_rp-2,pinion_width);
                    x_cylinder(14,pinion_width+4);
                    for (a=[0:360/pinion_teeth:359])
                        rotate([a,0,0])
                            translate([0,0,pinion_rp])
                                cube([pinion_width,2.2,3],center=true);
                }
                x_cylinder(servo_output_d,pinion_width+8);
                y_cylinder(2.2,pinion_width+8);
            }
    color([0.18,0.19,0.21])
    translate([rack_x,pinion_y,pinion_z])
        y_cylinder(2,pinion_width+8);

    // Rear servo mounting datum and output shaft; servo body is intentionally omitted.
    color([0.25,0.27,0.30])
    difference() {
        translate([(rack_x+shaft_end_x)/2,pinion_y,pinion_z])
            x_cylinder(servo_output_d,shaft_len);
        translate([rack_x,pinion_y,pinion_z])
            y_cylinder(2.2,pinion_width+8);
    }
    color([0.42,0.44,0.47])
    difference() {
        translate([servo_plate_x,pinion_y,pinion_z])
            cube([servo_plate_t,42,38],center=true);
        translate([servo_plate_x,pinion_y,pinion_z])
            x_cylinder(servo_output_d+2*shaft_clearance,servo_plate_t+2);
        for (dy=[-14,14],dz=[-12,12])
            translate([servo_plate_x,pinion_y+dy,pinion_z+dz])
                x_cylinder(3.4,servo_plate_t+2);
    }
    // Mounting arm ties the motor datum to the right rear cradle rail.
    translate([(servo_plate_x+cradle_rail_x[1])/2,pinion_y,rear_frame_z+5])
        cube([servo_plate_x-cradle_rail_x[1]+servo_plate_t,8,pinion_z-rear_frame_z-5],center=true);
}

module rack_support_frame() {
    // Two rear rails hold the rack guides and motor datum, joined to the clamp clips.
    color([0.30,0.33,0.37])
    union() {
        for (xv=cradle_rail_x) {
            translate([xv,(pitch_axis_y+rear_frame_end_y)/2,rear_frame_z])
                cube([8,pitch_axis_y-rear_frame_end_y,8],center=true);
            translate([xv,pitch_axis_y,(zmin+pitch_axis_z)/2])
                cube([8,8,pitch_axis_z-zmin],center=true);
        }
        for (yy=rack_guide_y)
            translate([(cradle_rail_x[0]+cradle_rail_x[1])/2,yy,rear_frame_z])
                cube([cradle_rail_x[1]-cradle_rail_x[0],8,8],center=true);

        // Crossbar supports the X-axis pitch journals behind the clamp.
        translate([body_cx,pitch_axis_y,pitch_axis_z])
            cube([2*(pitch_ear_offset+13),12,12],center=true);
        for (xv=[pitch_left_x,pitch_right_x])
            translate([xv,pitch_axis_y,pitch_axis_z])
                x_cylinder(12,18);
    }
    for (yc=guide_plate_y_centers)
        for (zc=rail_clip_stations)
            rail_clip_station(yc,zc);
    for (yy=rack_guide_y) rack_guide(yy);
}

module moving_pitch_arm() {
    color([0.86,0.34,0.16])
    difference() {
        translate([pitch_right_x-10,pitch_axis_y,pitch_axis_z-27])
            cube([8,10,54],center=true);
        for (dz=[-18,-32,-46])
            translate([pitch_right_x-10,pitch_axis_y,pitch_axis_z+dz])
                x_cylinder(4.2,12);
    }
}

function pitch_fixed_pin() = [pitch_right_x-10,pitch_axis_y,pitch_axis_z-70];
function pitch_moving_pin() =
    let(dz=pitch_link_pin_dz,a=tilt_angle_deg)
    [pitch_right_x-10,pitch_axis_y-dz*sin(a),pitch_axis_z+dz*cos(a)];

module pitch_control_link() {
    p0=pitch_fixed_pin();
    p1=pitch_moving_pin();
    link_len=norm(p1-p0);
    link_angle=atan2(-(p1[1]-p0[1]),p1[2]-p0[2]);
    sleeve_len=link_len*pitch_link_sleeve_fraction;
    rod_start=link_len*(pitch_link_sleeve_fraction-0.12);
    color([0.72,0.30,0.13])
    translate(p0)
        rotate([link_angle,0,0]) {
            for (zpos=[0,link_len])
                translate([0,0,zpos])
                    difference() {
                        sphere(d=13);
                        x_cylinder(4.4,16);
                    }
            translate([0,0,sleeve_len/2])
                cylinder(d=pitch_link_body_d,h=sleeve_len,center=true);
            translate([0,0,(rod_start+link_len)/2])
                cylinder(d=pitch_link_rod_d,h=link_len-rod_start,center=true);
        }
    color([0.18,0.19,0.21])
    for (p=[p0,p1]) translate(p) x_cylinder(pitch_pin_d,22);
}

module fixed_pitch_yoke() {
    yoke_base_z=pitch_axis_z-82;
    color([0.25,0.27,0.30])
    union() {
        difference() {
            translate([body_cx,pitch_axis_y,yoke_base_z])
                cube([2*(pitch_ear_offset+22),16,10],center=true);
            for (sx=[-1,1],sy=[-1,1])
                translate([body_cx+sx*(pitch_ear_offset+16),
                           pitch_axis_y+sy*5,yoke_base_z])
                    z_cylinder(5.2,12);
        }
        for (xv=[pitch_left_x-1,pitch_right_x+1])
            difference() {
                translate([xv,pitch_axis_y,(yoke_base_z+pitch_axis_z)/2])
                    cube([12,28,pitch_axis_z-yoke_base_z],center=true);
                translate([xv,pitch_axis_y,pitch_axis_z])
                    x_cylinder(12.5,14);
            }
        difference() {
            translate([pitch_right_x-10,pitch_axis_y,yoke_base_z+20])
                cube([14,24,24],center=true);
            translate([pitch_right_x-10,pitch_axis_y,yoke_base_z+20])
                x_cylinder(4.4,18);
        }
    }
}

// Rigid moving unit: the reference clamp, square saddle, rack drive and pitch
// journals all tilt together around the X-axis. The vehicle yoke stays fixed.
module moving_gripper_and_drive() {
    translate([0,pitch_axis_y,pitch_axis_z])
        rotate([tilt_angle_deg,0,0])
        translate([0,-pitch_axis_y,-pitch_axis_z]) {
            reference_clamp();
            rack_support_frame();
            rack_and_saddle();
            pinion_and_servo_interface();
            moving_pitch_arm();
        }
}

if (true) {
    fixed_pitch_yoke();
    moving_gripper_and_drive();
    pitch_control_link();
}
