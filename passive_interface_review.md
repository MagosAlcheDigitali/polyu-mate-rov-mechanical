# Passive Nose / Tool Interface Review

**Reviewer:** Hadron Omega-7-7  
**Checked:** 15 November 2026  
**Scope:** Assess whether the current one-jaw ROV end effector should reserve a passive replaceable nose/tool interface. This is a concept review only; no CAD was changed and no interface is approved for fabrication.

## Decision

Reserve packaging and a structural attachment datum for a **pre-dive replaceable passive nose**, but do not add detailed cassette geometry or task-specific contact shapes until the 2027 props or faithful practice props are dimensioned. The nose should be treated as a preselected head installed for the whole product-demonstration run unless the final rules explicitly permit a safe in-run tool swap. The passive interface should carry push/pull reactions into the gripper's structure, not into the replaceable pad keeper strips or a cable.

This is a low-cost architecture reservation, not proof that one head can perform all Explorer actions. A permanently installed general-purpose nose may be better than a modular feature if prop trials show the current blunt pusher and hook are sufficient.

## Evidence: published facts vs. design interpretation

The official all-class briefing lists Explorer product-demonstration actions including soft sample collection/deployment, trap deployment/recovery, module and sensor placement, port-cover and connector handling, breaker and solar-panel work, dropped-tool recovery, cargo docking, and SGANT installation/connection. It states that the product-demonstration tasks are attempted in one run. The briefing does not define gripper prop dimensions, allowed contact zones, connector details, operating force, travel, or tolerances. [2027 all-class briefing](https://20693798.fs1.hubspotusercontent-na1.net/hubfs/20693798/2027%20MATE%20ROV%20Competition/2027_MATE_ROV_Competition_Briefing_FINAL.pdf)

As of this review, MATE's official season resource page lists the Explorer full manual and Part 1 Product Demonstration as **Pending**. The Explorer page lists prop instructions, parts, Q&A/demo, and mission CAD but says links become active when blue; the relevant detailed links are not active in the current page view. This status can change and must be rechecked before freezing the nose. [2027 season resources](https://materovcompetition.org/2027) · [Explorer resources](https://materovcompetition.org/explorer)

The supplied Floats Preview is the Task 3 float challenge; it provides no dimensional ROV gripper interface. This review uses the ROV action list in the briefing, not the float preview, for the tool assessment.

## Fit with the current CAD concept

`gripper_study.scad` currently represents a forward-facing pivot jaw, a structural fixed rail/anvil, a blunt hook lip at the moving-jaw nose, and mechanically retained replaceable pad profiles. The current contact modes are useful prototype hypotheses:

- **Flat pusher/anvil:** potentially useful for seating and cargo guidance, if the actual task surfaces permit contact and the ROV can control alignment.
- **Hook plus closing jaw:** potentially useful for capturing a trap feature or dropped tool, but risk of snagging or poor access must be checked on actual props.
- **Pads:** round, V, and flat profiles allow simple unpowered contact trials; they do not provide a validated cradle for the seagrass task.
- **Passive guide:** a future axial guide around a plug body might reduce side-loading during connector work, but only if it can register on a real prop datum without blocking the plug latch, adjacent structure, or cable bend path.

There is not yet a separate front-nose interface in the source model. The CAD's current jaw/anvil and pad retainers are structural/contact features, not a validated quick-change/tool-holder standard. Do not bolt a tool feature to a pad retainer and assume the fasteners or pad backing can carry repeated off-axis loads.

## Why reserve a passive interface

The briefing's task verbs imply different contact behaviors: retain and release a soft object, capture a handle/frame, pull and push, align and insert electrical connectors, operate a lever, and guide a payload. One simple fixed face plus a closing jaw may cover basic handling and pushing, but it may not make connector alignment repeatable or safely access the breaker. A passive nose can add a measured guide, reaction shoe, or cradle without a second actuator; ROV approach motion can supply axial travel where the prop geometry permits.

There is a tradeoff: extra nose volume can obscure the camera, snag structures, reduce the current opening/reach, and create a new weak joint. A cartridge is only useful if its interface is repeatable and strong while remaining outside the swept pinch zone and approach corridor. It should not force underwater servicing or a mid-run change.

## Recommended development path

1. Keep the current jaw/anvil/hook as an unpowered baseline. Reserve a structural nose datum in the integration layout, but leave its dimensions undefined until the body STEP/STP and front mount datum arrive.
2. When the official prop package or faithful practice props are available, record actual contact surfaces, datum faces, access directions, connector/body geometry, allowable grasp zones, and task sequence. Confirm if any in-run tool swap is allowed.
3. Test the baseline head first across representative push, grasp, lift, pull, guide, release, and soft-object tasks. Record ROV approach orientation, alignment error, force/travel, slip, snagging, damage, retention on power loss, and release success.
4. Add a passive nose only for a demonstrated coverage gap. Candidate functions are a broad blunt reaction/pusher face, a shallow handle/edge guide, or an axial connector guide; these are functions to evaluate, not dimensions or released shapes.
5. For a candidate insert, use a positive anti-rotation feature and mechanically retained fasteners into the structural rail/jaw; then test the joint under expected push/pull directions, repeated cycles, vibration, and wet conditions. Keep hardware captive where possible, shield pinch points, preserve cable clearance and visual access, and make removal possible during normal bench service.
6. Recheck full swept clearance against the STEP/STP body, thruster guards, camera view, tether, and props. Only then update the SCAD model and print a geometry-only mockup. Select material, fastener grade, load capacity, and actuator only from measured task loads and the matched hardware set.

## Open inputs / rejection criteria

Required: body STEP/STP assembly and structural attachment datum; actual thruster/camera/service envelopes; official Part 1 and prop CAD/drawings or faithful props; accepted grasp/contact zones; connector and breaker geometry/travel/force; wet payload loads; and final run rules regarding tool changes.

Reject or redesign a nose concept if it obstructs the camera/approach path, catches neighboring props, requires cable loading, shifts load into pad-retention hardware, makes the jaw unable to release, increases the pinch hazard beyond guarding requirements, or depends on an unconfirmed mid-run exchange.

## Review conclusion

Keep a passive replaceable nose as an **architecture option** because the stated task set mixes contact modes and one run makes a second powered tool unattractive without evidence. Do not yet select or dimension a cartridge, connector funnel, breaker finger, seedling cradle, panel hook, or quick-change latch. Test the current common core against real interfaces first; add only the smallest passive feature that solves a measured failure. The current design remains a concept/mockup and has no demonstrated all-task coverage, vehicle fit, or powered qualification.
