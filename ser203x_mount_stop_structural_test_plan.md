# SER-203x mount and hard-stop structural coupon plan

**Status:** planning artifact only. No test load is authorized or specified. Do not power the actuator against a stop.

## Purpose

Measure the deflection, joint slip, and damage risk in the integrated candidate's two separate load paths before a powered prototype is considered:

1. **Actuator reaction:** servo case/top screws → face plate → four reaction posts/cage → lower bridge → yoke → structural vehicle attachment.
2. **Jaw hard stop:** jaw/drive input → pivot shaft and rotating stop → replaceable pin/block → fixed sector/bridge → yoke → structural vehicle attachment.

The candidate geometry is currently a proxy: 35 × 22 mm SER face pattern, four posts, 48 × 40 × 4 mm lower bridge, placeholder screws/inserts, and a 23 mm modeled stop radius. The vehicle bridge and side-wall attachment are not designed. See `gripper_study_ser203x_topmount_candidate.scad` and `actuator_candidate_review.md`.

## Inputs required before fabrication or loading

- Current vendor STEP plus the actual servo model, screws, and hub/coupler; confirm housing, hole positions/depth, output shaft projection/flat, connector and cable route.
- Selected bridge/yoke material, manufacturing process, print/build orientation if relevant, final fastener/insert/washer specs, engagement, edge distances and assembly method.
- Representative structural vehicle bridge attached through both side rails using the actual wall/frame and backing hardware. Do not react proof load through the electronics housing or acrylic center plane alone.
- Measured task loads and lever arms for required grasp, push/pull, insertion, retention, and cycle time from the actual props or faithful practice replicas.
- Team-approved design load, impact allowance, structural factor, proof target, acceptance deflection, and safety approval. Do not substitute the SER's listed stall torque for a mission load or allowable joint load.

If any of these inputs is unknown, the only justified activity is an unloaded fit/assembly check or a clearly labeled comparative low-force screen; leave the proof target **TBD**.

## Coupon arrangement

Build the coupon from production-intent materials and selected hardware. It should include the SER face mount, posts/cage, lower bridge, complete yoke/bearing support, both structural side-rail attachments and backing plates. Use an actual SER case or a rigid dimensionally accurate dummy case with a dummy shaft so the actuator gearbox is not back-driven during mount-reaction testing. Add dial-indicator targets at the case face, bridge ends, yoke, pivot, and stop block. Fixture the rail coupons to a rigid bench plate; independently measure fixture compliance before loading the gripper assembly.

Use separate configurations for mount reaction and stop loading. The servo remains electrically disconnected for both.

### A. Case-mount reaction coupon

Hold the dummy output shaft stationary in an instrumented reaction fixture and apply a known torque to the case/mount assembly about the output axis. This exercises the case screws, face plate, posts, bridge, yoke and vehicle-bridge attachments without transmitting torque through the servo gears. A restrained 100 mm test arm gives `T = F r`; for example, 10 N corresponds to 1 N·m. The example is a conversion only, not a target.

Record applied torque, case rotation relative to the bridge, face-plate bow, each post/bridge displacement, fastener witness-mark movement, hole/insert damage, and residual displacement after unloading. Check contact and fastener access with the real connector/cable installed.

### B. Hard-stop coupon

Remove the servo and install the selected retained pivot shaft, jaw/rotating-stop component, fixed sector/pin/block, bridge and representative yoke. Apply tangential force with a calibrated load cell at a measured radius on the jaw or test lever, with the jaw seated against each stop direction. Compute `T = F r` and `F_stop = T / r_stop`; measure the actual stop radius from the assembly. Increase only to the team-approved target. Do not use motor stall torque or a powered actuator to produce proof load.

Record input force/torque, stop-face motion, pin/block/yoke deflection, angular shift, pin migration, fastener slip, bearing/shaft play, and residual change after unloading. Inspect the pin, lug, stop block, sector, bridge, shaft, bearings, retainers and vehicle attachments after each direction.

## Procedure and stop conditions

1. Photograph and dimension the unloaded build; record material, lot, process, fasteners, installation method and baseline indicator readings.
2. Calibrate the force/torque instrumentation and bench fixture. Apply a small seating load, unload, and reset witness marks.
3. Apply the approved target incrementally in the relevant direction; log force and displacement at every step. Keep hands clear and use a barrier/guard against ejected parts.
4. Stop immediately for cracking, audible yielding, permanent movement, fastener rotation, insert pullout, pin migration, unexpected friction, fixture motion, or guard contact.
5. Unload and remeasure. Disassemble and inspect for cracks, ovalized holes, fretting, thread damage, corrosion or permanent set. Repeat only if the team-approved procedure specifies cycling.
6. Compare observed peak and residual displacement against the acceptance values written before the test. Record pass/fail and failures; do not create a pass criterion after seeing the result.

## Interpretation limits and release gate

This is a static structural coupon, not a wet mission trial, fatigue qualification, depth test, electrical safety test, gear-access inspection or proof of the complete vehicle. Passing one specimen does not qualify different materials, print orientations, hardware, or installation methods. Dynamic stop impact, required cycle life, wet corrosion and actual prop forces need separate evidence.

Release the next actuator/stop design only after the vendor STEP and physical hardware are checked, the load basis is documented, both coupon paths pass the team's predeclared criteria, and the assembled guard is inspected with the required team/competition access check. BTE warns against prolonged servo drive against hard stops; powered limit/fault testing is a separate gated procedure. [BTE SER datasheet Rev. 2.1](https://www.bluetrailengineering.com/_files/ugd/e4c7c5_f6ed898cfb8e4f18b432bcfd0b5dd3fb.pdf?index=true).

## Test record template

| Field | Record |
|---|---|
| Coupon / drawing revision / CAD SHA | |
| Actuator case or dummy; vendor STEP revision | |
| Materials, process, build orientation, batch | |
| Fastener and insert part numbers; engagement/preload method | |
| Structural-rail and bench-fixture geometry | |
| Task load source and measured lever arm | |
| Team-approved design load, factor, proof target and owner | |
| Instrument IDs, calibration, resolution | |
| Case-mount torque / displacement / slip / damage | |
| Open-stop force, radius, torque, deflection and result | |
| Close-stop force, radius, torque, deflection and result | |
| Post-test inspection / residual deformation / changes | |
| Photos, video, raw data, decision, reviewer | |
| Unresolved failures and next action | |

