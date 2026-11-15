# Clamp tilt mount concept

This concept uses `Michelangelo Dealberti FInal Clamp Design.stl` as the clamp reference and adds a separate pitch hinge in `tilt_mount_reference.scad`. The copied STL preserves the supplied reference inside the project so the SCAD file can resolve it with a relative path.

## What it does

- Rotates the clamp up and down around a horizontal axis across its width (the X axis in the assumed STL orientation).
- Provides a nominal ±30° motion preview through `tilt_angle_deg`.
- Uses two side trunnions and bearing cheeks to carry the hinge, with a rear saddle plate to represent the clamp-side attachment.
- Adds a fixed actuator reaction plate and a coaxial output hub to show the rotary drive load path; the actuator body is only a packaging envelope.
- Includes a vehicle-side base plate with a generic mounting pattern.

## Fit-up items

The reference mesh bounds are approximately 145.5 mm wide, 52.4 mm deep, and 189.9 mm tall. The code assumes X is width, Y is front/back, and Z is vertical. Confirm the orientation in the CAD application before using this coordinate convention.

The STL does not identify a reliable mounting face, hole pattern, material, clamp mass, center of gravity, or actuator interface. Therefore the saddle plate, holes, pivot location, shaft, cheeks, base pattern, output hub, and actuator proxy are starting geometry only. Set the saddle plate hole positions and thickness to the actual clamp interface; check that the plate clears its moving jaw and that the chosen pivot location balances the clamp. Select a rated rotary actuator and size its coupling, shaft, bearings, fasteners, and vehicle structure from measured mass, center of gravity, water loads, and required tilt speed/holding torque. The current model does not prove that the selected actuator can hold the clamp underwater.

To preview motion, open `tilt_mount_reference.scad` in OpenSCAD and change `tilt_angle_deg` from a negative to a positive value. The reference STL is a visualization mesh and may not be suitable for editing as a solid.

