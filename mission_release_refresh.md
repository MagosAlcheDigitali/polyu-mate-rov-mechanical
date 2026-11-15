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

