/*
  Standalone two-sided actuator coupler interface study.
  Units: millimetres. Packaging/interface proxy only; no fabrication dimensions.

  The Blue Trail SER-203X/SER-213X product pages describe a 6 mm titanium
  D-profile output shaft. The pivot side here is an 8 mm D-bore matching the
  current gripper study's shaft-flat convention. The exact vendor flat depth,
  chamfer, shaft projection, allowable radial/axial load, hub fit, and retention
  geometry are not established by this proxy. Replace them from the vendor's
  November 2026 STEP archive and current interface drawing before integration.

  The two shaft sockets are blind bores with a central web. Stub shafts are
  visual fit proxies only. Radial retention holes are unthreaded pilot proxies;
  they do not define a safe set screw, clamp hub, or torque rating.
*/

$fn = 64;

// Choose "D" for the current Blue Trail shaft-interface concept, or "round"
// for a round shaft. Neither profile is a vendor-qualified fit.
motor_shaft_profile = "D"; // [D,round]

// Motor-side interface (SER-203X/SER-213X family reference only).
motor_shaft_d = 6.0;
motor_shaft_flat_depth = 0.8;       // UNKNOWN; replace from vendor STEP/drawing
motor_shaft_diametral_clearance = 0.25; // UNKNOWN; fit/tolerance placeholder
motor_shaft_engagement = 6.0;       // UNKNOWN; available shaft length not checked

// Pivot-side interface follows the current study's nominal 8 mm D shaft.
pivot_shaft_d = 8.0;
pivot_shaft_flat_depth = 1.0;       // study convention: 4 mm radius to x=3 mm flat
pivot_shaft_diametral_clearance = 0.25; // UNKNOWN; fit/tolerance placeholder
pivot_shaft_engagement = 6.0;       // UNKNOWN; retention stack not checked

// Body/web dimensions are visual packaging assumptions, not selected hardware.
coupler_outer_d = 20.0;
central_web_t = 3.0;                // UNKNOWN; size for torque, fatigue and set screws
motor_retention_type = "TBD";       // [TBD,set_screw_proxy,clamp_hub,vendor_hub]
pivot_retention_type = "TBD";       // [TBD,set_screw_proxy,clamp_hub,integral_D_hub]
show_shaft_stubs = true;
show_retention_pilot_holes = true;
motor_retention_pilot_d = 2.5;      // schematic pilot only, not a thread specification
pivot_retention_pilot_d = 2.5;      // schematic pilot only, not a thread specification
retention_pilot_depth = 8.5;        // UNKNOWN; radial access/pilot depth placeholder
part_view = "assembly";             // [assembly,coupler_only,motor_bore,pivot_bore]

assert(motor_shaft_profile == "D" || motor_shaft_profile == "round",
       "motor_shaft_profile must be D or round");
assert(motor_shaft_d > 0 && pivot_shaft_d > 0 && coupler_outer_d > 0,
       "shaft and coupler diameters must be positive");
assert(motor_shaft_engagement > 0 && pivot_shaft_engagement > 0 && central_web_t > 0,
       "engagements and central web must be positive");
assert(coupler_outer_d > max(motor_shaft_d, pivot_shaft_d),
       "coupler outer diameter must exceed both shaft diameters");
assert(coupler_outer_d - max(motor_shaft_d, pivot_shaft_d) >= 2,
       "at least 1 mm nominal radial wall is required for this packaging proxy");

coupler_length = motor_shaft_engagement + central_web_t + pivot_shaft_engagement;
motor_bore_center_z = -coupler_length/2 + motor_shaft_engagement/2;
pivot_bore_center_z = coupler_length/2 - pivot_shaft_engagement/2;

function bore_flat_x(shaft_d, flat_depth, diametral_clearance) =
    shaft_d/2 - flat_depth + diametral_clearance/2;

module d_bore(shaft_d, flat_depth, diametral_clearance, depth) {
    bore_d = shaft_d + diametral_clearance;
    flat_x = bore_flat_x(shaft_d, flat_depth, diametral_clearance);
    assert(flat_depth > 0 && flat_depth < shaft_d/2,
           "D-flat depth must be between zero and the shaft radius");
    difference() {
        cylinder(d=bore_d, h=depth, center=true);
        // Remove the circle segment beyond the flat. Clearance shifts the
        // bore flat outward by half the diametral allowance.
        translate([flat_x + bore_d, 0, 0])
            cube([2*bore_d, 2*bore_d, depth+0.2], center=true);
    }
}

module motor_bore(depth) {
    if (motor_shaft_profile == "D")
        d_bore(motor_shaft_d, motor_shaft_flat_depth,
               motor_shaft_diametral_clearance, depth);
    else
        cylinder(d=motor_shaft_d+motor_shaft_diametral_clearance,
                 h=depth, center=true);
}

module pivot_bore(depth) {
    d_bore(pivot_shaft_d, pivot_shaft_flat_depth,
           pivot_shaft_diametral_clearance, depth);
}

module shaft_stubs() {
    if (show_shaft_stubs) {
        color([0.25,0.44,0.69])
            translate([0,0,motor_bore_center_z])
                if (motor_shaft_profile == "D")
                    d_bore(motor_shaft_d, motor_shaft_flat_depth, 0,
                           motor_shaft_engagement);
                else
                    cylinder(d=motor_shaft_d,h=motor_shaft_engagement,
                             center=true);
        color([0.55,0.58,0.62])
            translate([0,0,pivot_bore_center_z])
                d_bore(pivot_shaft_d,pivot_shaft_flat_depth,0,
                       pivot_shaft_engagement);
    }
}

module retention_pilot_holes() {
    if (show_retention_pilot_holes) {
        for (z=[motor_bore_center_z,pivot_bore_center_z])
            translate([coupler_outer_d/2-retention_pilot_depth/2+0.05,
                       0,z])
                rotate([0,90,0])
                    cylinder(d=(z == motor_bore_center_z
                                ? motor_retention_pilot_d
                                : pivot_retention_pilot_d),
                             h=retention_pilot_depth+0.1,center=true);
    }
}

module coupler_body() {
    color([0.82,0.68,0.36])
        difference() {
            cylinder(d=coupler_outer_d,h=coupler_length,center=true);
            translate([0,0,motor_bore_center_z])
                motor_bore(motor_shaft_engagement+0.02);
            translate([0,0,pivot_bore_center_z])
                pivot_bore(pivot_shaft_engagement+0.02);
            retention_pilot_holes();
        }
}

module actuator_dshaft_coupler_module() {
    coupler_body();
    shaft_stubs();
    echo(str("Two-sided coupler proxy: OD ",coupler_outer_d,
             " mm; total length ",coupler_length," mm; central web ",
             central_web_t," mm."));
    echo(str("Motor bore profile = ",motor_shaft_profile,
             "; motor retention = ",motor_retention_type,
             "; pivot retention = ",pivot_retention_type,"."));
    echo("UNQUALIFIED INTERFACE PROXY: shaft flats, fit, engagement, hub retention, materials and torque capacity remain TBD; replace against vendor STEP and selected hardware.");
}

if (part_view == "assembly") actuator_dshaft_coupler_module();
else if (part_view == "coupler_only") coupler_body();
else if (part_view == "motor_bore") motor_bore(motor_shaft_engagement+0.02);
else if (part_view == "pivot_bore") pivot_bore(pivot_shaft_engagement+0.02);

