# Standalone simple gripper: rack drive and pitch cradle

This folder is for the simple clamp in `Michelangelo Dealberti FInal Clamp Design.stl` only.

## Mechanical connection path

- Four split channel clips clamp the two long guide plates in the STL at Z=12 and 28 mm. Their openings use the plates' measured X span and 2.6 mm thickness. Rear ribs connect the clips to the cradle spine outside the center-rod path.
- A sleeve surrounds the candidate center-rod axis between those guide plates. Two M3 set screws retain the rod; a solid side web joins the sleeve to the rack. The STL does not label the rod or give its diameter, so those remain fit inputs.
- Rack teeth engage the Y-axis pinion. The rack travels along Z, so the pinion turns around Y. Its 4 mm output shaft reaches a generic rear servo mounting plate and is cross-pinned to the gear. The servo is omitted.
- The guide-plate clips, rear spine, rack guides and pinion plate form one moving cradle. X-axis trunnions support that cradle in the fixed pitch yoke.
- A telescoping pitch-control linkage connects a pin on the fixed yoke to a selected pin on the moving cradle arm. The actuator body is omitted; `tilt_angle_deg` moves the assembly and updates the linkage pin-to-pin length datum.

## Files and controls

- `rack_and_pinion_pitch_layout.scad` — parametric assembly and editable interfaces.
- `reference_mesh_analysis.md` — connected-component bounds measured from the supplied STL.
- [reference mesh projection](reference_mesh_projection.svg) — three orthographic views colored by disconnected STL component.
- `FIT_MEASUREMENTS.md` — dimensions still needed to fit the interfaces.
- `../Michelangelo Dealberti FInal Clamp Design.stl` — original clamp reference.

In OpenSCAD, `rack_travel_mm` translates the rack and rod sleeve. `tilt_angle_deg` pivots the clamp, cradle, rack drive and shaft plate about X. These are independent preview controls.

## Fit status

The clip dimensions come from two measured guide-plate components, assuming they are stationary chassis rails. Confirm that assumption before printing. The rod axis is only the midpoint between these rails; the STL does not identify the rod diameter or exposed length, fixed versus moving clamp parts, or full-motion clearance. The pitch pivot and actuator travel also remain layout values. Confirm the fit sheet against editable clamp CAD or direct measurements before fabrication.
