# Simple gripper connection fit sheet

Reference: `Michelangelo Dealberti FInal Clamp Design.stl` only. This sheet maps the remaining fit inputs for `rack_and_pinion_pitch_layout.scad`.

## Connections modeled

- Four split channel clips clamp the two long guide plates at Z=12 and 28 mm. Their openings use the STL-derived plate span (58.599 mm) and thickness (2.6 mm), with 0.5 mm total clearance. Side ribs join each clip to the rear spine while routing around the centerline.
- An 18 mm sleeve and two M3 set screws provide an adjustable connection from the candidate moving center member to the rack through a solid side web. The sleeve outside diameter is 18 mm, leaving 1.2 mm clearance to each guide plate in the measured 20.4 mm gap. The screws face along -X, away from the plates and rack web.
- Rack teeth engage a pinion on a common datum: rack motion is along Z and the pinion shaft axis is Y. A 2 mm cross-pin connects the pinion to the generic 4 mm rear output shaft through a 2.2 mm hole, leaving 0.9 mm shaft walls; the servo body is omitted.
- The clips, two-rail open spine, rack-guide crossbars, servo datum and pitch trunnions form one cradle. A fixed-yoke pin and a moving-arm pin are joined by a telescoping pitch-control interface with retaining pins. `tilt_angle_deg` updates its pin-to-pin length; the actuator body is omitted.

## Evidence and unresolved geometry

The [component inventory](reference_mesh_components.md) lists all 29 disconnected STL components. The [axis section table](reference_mesh_axis_sections.md) shows guide-plate surfaces around the assumed centerline, but no distinct central sliding-rod surface that can establish its diameter or exposed end. The candidate centerline X=-21.3045, Y=-10.200 mm is the midpoint of the two plate centerlines, not a confirmed moving-member axis. The model assumes the member travels along Z.

| SCAD parameter | Current value | Needed to finalize |
|---|---:|---|
| `moving_member_x`, `moving_member_y` | -21.305, -10.2 mm candidate | Confirm moving member centerline and axis direction |
| `moving_member_d` | 8 mm assumption | Measure moving member diameter or cross-section |
| `rod_coupler_od` | 18 mm | Confirm sleeve clears guide plates and neighboring parts |
| `moving_member_coupler_z0` | `zmin+8` | Locate exposed moving-member end and confirm 18 mm straight engagement |
| `rear_sign` | -1 | Confirm which end has room for the rack and servo |
| `rail_clip_stations` | 12, 28 mm | Confirm the two guide plates are fixed and unobstructed there |
| `pitch_axis_z` | 80 mm | Confirm pivot location and full-angle clearance |
| `pitch_link_pin_dz` | -32 mm | Choose moving-arm hole and actuator stroke/load |
| `rack_length` | 128 mm candidate | Recheck cradle extent and tooth engagement after rod/stroke measurement |
| `pinion_distance_mm` | 54 mm candidate | Verify gear location against the real clamp and servo shaft envelope |
| `rack_guide_distances_mm` | [76, 100] mm candidate | Preserve sleeve, pinion and rack-end clearances if rack dimensions change |
| `rack_travel_limit` | 20 mm | Measure stroke needed to open and close the clamp |
| `tilt_angle_deg` | preview input | Specify required up/down angle and actuator travel |

The `validate_rack_pitch_study.ps1` check reports no rack/guide or pinion/guide intersection at -20, 0, and +20 mm rack travel. It does not prove rack/pinion tooth contact, moving-clamp clearance, rail fixedness, or physical fit. An editable STEP/STP/native clamp model, or a dimensioned drawing of the moving member and rail mounting surfaces, is still needed to verify the mating fit and full jaw sweep.

