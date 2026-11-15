# Standalone simple gripper: rack drive and pitch cradle

This folder is for the simple clamp in `Michelangelo Dealberti FInal Clamp Design.stl` only.

## Mechanical connection path

- A sleeve surrounds the candidate center-rod axis between the two long guide plates. Two M3 set screws retain the rod; a solid side web joins the sleeve to the rack bar. The rod axis and 8 mm rod diameter remain fit inputs because the STL does not label either.
- Rack teeth face the Y-axis pinion. The rack travels along Z, so this pinion turns around Y. Its 4 mm output shaft reaches a generic rear servo mounting plate and is cross-pinned to the gear. The servo is omitted.
- Two split saddle bands attach the clamp to a moving cradle. The cradle carries the rack guides, pinion and servo datum, so the drive tilts with the clamp.
- X-axis trunnions support the moving cradle in the fixed pitch yoke.
- A telescoping pitch-control linkage connects a pin on the fixed yoke to a selected pin on the moving cradle arm. The actuator body is omitted; `tilt_angle_deg` moves the assembly and updates the linkage pin-to-pin length datum.

## Files and controls

- `rack_and_pinion_pitch_layout.scad` — parametric assembly and editable interfaces.
- `reference_mesh_analysis.md` — connected-component bounds measured from the supplied STL.
- [reference mesh projection](reference_mesh_projection.svg) — three orthographic views colored by disconnected STL component.
- `FIT_MEASUREMENTS.md` — dimensions still needed to fit the interfaces.
- `../Michelangelo Dealberti FInal Clamp Design.stl` — original clamp reference.

In OpenSCAD, `rack_travel_mm` translates the rack and rod sleeve. `tilt_angle_deg` pivots the clamp, cradle, rack drive and shaft plate about X. These are independent preview controls.

## Fit status

The default rack axis is a candidate centerline midway between the two long guide plates. The STL does not identify the rod diameter or exposed length, local body sections for the saddles, fixed versus moving clamp parts, or clear pitch-axis locations. The saddle values and actuator stroke are therefore layout placeholders. Confirm the fit sheet against editable clamp CAD or direct measurements before fabrication.
