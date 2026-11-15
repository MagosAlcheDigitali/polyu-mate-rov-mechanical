# Simple gripper connection fit sheet

Reference: `Michelangelo Dealberti FInal Clamp Design.stl` only. This sheet maps the remaining fit inputs for `rack_and_pinion_pitch_layout.scad`.

## Mesh-derived facts and candidate centerline

The [reference mesh report](reference_mesh_analysis.md) finds two matching long guide plates centered at X=-21.3045 mm, with the midpoint between plate centerlines at Y=-10.200 mm. These values are now the candidate rod/rack axis. They are a geometric midpoint; the STL does not label the sliding rod or its fixed/moving status, so verify them against the actual rod.

The report also identifies broad plates at Z≈37…92 mm and a large transverse component near Z≈62 mm. The mesh does not identify which features are fixed or which Z stations are free of jaw movement. Saddle dimensions and locations remain unfitted.

## Measurements needed

| SCAD parameter | Current value | Needed to finalize |
|---|---:|---|
| `rod_x`, `rod_y` | -21.305, -10.2 mm candidate | Confirm against the actual moving rod centerline |
| `existing_rod_d` | 8 mm assumption | Measure exposed sliding rod diameter |
| `coupler_z0` | `zmin+8` | Set sleeve center on at least 18 mm of straight exposed rod |
| `rear_sign` | -1 | Confirm whether servo/rack belongs at low-Z or high-Z end |
| `saddle_inner_w`, `saddle_inner_d` | overall mesh bounds minus 8 mm (placeholder) | Measure local fixed-body section dimensions at two clampable stations |
| `saddle_station_1`, `saddle_station_2` | `zmin+18`, `zmin+42` (placeholders) | Pick fixed-body locations that clear rod and jaw motion |
| `pitch_axis_z` | 80 mm | Confirm desired pitch pivot location and clearance |
| `pitch_axis_y` | cradle rear plane + 16 mm | Confirm mounting offset and available room for side supports |
| `rack_travel_limit` | 20 mm | Measure center-rod stroke needed to open and close the clamp |
| `tilt_angle_deg` | preview control | Specify required up/down pitch range and linkage travel |

The sleeve bore is set to rod diameter +0.4 mm, with an 18 mm grip length and two M3 radial screws. Confirm both screw points bear on sound rod material.

## Finish the fit

Add an editable STEP/STP or native CAD file for this clamp to the GitHub repository, or provide the measurements above. A dimensioned drawing is also useful. With the mating geometry, set the saddle positions, connect the sleeve to the actual rod end, and verify full rack engagement and tilt clearance before fabrication.
