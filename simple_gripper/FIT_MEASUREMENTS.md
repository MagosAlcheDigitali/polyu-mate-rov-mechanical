# Simple gripper connection fit sheet

Use the supplied `Michelangelo Dealberti FInal Clamp Design.stl` as the only part reference. The current SCAD shows connection hardware, but these dimensions are still assumptions until matched to the clamp.

## Measurements needed

| SCAD parameter | Current default | Measure from the clamp |
|---|---:|---|
| `rod_x`, `rod_y` | -21.305, -10.2 mm candidate | Midpoint of the STL's two long guide plates; verify against the actual sliding rod |
| `existing_rod_d` | 8 mm | Diameter of the exposed straight rod section |
| `coupler_z0` | `zmin+8` | Z center of an 18 mm long sleeve landing area on the exposed rod |
| `rear_sign` | -1 | Use -1 if the actuator belongs at low-Z, +1 if at high-Z |
| `saddle_inner_w`, `saddle_inner_d` | body bounds minus 8 mm | X/Y width and depth of each fixed-body section where a split band can clamp |
| `saddle_station_1`, `saddle_station_2` | `zmin+18`, `zmin+42` | Z centers of two fixed-body band locations that do not cross jaw travel |
| `pitch_axis_z` | 80 mm | Desired transverse pivot center along Z |
| `pitch_axis_y` | cradle rear plane + 16 mm | Desired pitch pivot offset along Y; allow the cradle side arms to reach it |
| `rack_travel_limit` | 20 mm | Actual center-rod stroke needed to open and close the jaws |
| `tilt_angle_deg` | preview only | Required up/down pitch range |

The split sleeve has an 18 mm grip length and a bore clearance of 0.4 mm over `existing_rod_d`. Confirm at least that much straight rod is exposed and that the two M3 screw points land on a sound portion of the rod.

## Mesh evidence\n\nThe [component bounds report](reference_mesh_analysis.md) shows two 1,192-triangle guide plates at Y=0…2.6 and Y=-23…-20.4 mm. Their centerline gives the current rack-axis candidate. The report also shows a second pair of broad plates around Z=37…92 mm, but the STL does not say which parts move, so do not use those bounds alone to place the saddles.\n\n## To finish the interface

Either add an editable STEP/STP or native CAD file for this clamp to the GitHub repo, or supply the measurements in the table. A dimensioned drawing or a screenshot with caliper values is also useful. Once the mating geometry is available, update the defaults and verify that:

1. Both bands seat only on fixed clamp body and clear the complete moving jaw/rod stroke.
2. The sleeve fits the actual rod and remains engaged throughout the stroke.
3. The rack keeps tooth engagement at both stroke endpoints.
4. The trunnions rotate freely in the yoke through the required pitch range.
5. The selected pitch-link hole and actuator/link length avoid collisions throughout that range.

No load rating or fabrication approval is implied until those fit and motion checks pass.
