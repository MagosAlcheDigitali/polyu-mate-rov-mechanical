# Standalone simple gripper: rack drive and pitch cradle

This mechanism study uses only `Michelangelo Dealberti FInal Clamp Design.stl`. Servo bodies are omitted.

## Physical connection paths

**Open/close drive:** the rack bar runs beside the gripper's existing center rod. A split sleeve slips over the exposed rod end; two modeled M3 radial screws clamp it. A solid side web joins the sleeve to the rack, so pinion rotation translates the original rod. The pinion has a cross-pin connection to a 4 mm shaft. That shaft reaches through the generic servo mounting plate and leaves an 8 mm adapter stub on the servo side. Mount a servo behind the plate and couple its output to the stub; the exact horn/servo pattern remains adjustable.

**Clamp-to-pitch cradle:** two split saddle bands surround the clamp body at adjustable stations. Modeled bolts and nuts close each band. Bridge blocks join both bands to a spine behind the clamp. The rack guides, pinion/shaft support, and servo interface plate attach to that spine.

**Pitch joint and control:** side supports connect the moving spine to two X-axis trunnions. The trunnions sit in coaxial bearing holes in the fixed yoke, so the clamp and entire drive tilt together. A three-hole arm on the moving cradle and a matching fixed yoke lug provide Ø4.2 mm pin interfaces for a pitch pushrod or actuator linkage. Connect the desired pitch actuator between those interfaces; no actuator body is included.

## Files and controls

- `rack_and_pinion_pitch_layout.scad` — parametric assembly layout.
- `../Michelangelo Dealberti FInal Clamp Design.stl` — original reference mesh.

Open the SCAD file in OpenSCAD. `rack_travel_mm` moves the rack and center-rod sleeve; `tilt_angle_deg` pitches the complete clamp-and-drive cradle about X. The controls are independent. `rear_sign` selects the low-Z or high-Z actuator end.

## Fit values to measure

The source uses approximate bounds X = -96.27…49.27 mm, Y = -38.00…14.44 mm, Z = -14.19…175.68 mm. Set these to match the actual part before printing:

- `rod_x`, `rod_y`, `existing_rod_d`, and `coupler_z0` must match the exposed sliding rod.
- `saddle_inner_w`, `saddle_inner_d`, and the two `saddle_station` values must match two nonmoving body sections and stay clear of the jaws.
- Confirm rack stroke and backlash, the servo horn fit on the 4 mm stub, pitch-link length and range, pin retention, fastener access, and strength.

The assemblies now have explicit modeled interfaces, but their fit to the exact moving-rod end and body cross-sections has not been validated from the binary STL. This is not yet a fabrication release or load-rated design.
