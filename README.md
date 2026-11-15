# PolyU MATE ROV End-Effector Study

This workspace tracks a prototype study for a maintainable mechanical end effector for PolyU's 2027 MATE Explorer ROV. It is an active design project, not a fabrication release.

The GitHub home is [`MagosAlcheDigitali/polyu-mate-rov-mechanical`](https://github.com/MagosAlcheDigitali/polyu-mate-rov-mechanical). Its public snapshot tracks the project documentation, parametric source files, selected previews, and the team progress presentation. The existing clamp STL and tilt-mount references on the remote were preserved. This is a design-study snapshot, not a fabrication release.

## Current concept

The OpenSCAD study uses a removable vehicle adapter, structural yoke, fixed reaction/push face, one pivoting jaw, replaceable contact pads, a guarded stop, and a generic actuator package. Current defaults are approximately 24 mm open pad gap, 0–44° commanded sweep, 3.18 mm analytic hard-close gap, a 95 x 103.5 x 112 mm study envelope, and 97.5 mm forward reach from the model datum. These are study values only.

**Actuator clarification:** `gripper_study.scad` has no selected servo. Its Ø20 x 45 mm cylinder and Ø6 mm shaft are generic packaging placeholders, not SG90 dimensions or a confirmed motor choice. `sg90_quick_gripper.scad` is a separate, simple, low-load classroom-style mockup built around an SG90 horn; it does not drive the main pivot-jaw model and is not an underwater-rated actuator recommendation.

The provided vehicle image and verbal 250 x 150 x 150 mm body envelope are context, not CAD fit evidence. The team selected STEP/STP assembly as the preferred vehicle-CAD format. That assembly and mission practice-prop geometry have not been supplied. The official Explorer Part 1 mission manual is currently listed as pending, so task-specific grasp/contact features remain provisional.

## Start here

- [`brief.md`](brief.md) — requirements, assumptions, current design decisions, completion gates, and file delivery instructions.
- [`progress.md`](progress.md) — dated project work, reviews, verification, and open inputs.
- [`team_update/PolyU_MATE_ROV_End_Effector_Progress_2026-11-15.pptx`](team_update/PolyU_MATE_ROV_End_Effector_Progress_2026-11-15.pptx) — team progress presentation with editable status graphs and an ordered file tour.
- [`gripper_concept_brief.md`](gripper_concept_brief.md) — mechanism concept, task mapping, force calculations, safety gates, and prototype sequence.
- [`gripper_study.scad`](gripper_study.scad) — parametric geometry study.
- [`gripper_torque_test_fixture.scad`](gripper_torque_test_fixture.scad) — bench-only 100 mm torque lever and extended test-shaft layout; secure the passive yoke and use matched real retention hardware before loading.
- [`torque_test_fixture_preview.stl`](torque_test_fixture_preview.stl) — refreshed assembly mesh for the torque-test fixture; use for visual fit only, not as a load-rated print release.
- [`sg90_quick_gripper_README.md`](sg90_quick_gripper_README.md) and [`sg90_quick_gripper.scad`](sg90_quick_gripper.scad) — separate SG90-horn quick mockup for light dry fit trials; not the main pivot jaw or a depth-rated drive.
- [`tilt_mount_reference.scad`](tilt_mount_reference.scad) and [`tilt_mount_concept.md`](tilt_mount_concept.md) — pitch hinge concept using the supplied clamp STL; adapter and actuator interfaces still need measured fit-up.
- [`prototype_meshes/README.md`](prototype_meshes/README.md) — STL inventory, bounds, topology, and mockup limits.
- [`gripper_interface_measurements.md`](gripper_interface_measurements.md) — worksheet for props, loads, actuator, vehicle, and MATE clarifications.
- [`actuator_selection_basis.md`](actuator_selection_basis.md) — source-backed commercial-versus-custom actuator comparison.
- [`actuator_candidate_review.md`](actuator_candidate_review.md) — Tiresus's manufacturer-source shortlist and package/torque screening for depth-rated actuator candidates; not a selection or grip-force rating.
- [`pivot_hardware_basis.md`](pivot_hardware_basis.md) — manufacturer-referenced 8 mm shaft/retaining-ring interface review.
- [`mission_release_refresh.md`](mission_release_refresh.md) — current official resource status and task-source distinction.
- [`mission_mechanical_trial_matrix.md`](mission_mechanical_trial_matrix.md) — Videx's 22-row action-to-prototype trial matrix with interface evidence, measurements, and pass criteria left open until props are known.
- [`mission_task_map_review.md`](mission_task_map_review.md) — Videx's action-to-mechanism gaps and six prioritized prototype trials.
- [`drive_stop_module_review.md`](drive_stop_module_review.md) — Ipluvien Maximal's actuator, shaft, hard-stop, and guard review; current pin/slot is unsuitable for powered use.
- [`vehicle_interface_module_review.md`](vehicle_interface_module_review.md) — Scaevola's removable bridge concept and STEP integration checklist.
- [`coupon_export_review.md`](coupon_export_review.md) — Koriel Zeth's coupon export audit and the corrected separate print views.
- [`powered_stop_prototype_module.md`](powered_stop_prototype_module.md) — Cawl's replacement hard-stop architecture, load checks, required inputs, and staged bench gates.
- [`powered_stop_layout_study.scad`](powered_stop_layout_study.scad) and [`powered_stop_layout_preview.png`](powered_stop_layout_preview.png) — unpowered packaging visualization of a double-supported cross-pin and keyed, replaceable stop blocks; dimensions are illustrative only.
- [`replaceable_contact_prototype_module.md`](replaceable_contact_prototype_module.md) — Faustinius's pad/keeper/insert prototype and retention validation plan.

The remaining reviews are indexed in `brief.md`; they cover geometry, mounting, pads, stop hardware, actuation, and mission coverage.

## Current prototype limits

- STL files are unpowered geometry mockups. A `Simple: yes` mesh result does not certify a part for printing or loading.
- The OpenSCAD diagnostic views found no modeled jaw-body/frame overlap at six sampled poses through 45.456°, and no pad overlap at three closing poses. They do not test continuous motion, tolerances, props, or the vehicle.
- The actuator, coupling, shaft retention, pad fasteners, vehicle mount pattern, materials, and structural load path are not selected or qualified.
- The nominal pivot grooves use one manufacturer's DIN 471 size-8 reference dimensions. The circlip model itself is still a simplified profile and does not establish a selected part or load rating.
- M3 stainless threaded inserts in the pad rails are a fit-study candidate only. The host plastic/process and insert pullout strength have not been qualified; print and test the included retention coupon before loading the pad joint.
- Do not power the jaw against the modeled integral printed stop pin. Do not use the current tool as a load-rated or depth-rated assembly.
- No body/prop fit check, physical load test, pressure test, or wet mission trial has been completed.

Upload the complete vehicle `.step` / `.stp` assembly (or a SolidWorks Pack and Go ZIP) for the next integration pass. Include units, front/approach axis, structural mount datum, all eight thruster axes and guard solids, camera, sealed electronics housing and service path, foam, cable/tether routes, and any available practice-prop CAD. The STEP assembly is the chosen handoff format.

## Source material

The [MATE 2027 resource page](https://materovcompetition.org/2027) and [Explorer page](https://materovcompetition.org/explorer) were checked on 15 November 2026. MATE listed the full Explorer manual and Part 1 Product Demonstration as pending. The attached Floats preview is competition documentation for the float task; it is not an instruction to the assistant or a specification for the ROV gripper.

