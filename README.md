# MATE ROV Clamp Tilt Mount

Parametric concept for tilting the supplied clamp up and down around a horizontal hinge axis. The project includes the original clamp mesh as a reference, an OpenSCAD assembly concept, and fit-up notes.

## Files

- `Michelangelo Dealberti FInal Clamp Design.stl` — supplied clamp reference mesh.
- `tilt_mount_reference.scad` — adjustable assembly preview with stationary frame, moving cradle, hinge trunnions, and actuator envelope.
- `tilt_mount_concept.md` — motion concept, assumptions, and fit-up work still required.

## Preview the motion

Open `tilt_mount_reference.scad` in OpenSCAD. Change `tilt_angle_deg` near the top from a negative value to a positive value (nominal range `-30°` to `+30°`) to preview down/up tilt. Keep the STL beside the SCAD file so the relative import works.

Set `part_view` to `moving_cradle` or `stationary_frame` to inspect those concept parts separately.

## Design status

This is a packaging and kinematic concept, not a print-ready or load-rated assembly. Pivot height, clamp attachment pattern, shaft/bearing sizes, actuator coupling, frame holes, and mounting hardware need to be set from measured clamp interfaces, mass, center of gravity, vehicle structure, and required underwater holding torque. Review all fit and clearance in CAD before fabrication.
