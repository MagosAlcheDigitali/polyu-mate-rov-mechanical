# Standalone simple gripper: rack drive and pitch

This is a standalone mechanism study based on the supplied `Michelangelo Dealberti FInal Clamp Design.stl`. It uses the clamp mesh as a reference and does not include a servo body.

## How it works

The central rod and rack slide along the clamp's long axis. A pinion sits behind the clamp at the proximal end. A servo mounted behind the clamp would turn the pinion through its output shaft; the rack then moves the rod in and out. The CAD exposes the pinion shaft bore and an adjustable mounting datum, but leaves the servo itself out.

The clamp, rod guides, rack, pinion support, and their pitch trunnions move together. A separate outer yoke holds the trunnions on a transverse axis so the complete simple-gripper assembly can tilt up and down without changing the rack's actuation geometry.

## Files

- `rack_and_pinion_pitch_layout.scad` — adjustable OpenSCAD assembly layout.
- `../Michelangelo Dealberti FInal Clamp Design.stl` — original reference mesh retained in the repository.

Open the SCAD file in OpenSCAD. It imports the STL by relative path. Set `rack_travel_mm` to animate rod movement and `tilt_angle_deg` to pitch the complete gripper. They are independent preview controls.

## Real mechanism references

The rack-and-pinion arrangement follows established servo-driven linear-motion layouts: a gear rack passes through guide brackets and meshes with a pinion, converting servo rotation into straight-line motion. See the [ServoCity Servo-Driven Gear Rack Kit assembly manual](https://www.servocity.com/content/user_manuals/3207-0003-0001_assembly_instructions.min.pdf) and [goBILDA linear-motion kits](https://www.gobilda.com/linear-motion-kits/).

## Adjustable assumptions and required checks

The reference mesh is treated as a visual/coordinate reference. The preliminary bounds used in the source are X = -96.27 to 49.27 mm, Y = -38.00 to 14.44 mm, and Z = -14.19 to 175.68 mm; check these against the exact mesh before changing the design. The long Z direction is used as the push/pull axis in this layout.

The rack location, rack travel, pitch pivot, guide spacing, pinion size, servo mounting pattern, and rod-to-moving-jaw clevis are editable assumptions. The clevis is shown as a simple placeholder and must be positioned to match the actual moving feature. Measure the moving jaw interface and required stroke from the physical/reference CAD before fabrication. Confirm tooth module and backlash, rod buckling/side load, gear/servo torque, pitch pivot retention, pinch clearances, and wet-use materials. No actuator sizing, strength, fit, or printability claim is made here.
