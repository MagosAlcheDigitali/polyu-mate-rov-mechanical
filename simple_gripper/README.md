# Standalone simple gripper: rack drive and pitch cradle

This mechanism study is based only on `Michelangelo Dealberti FInal Clamp Design.stl`. The servo body is omitted.

## Physical connection paths

**Open/close drive:** the rack bar sits beside the gripper's existing central sliding rod. A split sleeve goes over the exposed rod end and two modeled M3 radial screws clamp onto it. A solid side web joins that sleeve to the rack bar. The rack teeth mesh with the pinion. A modeled cross pin locks the pinion to a 4 mm shaft that reaches the generic servo mounting plate. A servo mounted behind that plate can turn the shaft; its body and exact mounting standard are intentionally not modeled.

**Tilt support:** two split saddle bands clamp around the gripper body. Their bridge blocks join a long cradle spine behind the clamp. The rack guides, pinion/shaft support, and servo interface plate attach to that spine, so the drive and gripper pitch as one assembly. The spine carries two X-axis trunnions; matching fixed yoke ears support those trunnions on the same axis as the pitch rotation.

**Pitch actuation interface:** a hole row on the moving cradle arm accepts a linkage pin, and a fixed lug on the yoke accepts the other end of a pushrod or actuator linkage. Connect a pitch actuator between those points to tilt the assembly. No pitch actuator or servo body is included.

## Files and controls

- `rack_and_pinion_pitch_layout.scad` — parametric assembly layout.
- `../Michelangelo Dealberti FInal Clamp Design.stl` — original reference mesh.

Open the SCAD file in OpenSCAD. `rack_travel_mm` moves the rack and sleeve; `tilt_angle_deg` rotates the whole clamp-and-drive cradle about the X-axis. The two controls are independent. `rear_sign` selects whether the rack/servo sits at the low-Z or high-Z end.

## Fit parameters to measure from the clamp

The current source uses approximate STL bounds X = -96.27…49.27 mm, Y = -38.00…14.44 mm, Z = -14.19…175.68 mm. Before fabrication, set:

- `rod_x`, `rod_y`, `existing_rod_d`, `coupler_z0`, and `rear_sign` to match the actual exposed moving rod.
- `saddle_inner_w`, `saddle_inner_d`, `saddle_station_1`, and `saddle_station_2` to match two nonmoving clamp-body sections without covering jaw travel.
- Rack stroke, tooth clearance, pinion/servo shaft coupling, servo bolt pattern, and pitch-link length/hole choice.

Check the saddle bands and rack clearance against the actual model, then verify jaw stroke, gear engagement/backlash, fastener access, pitch range, pin retention, and strength. This is a connected concept layout, not yet a fabrication release or load-rated design.
