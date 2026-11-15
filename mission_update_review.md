# 2027 MATE Explorer Mission Update Review

**Reviewer:** Ipluvien Maximal  
**Checked:** 14 November 2026  
**Scope:** Current official release status and the Explorer product-demonstration actions that could affect a general-purpose ROV end effector. This review does not treat the supplied Task 3 float preview as a gripper specification.

## Official release status

The MATE 2027 season resource page currently lists the Explorer full manual and Part 1 Product Demonstration as **Pending**. Explorer Part 2 Vehicle Design & Building Specifications, Part 3 Competition Rules, Part 4 Engineering & Communication, and Part 5 Submission Guidelines are available. The all-class Product Demo and Specs Briefing is available, while the 2027 prop-building instructions, parts lists, prop demonstration/Q&A, and mission CAD are headings without active linked documents on the resource page. The Explorer class page also lists the mission and prop resources, but those links are not active yet. Check these pages again before freezing the gripper because release status can change.

Sources: [2027 season resources](https://materovcompetition.org/2027), [Explorer class resources](https://materovcompetition.org/explorer).

## Public Q&A check

On 14 November 2026, the official forum link was checked for task-interface clarifications. The forum landing page describes its staff-answered mission/specification Q&A, but opening the category list redirected to a login page; public search surfaced no task-specific 2027 answers. This does **not** establish that no answers exist. The team should check the forum using its participant access and record any official responses before freezing contact geometry. [Forum landing page](https://materovcomp.discourse.group/), [official 2027 resource page](https://materovcompetition.org/2027).

## Official task statements relevant to hardware

The briefing states that **all product-demonstration tasks are attempted in one product-demonstration run**. Explorer-relevant actions explicitly listed include:

| Mission action in the briefing | Mechanical interaction implied by the action (inference) |
|---|---|
| Collect seagrass and deploy seedlings at designated locations | Retain a soft or irregular plant/sample without crushing it; release it at a target. A broad, replaceable compliant contact may help. |
| Deploy a new crab trap; return the old trap to the surface/side of pool | Capture a handle or frame securely, tolerate orientation error, and carry a larger load without slipping. |
| Install the primary node; install a pressure/tilt sensor and connect it to the node; level the sensor | Hold and orient rigid packages; provide a flat push/contact face; allow ROV motion to position parts. Cable routing and the actual level interface remain unspecified. |
| Remove a generator-port cover and install a power connector | Pull or lift the cover, then align and insert a connector without side-loading it. Exact connector and latch mechanics are not published in the briefing. |
| Disengage a breaker; unplug and plug solar-array main power; remove and install a replacement solar panel; re-engage breaker | Some combination of pushing, pulling, connector alignment, and controlled lever actuation. The briefing does not provide operating forces or travel. |
| Recover a dropped tool before or after it hits bottom, then return it to the surface/side of pool | Secure a potentially awkward tool while moving; the after-bottom case requires capture from a resting orientation. |
| Maneuver cargo payload into a docking bay (manual option; Explorer also has an autonomous option) | Push and guide a payload with a stable reaction surface; avoid geometry that snags on the bay. |
| Install a new SGANT; connect its power and communications link | Grip and orient an assembly and support connector insertion. Mounting and connector details are still unpublished. |

The briefing's Task 3, “The Vertical Game: MATE Floats!”, is a separate float design/build and profiling mission. It does not specify an ROV gripper interface. The attached Floats Preview PDF should therefore be treated as context for the team’s separate float work, not as the source of jaw dimensions or gripper force requirements.

Primary source: [2027 Product Demo and Specs Briefing](https://20693798.fs1.hubspotusercontent-na1.net/hubfs/20693798/2027%20MATE%20ROV%20Competition/2027%20MATE%20Documentation/2027_MATE_ROV_Competition_Briefing_FINAL.pdf), especially its design brief on pages 5–6.

## Design implications and limits

1. The official list spans soft samples, framed objects, hand tools, panels, levers, and electrical connectors. A pivot jaw with a blunt fixed face and interchangeable contact pads is a reasonable **prototype hypothesis** for capture, push, and limited pulling, but the briefing does not establish that it can do all tasks.
2. Connector engagement and breaker operation are alignment/actuation tasks. The current concept has no compliant axial connector guide, calibrated insertion stop, rotary tool, or verified lever-contact geometry. These need real prop details before the design can claim coverage.
3. Because the task set is attempted in one run, every tool-change assumption must be checked against run rules and the actual task sequence. A single jaw head may need to handle multiple contact modes; do not assume a topside or in-water tool swap is allowed.
4. No target sizes, permitted grasp zones, loads, connector standards, insertion forces, cover latches, or prop construction dimensions are specified in the available briefing. Treat all such values as unknown until the Part 1 manual, prop instructions/CAD, Q&A/rulings, or faithful practice props provide evidence.
5. The Explorer briefing states 48 V / 30 A vehicle power, lower-voltage conversion onboard, a world-championship depth of up to 6 m, and allows pneumatics/hydraulics subject to the complete manual. These are vehicle-level requirements and do not select an actuator or qualify this end effector; actuator power, enclosure, and depth qualification still need design work.

## Recommendation for the next design iteration

Keep the existing jaw/anvil/hook as an unpowered geometry study. Add a mission-contact matrix to the CAD brief, then design test coupons or mock props for: (a) soft sample retention/release, (b) frame/handle capture and lift, (c) flat-face push and guided placement, (d) breaker/cover lever contact, and (e) connector alignment/insertion. Once official prop dimensions arrive, prioritize the highest-risk connector and panel interfaces and decide whether the head needs a compliant guide or a second tool. Measure wet forces and contact damage on practice props before selecting actuator torque or releasing the stop design.
