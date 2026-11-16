# Stop-guard fastener coupon test plan

**Status:** Draft laboratory procedure for a first-pass print/material screen. This is not a fastener qualification or a safety approval.

## Purpose

Compare the default printed-pilot variants in `guard_fastener_test_coupon.scad` (Ø2.3, Ø2.5 and Ø2.7 mm) for fit and failure behavior at the stop-guard lower-panel joint. The coupon geometry is a Ø6.5 mm boss with 3.2 mm nominal screw engagement, a Ø7.3 mm panel relief, a 1.5 mm panel and a Ø9 x 1 mm underside head flange. Use the coupon that matches the exact candidate CAD revision under test.

The comparison does not identify a generally correct pilot size. Results apply only to the recorded printer, material, orientation, process and actual fastener.

## Inputs required before loading

Fill these before printing; leave the mechanical load targets open until the team's gripper load path is calculated.

| Input | Record |
|---|---|
| Coupon CAD revision / commit | TBD |
| Print material, supplier, lot, conditioning/drying | TBD |
| Printer, nozzle, layer height, walls, infill and print orientation | TBD |
| Actual screw manufacturer/part number, head/washer, material | TBD |
| Driver bit and insertion-torque measurement method | TBD |
| Load direction and joint load derived from the gripper design case | TBD |
| Team-approved proof load, hold duration, service-cycle count and acceptance criteria | TBD |

Derive the per-joint load from the complete gripper reaction path, including credible uneven load sharing. Do not divide a total mechanism load evenly across fasteners unless the structure demonstrates that sharing. The test lead and mechanical lead must agree on a proof target and fixture before destructive testing.

## Specimen preparation

1. Print five carriers for each pilot size and five matching panel coupons as an initial comparative sample (15 carrier/panel sets). The sample count is an engineering-screen proposal, not a statistical qualification.
2. Print all three sizes in the same build where practical, using production-intent material, orientation and slicer settings. Preserve the coupon file's orientation; do not post-drill or ream the pilots unless that is part of the intended build process.
3. Mark each specimen with its actual measured pilot size and replicate ID after printing. Measure and record pilot, boss, relief, panel and flange dimensions with suitable gauges; photograph defects before assembly.
4. Use the selected real screw and washer/head. Do not use the CAD hardware proxy as test hardware. Record the actual screw shank diameter and thread form.

## Test sequence

### 1. Fit and assembly screen

- Drive each screw with the planned tool while recording peak insertion torque if a torque instrument is available.
- Record whether the screw starts straight, cuts or splits the boss, seats the panel head flange, and can be removed without spinning the boss or damaging the panel.
- Assemble and remove for the team-defined service-cycle count. Inspect pilot wear, cracks, panel fretting, screw loosening and loss of head support at every interval.
- Reject or redesign a variant that cannot be assembled and serviced repeatably before proceeding to load tests.

### 2. Axial boss pullout

- Secure the carrier in a fixture that does not clamp or reinforce the boss. Pull the installed screw along its axis with a calibrated force gauge/load cell.
- Record load and displacement continuously if available, first damage, peak load, failure mode, and whether the screw or printed boss failed.
- Compare specimens with the team's predeclared proof-load criterion. Destructive peak load is a characterization result; it is not the working load rating.

### 3. Panel shear and peel

- Assemble the panel, carrier and real screw at the modeled clearances.
- Apply in-plane load in the directions that represent the actual lower-panel load path, then a separate peel/bending load at the panel edge if that can occur during handling/service.
- Record fixture geometry, load arm, peak force, displacement, head-flange pull-through, boss splitting, panel cracking and screw loosening.
- Keep the force application point and support condition identical across sizes. Do not compare results from different fixture setups.

## Record and decision

For every specimen, log pilot size, replicate, print/process, fastener, dimensions, insertion torque, cycle count, load history, maximum load/displacement, failure mode and photos. Summarize each pilot size with individual results and range; do not report only the best specimen.

Choose a pilot only if the joint passes the team-defined assembly/service and load criteria with acceptable repeatability. If all sizes fail, change the boss geometry, material/process, or load path; do not select the least-bad result as qualified. Re-test after any geometry, material, print orientation, fastener or process change.

## Scope limits

This coupon covers the candidate lower panel-to-boss joint only. It does not establish lid insert strength, enclosure access protection, corrosion resistance, wet/thermal aging, actuator stop capacity, vehicle-mount strength, or MATE inspection compliance. The stop reaction must be carried by the structural yoke/frame and not through this guard coupon. Complete dry fit, access-probe inspection, and then wet checks only after the appropriate team reviews.