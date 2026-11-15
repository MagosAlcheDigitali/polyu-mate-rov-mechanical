# Simple gripper connection fit sheet

Reference: `Michelangelo Dealberti FInal Clamp Design.stl` only. This sheet maps the remaining fit inputs for `rack_and_pinion_pitch_layout.scad`.

## Connections now modeled

- Four split channel clips clamp the two long guide plates at Z=12 and 28 mm. The openings use the STL-derived plate span (58.599 mm) and thickness (2.6 mm), with 0.5 mm total clearance. Side ribs join each clip to the rear spine while routing around the central rod axis.
- The moving center rod is intended to enter an 18 mm sleeve. Two M3 set screws retain it, and a solid web joins the sleeve to the rack. Set the sleeve axis and bore from the actual moving rod.
- Rack teeth engage a pinion on a common datum: rack motion is along Z and the pinion shaft axis is Y. The pinion is cross-pinned to a generic servo output shaft; no servo body is modeled.
- The guide-plate clips, rear spine, rack guides, servo datum and pitch trunnions form one cradle. A fixed-yoke pin and a moving-arm pin are joined by a telescoping pitch-control interface with retaining pins. `tilt_angle_deg` updates its pin-to-pin length; the actual actuator and required force/stroke remain to be selected.

## Mesh-derived candidate centerline

The [reference mesh report](reference_mesh_analysis.md) finds two matching long guide plates centered at X=-21.3045 mm, with midpoint between their centerlines at Y=-10.200 mm. These are measured plate dimensions and a geometric candidate for the rod/rack axis, not proof of the actual rod center or diameter.

## Measurements needed to finish mating fit

| SCAD parameter | Current value | Needed to finalize |
|---|---:|---|
| `rod_x`, `rod_y` | -21.305, -10.2 mm candidate | Confirm against actual moving rod centerline |
| `existing_rod_d` | 8 mm assumption | Measure exposed sliding rod diameter |
| `coupler_z0` | `zmin+8` | Place sleeve on at least 18 mm of straight exposed rod |
| `rear_sign` | -1 | Confirm whether rack/servo belongs at low-Z or high-Z end |
| `rail_clip_stations` | 12, 28 mm | Confirm guide plates are fixed and these regions are unobstructed |
| `pitch_axis_z` | 80 mm | Confirm pivot location and full-angle clearance |
| `pitch_link_pin_dz` | -32 mm | Choose moving-arm hole and actuator stroke/load |
| `rack_travel_limit` | 20 mm | Measure center-rod stroke needed to open and close the clamp |
| `tilt_angle_deg` | preview input | Specify required up/down angle and actuator travel |

An editable STEP/STP/native clamp model is still needed to verify rod dimensions, guide-plate motion, pitch-axis clearance and the complete jaw sweep. The current dimensions are a layout that mechanically joins the interfaces, not a fabrication release.
