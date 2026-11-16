// Guard screw boss/panel retention coupon set
// Purpose: comparative, unpowered printed-pilot screening for the lower
// stop-guard floor joint. This is a geometry aid, not a strength fixture.
// Screws and production hardware are not selected. CAD cannot establish a
// proof load or acceptance threshold; the team must set those after load data.

// Select: single_joint, multi_coupon_bed, boss_carrier_print,
//         panel_coupon_print, fastener_proxy
part_view = "multi_coupon_bed";

// Match the current guard candidate unless varying a study parameter.
boss_d = 6.5;
pilot_d = 2.5;
boss_engagement_h = 3.2;
panel_relief_d = 7.3;          // 0.4 mm radial clearance around Ø6.5 boss
panel_t = 1.5;
carrier_flange_t = 1.5;
panel_carrier_gap = 0.2;       // source candidate nominal service gap
head_flange_d = 9.0;
head_flange_t = 1.0;
screw_proxy_d = 3.0;            // geometry only; use the selected real screw
pilot_variants = [2.3, 2.5, 2.7]; // comparative screen, not qualified sizes
coupon_x = 28;
coupon_y = 24;
part_spacing = 38;
$fn = 64;

module boss_carrier(pilot=pilot_d) {
    // Print orientation: carrier flange rests on the bed, boss rises upward.
    // The blind pilot matches the 3.2 mm nominal boss/thread engagement.
    difference() {
        union() {
            translate([0,0,carrier_flange_t/2])
                cube([coupon_x,coupon_y,carrier_flange_t],center=true);
            // Integrate boss through the flange, as in the guard candidate.
            translate([0,0,boss_engagement_h/2])
                cylinder(d=boss_d,h=boss_engagement_h,center=true);
        }
        translate([0,0,boss_engagement_h/2])
            cylinder(d=pilot,h=boss_engagement_h+0.04,center=true);
    }
}

module panel_coupon() {
    difference() {
        translate([0,0,panel_t/2])
            cube([coupon_x,coupon_y,panel_t],center=true);
        translate([0,0,panel_t/2])
            cylinder(d=panel_relief_d,h=panel_t+0.2,center=true);
    }
}

module hardware_proxy() {
    // Visualization proxy only; do not print as a functional fastener.
    // In assembly coordinates, the screw enters from the panel underside.
    union() {
        translate([0,0,-head_flange_t/2])
            cylinder(d=head_flange_d,h=head_flange_t,center=true);
        translate([0,0,boss_engagement_h/2])
            cylinder(d=screw_proxy_d,h=boss_engagement_h,center=true);
    }
}

module assembly_view(pilot=pilot_d, show_hardware=true) {
    color([0.27,0.44,0.58]) panel_coupon();
    // Invert the print-oriented carrier: boss points down through the panel.
    // This leaves the source candidate's 0.2 mm panel-to-flange gap.
    translate([0,0,boss_engagement_h])
        rotate([180,0,0]) color([0.72,0.75,0.78]) boss_carrier(pilot);
    if (show_hardware)
        color([0.86,0.63,0.22]) hardware_proxy();
}

module multi_coupon_bed() {
    // Columns, left to right: pilot_variants. Top row: boss carriers.
    // Bottom row: identical panel coupons. Write the column/pilot mapping on
    // each physical sample package; this file does not add misleading labels.
    for (i=[0:len(pilot_variants)-1]) {
        x=(i-(len(pilot_variants)-1)/2)*part_spacing;
        translate([x,part_spacing/2,0]) boss_carrier(pilot_variants[i]);
        translate([x,-part_spacing/2,0]) panel_coupon();
    }
}

if (part_view == "single_joint") {
    assembly_view();
} else if (part_view == "multi_coupon_bed") {
    multi_coupon_bed();
} else if (part_view == "boss_carrier_print") {
    boss_carrier();
} else if (part_view == "panel_coupon_print") {
    panel_coupon();
} else if (part_view == "fastener_proxy") {
    hardware_proxy();
} else {
    echo("Unknown part_view; see selector comment at top of file.");
}