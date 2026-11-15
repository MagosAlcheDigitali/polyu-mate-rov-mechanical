# End-Effector Goal Progress

**Updated:** 15 November 2026  
**Status:** Active prototype development; not a fabrication release.

## Current verified state

- The active design is the one-degree-of-freedom pivot-jaw study in `gripper_study.scad`: fixed blunt reaction face, pivoting jaw, replaceable pad profiles, and a study-only actuator/guard package. It is a prototype concept, not a selected or load-rated tool.
- OpenSCAD 2021.01 compiled `gripper_study.scad` to CSG with `--hardwarnings`; exit code 0, no warnings. Diagnostics: 24 mm nominal opening, 3.17687 mm estimated hard-close gap, 4.01993 mm estimated hook clearance, 95 x 103.5 x 112 mm study envelope, and 97.5 mm forward reach. These checks cover source compilation and analytic geometry only.
- The current integral printed stop remains unsuitable for powered use. A separate double-supported pin/replaceable-stop layout is only a packaging study; it is not integrated, torque-rated, or validated. No actuator, coupler, materials, electrical package, or maximum-load envelope is selected.
- The provided vehicle body STL is archived locally at `vehicle_reference/vehicle_body_concept.stl` and publicly in the project repo. It has 3,860 triangles and 472.819 x 256 x 708 coordinate-unit bounds, but no embedded units, named components, or mounting datums. It cannot prove vehicle fit.
- The STEP/STP vehicle assembly, detailed 2027 Explorer Part 1/full manual and prop geometry, measured task loads, and physical prototype evidence are still outstanding. The Floats Preview PDF is for the separate Task 3 profiling float, not a gripper specification.

## Component reviews and contributions

- **Regulus / Videx — mission coverage:** separated Task 3 Floats from ROV product-demonstration tasks; mapped the published manipulation actions into trials. Contact surfaces, forces, travel, and acceptance values remain dependent on practice props or released instructions.
- **Scaevola — vehicle interface:** proposed a removable front bridge loading both structural side rails, bypassing the electronics housing. Mount pattern and service/collision checks require the STEP assembly.
- **Cawl / Ipluvien Maximal / Hyus N’dai — hard stop:** screened the current stop load path and documented a retained cross-pin with supported lug and replaceable stops as the next powered architecture. Sizing requires real actuator torque and measured task loads.
- **Faustinius / Melgator / Koriel Zeth — pads and coupons:** developed replaceable keeper-retained pads and separate body/pad/keeper fit coupons. Insert dimensions are candidates only; printed-host retention and wet performance are unqualified.
- **Decimus-rho / Tiresus — actuator basis:** compared a commercial subsea gripper and custom rotary drive, with manufacturer-source package data and bounded torque screens. Neither is selected; no servo is used by the active study.
- **Dalathrust — legacy pitch-cradle scan:** found the older rack/pinion experiment's current saddle sections mismatch local mesh sections. A possible Z=102/116 mm band pair has strongly different widths and centers and approaches a secondary mesh region within 4.75 mm. The STL does not identify moving parts or allow a motion sweep, so the pair is not a validated mount. See `simple_gripper/README.md`.

## Repository and presentation

- Public project repository: [MagosAlcheDigitali/polyu-mate-rov-mechanical](https://github.com/MagosAlcheDigitali/polyu-mate-rov-mechanical). Public upload was explicitly approved by the user. The current brief/progress, README, concept, actuator, mission, interface, mesh-index, and legacy-study notes have been synchronized to `main`. A recursive tree check found 109 paths, the presentation, vehicle STL, 24 prototype-mesh STL files, and the nine-part recovery bundle for three large meshes. This is a storage check, not a fabrication-readiness claim.
- The team presentation is `team_update/PolyU_MATE_ROV_End_Effector_Progress_2026-11-15.pptx`; it is a status deck, not a design release.
- `brief.md` is the current decision/requirements summary. `README.md` is the artifact index. Detailed component reports remain the source for calculations and limits.

- **15 November 2026 — CAD and repository verification:** OpenSCAD 2021.01 compiled the active `gripper_study.scad` with `--hardwarnings` (exit 0; no warnings). The legacy `simple_gripper/rack_and_pinion_pitch_layout.scad` still emits an undefined `servo_output_end_y` warning; it is now clearly marked archived with Cawl and Dalathrust audit findings. Synced the current project documentation to the public repository and verified the remote tree and body-mesh blob SHA. No formal software test suite exists; compilation does not test fit, strength, or operation.

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


## 15 November 2026 — Mesh-aligned axis and rack corrections

- Updated the rack candidate centerline to X=-21.305/Y=-10.2 mm, derived from the midpoint of two matching long plates in the supplied STL.
- Corrected rack/pinion rotation so positive rack Z motion produces the matching positive pinion rotation. Moved the near rack guide 18 mm farther from the sleeve to reduce end-stroke overlap, and defined the missing servo-side shaft-end datum/length used by the CAD.
- Replaced the README with the standalone simple-gripper scope and removed the instruction to use a different design. Updated the fit sheet and linked component report.
- Saddle sizes/stations, exposed rod diameter/end, and moving/fixed feature semantics remain unverified; the component report is geometric only.


## 15 November 2026 — Component projection completed

- The bounded-output GitHub Actions run completed successfully. Added `simple_gripper/reference_mesh_projection.svg`, three orthographic views color-coded by disconnected mesh component, alongside the numerical bounds report.
- Removed the temporary analysis workflow after capturing its results.
- No editable CAD file has appeared in the repository yet; exact moving/fixed roles, rod end, and saddle-safe stations remain open until that model or measurements are available.
