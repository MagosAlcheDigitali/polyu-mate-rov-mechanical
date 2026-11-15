# Simple gripper connection fit sheet

Reference: `Michelangelo Dealberti FInal Clamp Design.stl` only. This sheet maps the remaining fit inputs for `rack_and_pinion_pitch_layout.scad`.

## Connections now modeled

- The moving center rod is intended to enter an 18 mm sleeve. Two M3 set screws retain it, and a solid web joins the sleeve to the rack. Set the sleeve axis and bore from the actual moving rod.
- Rack teeth engage the pinion on a common datum: rack motion is along Z and the pinion shaft axis is Y. The pinion is cross-pinned to a generic servo output shaft; no servo body is modeled.
- The clamp sits in two split saddle bands attached to the moving cradle. Its X-axis trunnions pivot in the fixed yoke.
- A telescoping pitch-control link and two pins now bridge the fixed-yoke lug and the selected moving-arm hole. `tilt_angle_deg` updates the pin-to-pin linkage length. This is an interface datum for choosing a linear actuator; the actuator itself is omitted.

## Mesh-derived candidate centerline

The [reference mesh report](reference_mesh_analysis.md) finds two matching long guide plates centered at X=-21.3045 mm, with midpoint between their centerlines at Y=-10.200 mm. These values are a geometric candidate for the rod/rack axis, not proof of the actual rod center or diameter.

## Measurements needed to finish mating fit

| SCAD parameter | Current value | Needed to finalize |
|---|---:|---|
| `rod_x`, `rod_y` | -21.305, -10.2 mm candidate | Confirm against actual moving rod centerline |
| `existing_rod_d` | 8 mm assumption | Measure exposed sliding rod diameter |
| `coupler_z0` | `zmin+8` | Place sleeve on at least 18 mm of straight exposed rod |
| `rear_sign` | -1 | Confirm whether rack/servo belongs at low-Z or high-Z end |
| `saddle_inner_w`, `saddle_inner_d` | whole mesh bounds minus 8 mm | Measure local fixed-body sections at two clampable stations |
| `saddle_station_1`, `saddle_station_2` | `zmin+18`, `zmin+42` | Select fixed-body regions clear of rod and jaw motion |
| `pitch_axis_z` | 80 mm | Confirm pivot location and full-angle clearance |
| `pitch_link_pin_dz` | -32 mm | Choose the moving-arm hole and actuator stroke/load |
| `rack_travel_limit` | 20 mm | Measure center-rod stroke needed to open and close the clamp |
| `tilt_angle_deg` | preview input | Specify required up/down angle and actuator travel |

The default values describe the layout, not measured mating geometry. An editable STEP/STP/native clamp model is still required to finalize rod, saddle, pitch-axis and clearance fits.
