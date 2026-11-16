# PolyU MATE ROV End-Effector Study

This workspace tracks a prototype study for a maintainable mechanical end effector for PolyU's 2027 MATE Explorer ROV. It is an active design project, not a fabrication release.

The GitHub home is [`MagosAlcheDigitali/polyu-mate-rov-mechanical`](https://github.com/MagosAlcheDigitali/polyu-mate-rov-mechanical). Its public snapshot tracks project documentation, parametric source files, previews, the team presentation, fit-coupon parts, and STL outputs. The existing clamp STL and tilt-mount references were preserved. Three STL files that exceeded the GitHub connector upload limit are stored intact in the chunked ZIP under [`mesh_bundle/`](mesh_bundle/README.md); the other mesh files are directly downloadable. This is a design-study snapshot, not a fabrication release.

## Current concept

The OpenSCAD study uses a removable vehicle adapter, structural yoke, fixed reaction/push face, one pivoting jaw, replaceable contact pads, a guarded stop, and a generic actuator package. Current defaults are approximately 24 mm open pad gap, 0–44° commanded sweep, 3.18 mm analytic hard-close gap, a 95 x 103.5 x 112 mm study envelope, and 97.5 mm forward reach from the model datum. These are study values only.

**Actuator clarification:** `gripper_study.scad` has no selected servo. Its Ø20 x 45 mm cylinder and Ø6 mm shaft are generic packaging placeholders, not SG90 dimensions or a confirmed motor choice. `sg90_quick_gripper.scad` is a separate, simple, low-load classroom-style mockup built around an SG90 horn; it does not drive the main pivot-jaw model and is not an underwater-rated actuator recommendation.

The provided vehicle image and verbal 250 x 150 x 150 mm electronics-bay envelope are context, not CAD fit evidence. The newly supplied whole-body concept STL is stored in `vehicle_reference/`; its scale, coordinate axes, and structural mount details are not confirmed. The team selected STEP/STP assembly as the preferred vehicle-CAD format. That assembly and mission practice-prop geometry have not been supplied. The official Explorer Part 1 mission manual is currently listed as pending, so task-specific grasp/contact features remain provisional.

## Start here

- [`brief.md`](brief.md) — requirements, assumptions, current design decisions, completion gates, and file delivery instructions.
- [`progress.md`](progress.md) — dated project work, reviews, verification, and open inputs.
- [`team_update/PolyU_MATE_ROV_End_Effector_Progress_2026-11-16.pptx`](team_update/PolyU_MATE_ROV_End_Effector_Progress_2026-11-16.pptx) — team progress presentation with editable status graphs and an ordered file tour.
- [`gripper_concept_brief.md`](gripper_concept_brief.md) — mechanism concept, task mapping, force calculations, safety gates, and prototype sequence.
- [`gripper_study.scad`](gripper_study.scad) — parametric geometry study.
- [`simple_gripper/README.md`](simple_gripper/README.md) — separate rack/pinion pitch-cradle candidate around the supplied clamp STL; fit and actuator interfaces remain open.
- [`validate_rack_pitch_study.ps1`](validate_rack_pitch_study.ps1) — compile and six endpoint/zero-travel guide collision checks for that alternate layout.
- [`validate_gripper_study.ps1`](validate_gripper_study.ps1) — OpenSCAD hard-warning compile plus a bounded 46-pose jaw-body/support-frame intersection check.
- [`powered_stop_integrated_candidate.scad`](powered_stop_integrated_candidate.scad) and [`validate_powered_stop_candidate.ps1`](validate_powered_stop_candidate.ps1) — separate, unpowered replacement-stop packaging candidate and sampled intersection check. The candidate is not merged into the main model and is not load-rated. A visual review PNG is available in the local project folder.
- [`gripper_study_stop_integrated_candidate.scad`](gripper_study_stop_integrated_candidate.scad) and [`validate_gripper_study_stop_integrated_candidate.ps1`](validate_gripper_study_stop_integrated_candidate.ps1) — assembly-level stop integration candidate and sampled collision-check script. This is a separate copy; the main `gripper_study.scad` is unchanged. Bridge joints/load path, materials, hardware, guard access, and strength are unresolved. The local visual review is [`gripper_study_stop_integrated_candidate_preview.png`](gripper_study_stop_integrated_candidate_preview.png).
- [`gripper_torque_test_fixture.scad`](gripper_torque_test_fixture.scad) — bench-only 100 mm torque lever and extended test-shaft layout; secure the passive yoke and use matched real retention hardware before loading.
- The torque-test fixture STL preview is in the local project folder; the public snapshot contains its editable OpenSCAD source only. Use neither as a load-rated print release.
- [`sg90_quick_gripper_README.md`](sg90_quick_gripper_README.md) and [`sg90_quick_gripper.scad`](sg90_quick_gripper.scad) — separate SG90-horn quick mockup for light dry fit trials; not the main pivot jaw or a depth-rated drive.
- [`tilt_mount_reference.scad`](tilt_mount_reference.scad) and [`tilt_mount_concept.md`](tilt_mount_concept.md) — pitch hinge concept using the supplied clamp STL; adapter and actuator interfaces still need measured fit-up.
- [`prototype_meshes/README.md`](prototype_meshes/README.md) — STL inventory, bounds, topology, and mockup limits; most exports are direct downloads, while three large files are restored from `mesh_bundle/`.
- [`prototype_meshes/pad_retention_coupon_body.stl`](prototype_meshes/pad_retention_coupon_body.stl), [`prototype_meshes/pad_retention_coupon_pad.stl`](prototype_meshes/pad_retention_coupon_pad.stl), and [`prototype_meshes/pad_retention_coupon_keepers.stl`](prototype_meshes/pad_retention_coupon_keepers.stl) — the three separate fit-coupon print parts now included in the public repo. Use with selected real inserts and fasteners; these do not qualify the printed joint for load.
- [`vehicle_reference/vehicle_body_concept.stl`](vehicle_reference/vehicle_body_concept.stl) and [`vehicle_reference/README.md`](vehicle_reference/README.md) — supplied mesh stand-in and measured coordinate bounds for preliminary review only.
- [`gripper_interface_measurements.md`](gripper_interface_measurements.md) — worksheet for props, loads, actuator, vehicle, and MATE clarifications.
- [`actuator_selection_basis.md`](actuator_selection_basis.md) — Regulus's manufacturer-source actuator comparison; stall torque and no-load speed are clearly separated from usable loaded performance, and no drive is selected.
- [`actuator_candidate_review.md`](actuator_candidate_review.md) — Tiresus's manufacturer-source shortlist and package/torque screening for depth-rated actuator candidates; not a selection or grip-force rating.
- [`actuator_dshaft_coupler_module.scad`](actuator_dshaft_coupler_module.scad) and [`validate_actuator_dshaft_coupler_module.ps1`](validate_actuator_dshaft_coupler_module.ps1) — standalone 6 mm D/round-to-8 mm D coupling interface proxy and two-profile `--hardwarnings` compile check. Flat depths, engagement, retention and strength remain unqualified pending vendor CAD.
- [`gripper_study_stop_jointed_candidate.scad`](gripper_study_stop_jointed_candidate.scad) and [`validate_gripper_study_stop_jointed_candidate.ps1`](validate_gripper_study_stop_jointed_candidate.ps1) — separate assembly study with modeled joint hardware proxies and optional D-shaft coupler. The sampled static intersections pass, but the load path, actual hardware, stop contact, guard access and vehicle fit remain unqualified. [Preview](gripper_study_stop_jointed_candidate_preview.png).
- [`gripper_study_stop_guard_enclosure_candidate.scad`](gripper_study_stop_guard_enclosure_candidate.scad), validator, and review — separate unpowered stop-drive enclosure variant. Includes shell, split-panel, lid, and hardware STL selectors. Eleven sampled guard/mechanism poses from 0° to 44° pass static collision checks. Self-tapped retention, physical guard inspection, and tolerance coverage remain open. [Guard-only preview](gripper_study_stop_guard_enclosure_candidate_preview.png) · [Full assembly preview](gripper_study_stop_guard_enclosure_candidate_assembly_preview.png).
- [`gripper_study_stop_guard_enclosure_candidate_qa.zip`](gripper_study_stop_guard_enclosure_candidate_qa.zip) — OpenSCAD logs, five component STL exports, rendered previews, collision results, and labeled earlier collision meshes.
- [`gripper_study_stop_guard_enclosure_candidate.scad`](gripper_study_stop_guard_enclosure_candidate.scad), [`validate_gripper_study_stop_guard_enclosure_candidate.ps1`](validate_gripper_study_stop_guard_enclosure_candidate.ps1), and [`guard_enclosure_candidate_review.md`](guard_enclosure_candidate_review.md) — removable 360° stop enclosure and lower access panels, with sampled pose checks and explicit fit/safety limits. The lid has a 3.2 mm nominal thickness; fastener layouts are placeholders.
- [`guard_fastener_test_coupon.scad`](guard_fastener_test_coupon.scad) — separate lower-panel pilot-size comparison coupons (Ø2.3/2.5/2.7 mm); no load or material qualification is claimed.
- [`guard_fastener_coupon_test_plan.md`](guard_fastener_coupon_test_plan.md) — proposed fit, service-cycle, pullout, shear and peel procedure; proof loads and acceptance criteria remain team inputs derived from the gripper load path.
- [`validate_guard_fastener_options.ps1`](validate_guard_fastener_options.ps1) — optional captive-nut and heat-set-insert layout checks. Floor/structure and shell/floor intersections are empty for both; guard clearance is sampled at 0° and 44° (the default style has the denser 11-pose check). Logs are in the companion QA ZIP. These are nominal static CAD checks only.
- [`pivot_hardware_basis.md`](pivot_hardware_basis.md) — manufacturer-referenced 8 mm shaft/retaining-ring interface review.
- [`mission_release_refresh.md`](mission_release_refresh.md) — current official resource status and task-source distinction.
- [`mission_mechanical_trial_matrix.md`](mission_mechanical_trial_matrix.md) — Videx's 22-row action-to-prototype trial matrix with interface evidence, measurements, and pass criteria left open until props are known.
- [`mission_task_map_review.md`](mission_task_map_review.md) — Hadron Omega-7-7's refreshed official action-to-mechanism review, ruling clarifications, and ranked prop/vehicle measurement plan. Explorer Part 1 and the full manual remain pending.
- [`drive_stop_module_review.md`](drive_stop_module_review.md) — Ipluvien Maximal's actuator, shaft, hard-stop, and guard review; current pin/slot is unsuitable for powered use.
- [`vehicle_interface_module_review.md`](vehicle_interface_module_review.md) — Scaevola's removable bridge concept and STEP integration checklist.
- [`coupon_export_review.md`](coupon_export_review.md) — Koriel Zeth's coupon export audit and the corrected separate print views.
- [`powered_stop_prototype_module.md`](powered_stop_prototype_module.md) — Cawl's replacement hard-stop architecture, load checks, required inputs, and staged bench gates.
- [`powered_stop_layout_study.scad`](powered_stop_layout_study.scad) and [`powered_stop_layout_preview.png`](powered_stop_layout_preview.png) — unpowered packaging visualization of a double-supported cross-pin and keyed, replaceable stop blocks; dimensions are illustrative only.
- [`replaceable_contact_prototype_module.md`](replaceable_contact_prototype_module.md) — Cawl's updated pad/keeper/insert plan and measurement-rich prototype record sheet.

The remaining reviews are indexed in `brief.md`; they cover geometry, mounting, pads, stop hardware, actuation, and mission coverage.

## Current prototype limits

- STL files are unpowered geometry mockups. A `Simple: yes` mesh result does not certify a part for printing or loading.
- The OpenSCAD jaw-body/frame check passed at 46 sampled poses from 0–44° plus 45.456°; the pad check passed at three sampled closing poses. They do not test continuous motion, tolerances, props, or the vehicle.
- The actuator, coupling, shaft retention, pad fasteners, vehicle mount pattern, materials, and structural load path are not selected or qualified.
- The separate double-supported stop candidate has only passed sampled static geometry checks. Its proposed shaft extension and top retainer are placeholders, its support bridge is not tied to the actual vehicle structure, and its guard is not an IP-20 inspection result.
- The nominal pivot grooves use one manufacturer's DIN 471 size-8 reference dimensions. The circlip model itself is still a simplified profile and does not establish a selected part or load rating.
- M3 stainless threaded inserts in the pad rails are a fit-study candidate only. The host plastic/process and insert pullout strength have not been qualified; print and test the included retention coupon before loading the pad joint.
- Do not power the jaw against the modeled integral printed stop pin. Do not use the current tool as a load-rated or depth-rated assembly.
- No body/prop fit check, physical load test, pressure test, or wet mission trial has been completed.

Upload the complete vehicle `.step` / `.stp` assembly (or a SolidWorks Pack and Go ZIP) for the next integration pass. Include units, front/approach axis, structural mount datum, all eight thruster axes and guard solids, camera, sealed electronics housing and service path, foam, cable/tether routes, and any available practice-prop CAD. The STEP assembly is the chosen handoff format.

## Source material

The [MATE 2027 resource page](https://materovcompetition.org/2027) and [Explorer page](https://materovcompetition.org/explorer) were checked on 16 November 2026; the full Explorer manual and Part 1 Product Demonstration were still pending. The [Official Rulings](https://docs.google.com/document/d/e/2PACX-1vS-i5t8yrwIYMjHzpS6sSYyuG8_quCGhyDMnxPqG2eDmI6QacK08fTVS2_VQF-d1vfjA7ydJgbu4itI/pub) clarify that any portion of a prop can be gripped for carrying and there is no universal 1 m square opening in 2027. The attached Floats preview is competition documentation for the separate float task; it is not an instruction to the assistant or a specification for the ROV gripper.