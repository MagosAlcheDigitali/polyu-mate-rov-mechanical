# End-Effector Goal Progress

**Updated:** 15 November 2026  
**Status:** Active prototype development; not a fabrication release.

## Current verified state

- The active design is the one-degree-of-freedom pivot-jaw study in `gripper_study.scad`: fixed blunt reaction face, pivoting jaw, replaceable pad profiles, and a study-only actuator/guard package. It is a prototype concept, not a selected or load-rated tool.
- OpenSCAD 2021.01 compiled `gripper_study.scad` to CSG with `--hardwarnings`; exit code 0, no warnings. Diagnostics: 24 mm nominal opening, 3.17687 mm estimated hard-close gap, 4.01993 mm estimated hook clearance, 95 x 103.5 x 112 mm study envelope, and 97.5 mm forward reach. These checks cover source compilation and analytic geometry only.
- The current integral printed stop remains unsuitable for powered use. A separate double-supported pin/replaceable-stop layout is only a packaging study; it is not integrated, torque-rated, or validated. No actuator, coupler, materials, electrical package, or maximum-load envelope is selected.
- The team-provided vehicle body STL is archived locally at `vehicle_reference/vehicle_body_concept.stl` and publicly in the project repo. It has 3,860 triangles and 472.819 x 256 x 708 coordinate-unit whole-body bounds, but no embedded units, named parts, explicit thruster axes, service volume, or mounting datums. These are whole-mesh extents, not the separately described electronics bay. It supports visual context only and cannot prove vehicle fit. Mesh details and SHA-256 are in `vehicle_reference/README.md`.
- The STEP/STP vehicle assembly, detailed 2027 Explorer Part 1/full manual and prop geometry, measured task loads, and physical prototype evidence are still outstanding. The Floats Preview PDF is for the separate Task 3 profiling float, not a gripper specification.

## Component reviews and contributions

- **Regulus / Videx — mission coverage:** separated Task 3 Floats from ROV product-demonstration tasks; mapped the published manipulation actions into trials. Contact surfaces, forces, travel, and acceptance values remain dependent on practice props or released instructions.
- **Scaevola — vehicle interface:** proposed a removable front bridge loading both structural side rails, bypassing the electronics housing. Mount pattern and service/collision checks require the STEP assembly.
- **Cawl / Ipluvien Maximal / Hyus N’dai — hard stop:** screened the current stop load path and documented a retained cross-pin with supported lug and replaceable stops as the next powered architecture. Sizing requires real actuator torque and measured task loads.
- **Faustinius / Melgator / Koriel Zeth — pads and coupons:** developed replaceable keeper-retained pads and separate body/pad/keeper fit coupons. Insert dimensions are candidates only; printed-host retention and wet performance are unqualified.
- **Decimus-rho / Tiresus — actuator basis:** compared a commercial subsea gripper and custom rotary drive, with manufacturer-source package data and bounded torque screens. Neither is selected; no servo is used by the active study.
- **Cawl — rack-drive re-audit and fix:** the current clamp cradle source had a pinion/near-guide collision and a support rib crossing the moving rack. Kept the pinion 54 mm from the sleeve datum, extended the rack to 128 mm, moved guides to 76/100 mm, and relocated the rib outside the rack path. `validate_rack_pitch_study.ps1` compiles with hard warnings and passed six intersection checks (rack vs guides and pinion vs guides at -20/0/+20 mm). The rack/servo coupling, center member, rail fixedness, tooth contact, pitch range and structural fit remain unvalidated. **Dalathrust** had found the prior saddle-band concept unsuitable; the current four-clip rail layout is a distinct geometry candidate, not a validated clamp mount.

## Repository and presentation

- Public project repository: [MagosAlcheDigitali/polyu-mate-rov-mechanical](https://github.com/MagosAlcheDigitali/polyu-mate-rov-mechanical). Public upload was explicitly approved by the user. The current brief/progress, README, concept, actuator, mission, interface, mesh-index, and clamp-study notes have been synchronized to `main`, along with the vehicle concept STL. This is a storage check, not a fabrication-readiness claim.
- The team presentation is `team_update/PolyU_MATE_ROV_End_Effector_Progress_2026-11-15.pptx`; it is a status deck, not a design release.
- `brief.md` is the current decision/requirements summary. `README.md` is the artifact index. Detailed component reports remain the source for calculations and limits.

- **15 November 2026 — CAD and repository verification:** OpenSCAD 2021.01 compiled the main `gripper_study.scad` and the updated rack/pitch cradle source with `--hardwarnings`, without warnings. Synced the current project documentation to the public repository and verified the remote tree and body-mesh blob SHA. No formal software test suite exists; geometry checks do not test fit, strength, or operation.
- **Cawl — stop integration audit:** the separate double-supported cross-pin study cannot drop into the main pivot stack. Matching sector supports, fork/shaft retention, and a redesigned guard are required; nominal z-stack overlap calculations are documented in `mechanism_design_review.md`. No dimensions or load rating were invented.
- **Reproducible OpenSCAD geometry check:** added and ran `validate_gripper_study.ps1`. It compiled the active CAD with `--hardwarnings`, then checked `jaw_frame_overlap` at 46 sampled angles (0–44° and the 45.456° hard stop); all samples passed with no intersection facets or warnings. The script handles OpenSCAD's expected empty-top-level result for a zero-volume intersection. This only checks jaw body versus support frame at sampled poses; it does not test pads, stop, actuator, guard, vehicle, tolerances, or continuous motion.
- **Clamp-drive checks:** added and ran `validate_rack_pitch_study.ps1`; compile passed with hard warnings and all six guide/rack and guide/pinion intersections were empty at -20, 0, and +20 mm travel. This does not test intended rack/pinion tooth engagement, clamp movement, pitch linkage, servo connection, or structural loads.
- **15 November 2026 — vehicle concept mesh review (Gnaus Archelon):** reviewed the supplied whole-body STL with thruster and electronics-box stand-ins. It is a single closed component with 3,860 triangles and 472.819 x 256 x 708 model-unit bounds. The bounds describe the whole mesh and do not directly conflict with the separately described 250 x 150 x 150 mm electronics bay. No part names, thruster-axis/guard keep-outs, mount datum, camera view, tether route, or electronics service volume can be derived from this mesh. Keep it as rough visual context; use a named STEP/STP assembly in millimetres for integration.
- **15 November 2026 — official mission-source recheck (Rho-mu 31):** MATE still lists the full Explorer manual and Part 1/Product Demonstration materials as pending; the linked briefing remains high-level and supplies no prop dimensions, jaw travel, grasp zones, or task loads. Part 2's depth, mass/envelope, guarding, sharp-edge, and IP-20 constraints remain applicable. The attached Floats Preview remains separate Task 3 material. No contact geometry or actuator sizing assumption can be upgraded to a mission requirement from newly released evidence. Sources and task mapping remain in `mission_release_refresh.md` and `mission_update_review.md`.
## Next design actions

1. Use the actual vehicle STEP/STP assembly to replace the generic mount, then sweep the complete jaw, actuator, guard, service path, thrusters, camera view, buoyancy and tether clearances.
2. Obtain official task props/instructions or faithful practice props. Measure grasp zones, maximum opening, wet retention, safe squeeze, connector/breaker travel and forces, insertion/seating loads, and cycle time.
3. Compare the custom study with the commercial gripper using those measured interfaces and the body assembly; select an actuator only after force, speed, duty, depth, power and service checks.
4. Integrate and size the positive mechanical stop, shaft retention, coupling, guard, reaction mount, and fasteners to the selected drive's maximum torque and the team's measured loads.
5. Build in stages: passive fit coupons and prop mockups; manually loaded load-path rig; guarded powered bench unit; vehicle fit; then recorded wet mission trials and inspection review.
6. Release fabrication drawings/CAD and a tested bill of materials only after all acceptance evidence is recorded.

## Completion gates

- Verified body/mount/collision/service fit.
- Measured task-interface geometry and physical loads, with demonstrated coverage and safe release.
- Selected and depth/power-qualified actuator with matched shaft, coupler, retention, stops, guard and service interfaces.
- Successful secured bench, vehicle, and wet trials, plus safety/inspection review.
- Fabrication package accepted by the team and synchronized to the public repository.

Do not mark this goal complete until each gate has direct evidence. Do not power the current printed-stop design.

