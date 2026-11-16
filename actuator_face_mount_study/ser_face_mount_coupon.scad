// SER-203x/SER-213x front-face pattern coupon and mountability study.
// Dimensions are from the current vendor drawing proxy in the project.
// This is not vendor STEP, a selected actuator, or a load-rated vehicle mount.
// Units: mm. Origin: actuator case center at z=0; case output face at z=67.

case_length = 70;
case_width = 32;
case_height = 67;
top_feature_d = 24;
top_feature_h = 5.1;
shaft_d = 6;
shaft_length = 8;
hole_pitch_x = 35;
hole_pitch_y = 22;
case_hole_d = 2.9;
case_hole_depth = 16;

// Printable coupon / interface dimensions, deliberately provisional.
plate_length = 78;       // 4 mm margin at each case end
plate_width = 40;        // 4 mm margin at each case side
plate_t = 3;
plate_through_d = 4.0;   // provisional clearance for #6 / M3.5 screw
center_clearance_d = 26; // provisional 1 mm radial clearance around 24 mm feature
screw_shaft_d = 3.0;     // visual placeholder only
screw_head_d = 6.5;      // visual placeholder only
screw_head_t = 2.0;
screw_engagement = 16;   // does not include undocumented thread/load limits

show_package = true;
show_screws = true;
part_view = "assembly"; // [assembly,plate_only,pattern_check]

$fn = 64;

assert(plate_length >= case_length + 2, "Plate needs margin beyond the case length");
assert(plate_width >= case_width + 2, "Plate needs margin beyond the case width");
assert(center_clearance_d > top_feature_d, "Central aperture must clear the top feature");
assert(plate_through_d > case_hole_d, "Plate through-hole must clear the vendor pilot hole");
assert(plate_t > 0 && screw_engagement > 0, "Plate and screw engagement must be positive");

echo("Pattern coupon only: no yoke/body connection is modeled.");
echo(str("Case envelope = ",case_length," x ",case_width," x ",case_height," mm."));
echo(str("Hole pattern = ",hole_pitch_x," x ",hole_pitch_y," mm; case holes Ø",
         case_hole_d," x ",case_hole_depth," mm deep."));
echo(str("Coupon plate = ",plate_length," x ",plate_width," x ",plate_t,
         " mm; provisional clearance holes Ø",plate_through_d,
         " mm and center opening Ø",center_clearance_d," mm."));
echo("Screw proxies do not specify thread, material, torque, engagement strength, or actual hardware.");

module case_envelope() {
    color([0.20,0.44,0.62,0.34])
        difference() {
            translate([-case_length/2,-case_width/2,0])
                cube([case_length,case_width,case_height]);
            for (x=[-hole_pitch_x/2,hole_pitch_x/2],
                 y=[-hole_pitch_y/2,hole_pitch_y/2])
                translate([x,y,case_height-case_hole_depth])
                    cylinder(d=case_hole_d,h=case_hole_depth+0.02);
        }
}

module output_feature() {
    color([0.35,0.39,0.43])
        translate([0,0,case_height])
            cylinder(d=top_feature_d,h=top_feature_h);
    color([0.73,0.75,0.78])
        translate([0,0,case_height+top_feature_h])
            cylinder(d=shaft_d,h=shaft_length);
}

module coupon_plate() {
    difference() {
        translate([-plate_length/2,-plate_width/2,case_height])
            cube([plate_length,plate_width,plate_t]);
        // Central opening clears the raised case feature and the output shaft.
        translate([0,0,case_height-0.1])
            cylinder(d=center_clearance_d,h=plate_t+0.2);
        for (x=[-hole_pitch_x/2,hole_pitch_x/2],
             y=[-hole_pitch_y/2,hole_pitch_y/2])
            translate([x,y,case_height-0.1])
                cylinder(d=plate_through_d,h=plate_t+0.2);
    }
}

module screw_proxies() {
    for (x=[-hole_pitch_x/2,hole_pitch_x/2],
         y=[-hole_pitch_y/2,hole_pitch_y/2]) {
        color([0.65,0.68,0.71]) {
            translate([x,y,case_height+plate_t-(plate_t+screw_engagement)/2])
                cylinder(d=screw_shaft_d,h=plate_t+screw_engagement,center=true);
            translate([x,y,case_height+plate_t+screw_head_t/2])
                cylinder(d=screw_head_d,h=screw_head_t,center=true);
        }
    }
}

module assembly() {
    if (show_package) {
        case_envelope();
        output_feature();
    }
    color([0.86,0.55,0.18]) coupon_plate();
    if (show_screws) screw_proxies();
}

if (part_view=="assembly") assembly();
else if (part_view=="plate_only") coupon_plate();
else if (part_view=="pattern_check") {
    case_envelope();
    output_feature();
    coupon_plate();
}
else assert(false,"Unknown part_view");
