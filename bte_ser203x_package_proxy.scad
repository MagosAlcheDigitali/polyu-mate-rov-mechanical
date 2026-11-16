/*
  Blue Trail Engineering SER-203x / SER-213x dimensional package proxy.

  Use for early mount-envelope studies only. This is not manufacturer CAD.
  The housing envelope, top mounting-hole pattern, shaft diameter/length and
  24 mm top feature are taken from the manufacturer's dimension drawing. The
  Cobalt connector, side through-hole location, exact corner radii, hub/boss
  stack and D-flat geometry are not fully defined here; replace this proxy with
  the vendor STEP from the November 2026 archive before detailed integration.
  Units: mm. Coordinate origin: bottom center of the nominal housing.
  Source: Blue Trail Engineering SER-2XXX datasheet Rev. 2.1 (Oct. 2026),
  https://www.bluetrailengineering.com/_files/ugd/e4c7c5_f6ed898cfb8e4f18b432bcfd0b5dd3fb.pdf?index=true
*/

body_length = 70.0;
body_width = 32.0;
body_height = 67.0;
overall_height_to_shaft_tip = 80.1;
shaft_diameter = 6.0;
shaft_length = 8.0;
top_feature_diameter = 24.0;
top_feature_height = overall_height_to_shaft_tip-body_height-shaft_length;

top_mount_hole_spacing_x = 35.0;
top_mount_hole_spacing_y = 22.0;
top_mount_hole_diameter = 2.9;
top_mount_hole_depth = 16.0;
top_mount_screw_note = "#6 or M3.5 self-tapping; verify actual screw";

// Visual placeholders, not dimensioned vendor interfaces.
housing_corner_radius = 3.0;
d_flat_depth_placeholder = 0.8;
include_top_mount_holes = true;
include_proxy_d_flat = true;
part_view = "package"; // [package,housing_and_top_feature,housing_only,top_feature_and_shaft,top_mount_pattern]
$fn = 64;

assert(body_length > 0 && body_width > 0 && body_height > 0,
       "Housing dimensions must be positive");
assert(top_feature_height > 0,
       "The current drawing dimensions must leave a positive top feature height");
assert(shaft_diameter > 0 && shaft_length > 0,
       "Shaft dimensions must be positive");

module rounded_housing() {
    r = min(housing_corner_radius, body_width/2-0.01, body_length/2-0.01);
    hull()
        for (x=[-body_length/2+r,body_length/2-r],
             y=[-body_width/2+r,body_width/2-r])
            translate([x,y,0]) cylinder(r=r,h=body_height);
}

module housing() {
    difference() {
        rounded_housing();
        if (include_top_mount_holes)
            for (x=[-top_mount_hole_spacing_x/2,top_mount_hole_spacing_x/2],
                 y=[-top_mount_hole_spacing_y/2,top_mount_hole_spacing_y/2])
                translate([x,y,body_height-top_mount_hole_depth])
                    cylinder(d=top_mount_hole_diameter,
                             h=top_mount_hole_depth+0.02);
    }
}

module top_feature() {
    translate([0,0,body_height])
        cylinder(d=top_feature_diameter,h=top_feature_height);
}

module d_shaft() {
    translate([0,0,body_height+top_feature_height])
        difference() {
            cylinder(d=shaft_diameter,h=shaft_length);
            if (include_proxy_d_flat)
                translate([shaft_diameter/2-d_flat_depth_placeholder,
                           -shaft_diameter,-0.01])
                    cube([shaft_diameter,2*shaft_diameter,shaft_length+0.02]);
        }
}

module package() {
    housing_and_top_feature();
    color([0.72,0.74,0.77]) d_shaft();
}

module housing_and_top_feature() {
    color([0.25,0.28,0.32]) housing();
    color([0.36,0.39,0.43]) top_feature();
}

module top_mount_pattern() {
    for (x=[-top_mount_hole_spacing_x/2,top_mount_hole_spacing_x/2],
         y=[-top_mount_hole_spacing_y/2,top_mount_hole_spacing_y/2])
        translate([x,y,body_height-top_mount_hole_depth])
            cylinder(d=top_mount_hole_diameter,h=top_mount_hole_depth);
}

echo("SER-203x/SER-213x early dimensional proxy only; verify vendor STEP before mount/coupler release.");
echo("Housing envelope = 70 x 32 x 67 mm; shaft tip z = 80.1 mm; connector and side-hole interfaces are omitted.");
echo("Top face: four Ø2.9 x 16 mm holes on 35 x 22 mm pattern; confirm screw and vendor STEP.");
echo("D-flat depth and corner radii are visual placeholders, not confirmed interfaces.");

if (part_view == "package") package();
else if (part_view == "housing_and_top_feature") housing_and_top_feature();
else if (part_view == "housing_only") housing();
else if (part_view == "top_feature_and_shaft") { top_feature(); d_shaft(); }
else if (part_view == "top_mount_pattern") top_mount_pattern();
else assert(false,"Unknown part_view selector");

