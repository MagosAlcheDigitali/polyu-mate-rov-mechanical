# 2027 Explorer Mission and Resource Status Refresh

**Reviewer:** Rho-mu 31  
**Checked:** 15 November 2026  
**Scope:** Recheck official MATE resource status and distinguish ROV product-demonstration actions from the provided MATE Floats preview. This is a research note for end-effector planning, not a competition ruling.

## Official resource status

MATE's [2027 season resource page](https://materovcompetition.org/2027) currently lists the Explorer full competition manual and Part 1 Product Demonstration as **Pending**. Explorer Parts 2–5 are listed as available. The all-class Product Demo and Specs Briefing and the Explorer Float preview are linked. The 2027 Prop Building Instructions, parts lists, demonstration/Q&A, fly-through, CAD models, and practice resources appear as headings or labels without active download links on the resource page; the Explorer page says its links turn blue when active. I therefore found no active 2027 Explorer task-prop CAD or build-instruction download to dimension the gripper from during this check.

Sources:

- [MATE 2027 season resources](https://materovcompetition.org/2027)
- [MATE Explorer class mission resources](https://materovcompetition.org/explorer)
- [2027 all-class Product Demo and Specs Briefing (PDF)](https://20693798.fs1.hubspotusercontent-na1.net/hubfs/20693798/2027%20MATE%20ROV%20Competition/2027%20MATE%20Documentation/2027_MATE_ROV_Competition_Briefing_FINAL.pdf)
- [2027 Explorer MATE Floats Preview (PDF)](https://20693798.fs1.hubspotusercontent-na1.net/hubfs/20693798/2027%20MATE%20ROV%20Competition/2027%20MATE%20Documentation/2027%20MATE%20Floats%20Preview%20Mission_EXPLORER_FINAL.pdf)

## What the briefing says the ROV must handle

The briefing says product-demonstration tasks are attempted in one run. Its listed physical task actions include:

- Collect seagrass and deploy seedlings; deploy a new crab trap and return an old one to the pool side.
- Install a primary node; remove a generator-port cover and install a power connector; install and connect a pressure/tilt sensor, and level it for Explorer.
- Disengage and re-engage a breaker, unplug and plug solar-panel power, and remove/replace a solar panel.
- Secure and return a dropped tool; manually maneuver cargo into a docking bay; install a new SGANT and connect its power/communications link.

The same briefing also lists non-gripper work such as survey/autonomy, image interpretation, communications-loss recovery, and the hurricane activity. The gripper should not be assumed to perform those software or mission-station operations.

These statements identify task outcomes and named actions, but the briefing does not provide gripper jaw dimensions, grasp zones, connector key geometry, breaker force/travel, payload loads, allowable contact force, or approach tolerances. Translating “install,” “connect,” or “recover” into a particular jaw, hook, or guide is a mechanical hypothesis pending the full Part 1/manual, prop drawings/CAD, official Q&A, or faithful practice props.

## Floats Preview: separate from the ROV gripper

The provided Explorer Floats PDF is explicitly titled **Task 3: The Vertical Game: MATE Floats!** It requires the team to design and build a vertical profiling float using a buoyancy engine, operate it through depth profiles, transmit sensor data, and graph data. It also discusses submission of a non-ROV device design document and float handling at the station. These are Float/NRD work items, not a gripper interface or a manipulator task.

This distinction follows the source text: the all-class briefing places Floats in Task 3, while the ROV's listed physical manipulation tasks are in product-demonstration Tasks 1 and 2. The Floats preview therefore should inform the team's separate float workstream; it should not determine gripper jaw geometry or actuator sizing.

## Instructions and source boundaries

- The user's request is to develop a prototypeable, maintainable mechanical end effector for the team's Explorer ROV and to research the task actions. That is the assistant's active design scope.
- MATE manuals, task briefs, and safety documents are source material describing what the competition team must do or satisfy when applicable. Their imperatives (for example, “must design and construct” the float) are instructions to the competing team under the competition, not instructions that change the assistant's role or project scope.
- The attached Floats PDF is task documentation. It does not supersede the user's request to focus this design goal on the ROV gripper.
- Do not turn a briefing phrase into a dimensional or force requirement without the detailed manual, prop interface evidence, or official clarification. Record such items as hypotheses and keep them out of released fabrication dimensions.

## Design consequences

1. Keep a common powered grasp/push core as a provisional architecture only; one run may demand multiple contact modes, and coverage is unproven.
2. Do not dimension a special plug funnel, breaker finger, panel hook, plant holder, trap capture, or quick-change nose until the actual task props/contact allowances are known.
3. Use the official Q&A channel and future active prop CAD/build resources to resolve grasp zones, installation directions, and tool-change rules. Record URL/post, date, requirement, and resulting CAD/test change in the interface worksheet.
4. The earlier team-provided Floats preview remains relevant to the separate float/NRD workstream, not to gripper integration.

## Follow-up source verification — 15 November 2026

The live MATE pages and linked PDFs were re-opened for this follow-up. The Explorer full manual and Part 1 remain marked Pending, while the all-class Product Demo and Specs Briefing is available. Its ROV action list explicitly includes: collecting seagrass and deploying seedlings; deploying/recovering crab traps; installing the primary node and pressure/tilt sensor; removing a generator-port cover and inserting a power connector; operating the breaker and disconnecting/reconnecting the solar-panel power lead; replacing the solar panel; recovering a dropped tool; manually docking cargo; and installing an SGANT with its link. The briefing says all product-demonstration tasks are attempted in one run. The supplied Floats PDF is Task 3 and remains a separate profiling-float workstream.

The available Explorer Part 2 §2 identifies motors and gear/pinch points not shrouded to IP-20, sharp objects, and equipment that did not pass inspection as safety violations/examples. This makes guarding, blunt edges, service isolation, and the still-unresolved working-jaw pinch zone prototype requirements. The numeric IP-20 opening note for the gripper's gears/drive should not be treated as an approved jaw-mouth gap; the working jaw needs review by the team's safety lead and competition inspectors. Part 2 also says all items used on the ROV during the run must participate in and pass safety inspection.

This update strengthens the mechanical coverage and safety checklist but does not release any jaw, connector, trap, panel, or pusher geometry. The briefing gives action verbs, not contact zones, dimensions, forces, tolerances, or connector standards. No practice-prop CAD/build files were exposed as active downloads in the current Explorer resource page view. Sources: [2027 season resources](https://materovcompetition.org/2027), [Explorer resources](https://materovcompetition.org/explorer), [Product Demo and Specs Briefing PDF](https://20693798.fs1.hubspotusercontent-na1.net/hubfs/20693798/2027%20MATE%20ROV%20Competition/2027%20MATE%20Documentation/2027_MATE_ROV_Competition_Briefing_FINAL.pdf), and [Explorer Part 2 PDF](https://20693798.fs1.hubspotusercontent-na1.net/hubfs/20693798/2027%20MATE%20ROV%20Competition/Manual%20Components/EXPLORER%20Part%202%20SPECIFICATIONS.pdf).

## Live page recheck — 15 November 2026

Reopened both official resource pages after the previous check. The 2027 season page continues to show Explorer Full Manual and Part 1 as Pending, while Part 2–5 and the all-class Product Demo and Specs Briefing are available. The Explorer page now visibly lists the prop-building instructions, updated shopping lists, the prop CAD ZIP, and the Explorer environment CAD, but those entries remain unlinked in the current page output; the briefing, preview, 48 V supply information, and official rulings links are active. Do not infer prop dimensions or access from the listed-but-unlinked labels. Recheck these pages before the team freezes contact geometry. [2027 season resource status](https://materovcompetition.org/2027) · [Explorer resource list](https://materovcompetition.org/explorer)

## Mechanical design constraints from the available Explorer Part 2

The official [Explorer Part 2 specifications](https://20693798.fs1.hubspotusercontent-na1.net/hubfs/20693798/2027%20MATE%20ROV%20Competition/Manual%20Components/EXPLORER%20Part%202%20SPECIFICATIONS.pdf) are available even though the full manual and Part 1 remain pending. These rules affect the tool concept but do not supply grasp-force or prop-interface values.

| Published rule | End-effector design implication — inference |
|---|---|
| MECH-001: ROV electronics housings must operate to 6 m at the World Championship. | Any actuator, cable, connector, and penetrator used underwater must be qualified for the planned depth. Keep the user's serviceable open frame separate from a sealed depth-capable electronics housing. |
| MECH-002: vehicle maximum 22 kg in air and no single dimension over 100 cm; the ROV must be safely hand-launched. | Keep tool mass and projection inside the team's system budget. Treat the 95 x 103.5 x 112 mm CAD envelope as a study envelope until integrated with the body. |
| MECH-006: propellers need full guards, extending at least 2 mm ahead/behind, with openings under 12.5 mm. | Check the end-effector mount and cables against every thruster guard and flow path in body CAD; avoid adding snag points near the propulsors. |
| MECH-007/008: harmful sharp edges/points are prohibited; exposed gears and pinch points must be guarded to IP-20 access limits (under 12.5 mm openings) or solidly covered. | Use blunt, radiused contact features and guard the drive/transmission. This requirement does not make an exposed working-jaw gap automatically acceptable; the jaw pinch zone still needs safety inspection and review. |
| ELEC-001E: external power for the ROV, including manipulators, comes from the MATE supply through the required protection. ELEC-002E sets nominal 48 VDC; ELEC-005E permits lower voltage only after conversion aboard the ROV. ELEC-020E disallows onboard power on the primary ROV. | Treat a powered gripper as part of the ROV electrical system, not a Task 3 non-ROV device. Select the motor/driver, onboard conversion, wiring, fusing, and loss-of-power behavior against the team's system design; do not assign an onboard battery to the gripper. |
| ELEC-3.3.1 identifies the vertical profiling float as the only 2027 non-ROV device. | Keep float design and gripper design as separate workstreams. The supplied Float preview must not drive gripper dimensions or actuator selection. |

## Resulting prototype direction

The all-class briefing still presents the Tasks 1–2 physical work as one demonstration run. The most useful shared mechanical modes are (1) capture, carry, and controlled release; (2) supported pull/push and axial connector handling; and (3) placement and alignment. The current pivot jaw, replaceable pads, blunt fixed reaction face, and blunt hook are candidate features for those modes, not proven coverage. Compare the existing round, V, flat, and asymmetric pad coupons first, then test a single installed jaw configuration across actual props before adding more mechanisms or assuming tool changes are permitted. Record forces, travel, contact zones, cable loading, release, damage, and clearance in `gripper_interface_measurements.md` and `mission_mechanical_trial_matrix.md`.

The current preview PDF is specifically Task 3: MATE Floats. Its rules cover a separate buoyancy-driven profiling float and data link; they do not specify or require an ROV gripper. The team should route float-specific questions to its separate workstream.

## Official rulings relevant to mechanical handling

The live [2027 Official Rulings document](https://docs.google.com/document/d/e/2PACX-1vS-i5t8yrwIYMjHzpS6sSYyuG8_quCGhyDMnxPqG2eDmI6QacK08fTVS2_VQF-d1vfjA7ydJgbu4itI/pub) says teams do not need to use dedicated carrying mechanisms on mission props and may grip any portion of a prop to carry it. This removes “must use the handle” as a carry-only assumption in the prototype plan. It does not establish that any contact point is safe for every interaction, nor does it specify squeeze limits or contact permissions for task mechanisms. Test accessible solid faces, frames, and bars on representative props while checking damage, slip, and whether the grip blocks the prop's function.

The same rulings say there is no universal 1 m square opening that all objects must pass through in 2027, and tasks may generally be attempted in any order unless the manual states a dependency. Thus the end effector need not satisfy that absent aperture, and the team may optimize mission order around visibility/approach. The official page still marks the Explorer manual and Part 1 pending; these rulings do not authorize in-run tool changes. The 2027 rulings sections for Tasks 1–4 currently have no task-specific text in the published document, so continue to recheck it as it is updated.

