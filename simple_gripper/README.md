# Standalone simple gripper: rack drive and pitch cradle

This folder is for the simple clamp in `Michelangelo Dealberti FInal Clamp Design.stl`.

## Mechanical connection path

- The rack runs beside the existing center rod. A split sleeve with two M3 screws clamps to the rod, and a solid web joins the sleeve to the rack.
- Split saddle bands attach the clamp body to a moving cradle. The cradle spine carries the rack guides, pinion support, and servo shaft plate.
- A cross-pin locks the pinion to the 4 mm output shaft. The shaft passes through a generic servo mounting plate and leaves an adapter stub behind it. The servo body is omitted.
- X-axis trunnions on the cradle sit in matching fixed-yoke bearings. The gripper and rack drive tilt together.
- A moving arm and fixed yoke lug provide pin holes for a pitch-control linkage.

## Files and controls

- `rack_and_pinion_pitch_layout.scad` — parametric assembly.
- `reference_mesh_analysis.md` — measured connected-component bounds from the supplied STL.
- `FIT_MEASUREMENTS.md` — dimensions needed to replace the remaining assumptions.
- `../Michelangelo Dealberti FInal Clamp Design.stl` — original reference.

In OpenSCAD, `rack_travel_mm` moves the rack and sleeve, while `tilt_angle_deg` pitches the whole moving assembly about X. The preview controls are independent.

## Fit status

The rack axis now uses the midpoint between the two long guide plates measured from the STL. The rod diameter and exposed end, saddle sections/stations, pitch linkage, and moving clearances are not identified by the STL's triangle geometry. The current saddle values are only layout placeholders. See the fit sheet before making or printing parts.
