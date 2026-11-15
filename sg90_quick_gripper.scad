// SG90 Quick Gripper: single fixed finger + one direct-drive moving finger
// Units: mm. Designed as a low-part-count classroom / competition prototype.
// Print base and moving_jaw separately; moving_jaw bolts to a standard SG90 single-arm horn.
$fn = 48;
part = "assembly"; // [assembly,base,moving_jaw]
open_angle = 0;       // preview pose, degrees from forward
closed_angle = 20;    // rotate servo horn to this angle for a narrow grip
jaw_angle = open_angle;
plate_t = 5;

module base() {
  difference() {
    union() {
      // Flat, printable mounting plate
      translate([-28,-29,0]) cube([56,91,plate_t]);
      // Fixed finger, aligned parallel with the moving finger when open
      translate([-15,0,18]) cube([8,55,11]);
      // SG90 cradle: low side rails and rear stop for a servo sitting upright
      translate([-1,-25,plate_t]) cube([2,23,17]);
      translate([23,-25,plate_t]) cube([2,23,17]);
      translate([1,-26,plate_t]) cube([22,2,17]);
      // Thin retaining tabs over the servo mounting ears (M2 clearance)
      translate([0,-19,19]) cube([4,4,3]);
      translate([20,-19,19]) cube([4,4,3]);
      // Reinforce the fixed finger root
      translate([-18,-1,plate_t]) cube([15,10,13]);
    }
    // Four base mounting holes
    for (x=[-21,21], y=[-22,56]) translate([x,y,-1]) cylinder(d=4.2,h=plate_t+2);
    // SG90 ear screw holes through the retaining tabs
    for (x=[2,22]) translate([x,-17,18]) rotate([90,0,0]) cylinder(d=2.2,h=7,center=true);
  }
}

module moving_jaw() {
  difference() {
    union() {
      // Circular servo-horn hub, centered on the SG90 output shaft
      cylinder(d=15,h=8);
      // Broad, tapered finger. The angle is adjusted in assembly for open/closed poses.
      translate([-4,4,0]) hull() {
        cube([8,5,8]);
        translate([-1,42,0]) cube([10,8,8]);
      }
      // Soft-pad seat at the fingertip
      translate([-6,48,0]) cube([12,5,8]);
    }
    // SG90 horn center screw and a pair of M2 horn holes on an 8 mm pitch
    translate([0,0,-1]) cylinder(d=3.4,h=10);
    for (y=[4,12]) translate([0,y,-1]) cylinder(d=2.1,h=10);
  }
}

if (part == "base") base();
else if (part == "moving_jaw") moving_jaw();
else {
  base();
  // Preview moving jaw at its selected servo angle; export individual parts for printing.
  translate([12,-6,27]) rotate([0,0,jaw_angle]) moving_jaw();
  // SG90 envelope shown only in preview (not part of printable geometry)
  %translate([1,-24,5]) cube([23,12,22.5]);
}

