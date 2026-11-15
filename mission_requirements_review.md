# 2027 Explorer End-Effector Requirements Review

**Review date:** 14 November 2026  
**Reviewer:** Cawl  
**Scope:** Mechanical requirements for the ROV end effector only.  
**Evidence level:** The released all-class briefing names task actions; it does not define prop interfaces. Statements below are separated into published requirements and engineering implications.

## Official release refresh — 14 November 2026

I rechecked the live MATE 2027 season resource page, the Explorer resources page, the all-class Product Demo and Specs Briefing, and the linked public Q&A forum. The season page still lists the full Explorer manual and Part 1 Product Demonstration as **Pending**. The Explorer page still says resource links turn active when blue; prop instructions, parts lists, demonstration/Q&A, and mission-prop CAD are listed but not linked. The all-class briefing remains the only public source found that describes the Explorer product-demonstration task actions. The forum landing page is public, but opening Categories redirects to login; public search did not surface task-specific 2027 answers. This is an access/search limitation, not proof that no participant-only answers exist. [Season resources](https://materovcompetition.org/2027) · [Explorer resources](https://materovcompetition.org/explorer) · [Q&A forum](https://materovcomp.discourse.group/)

The briefing says the complete competition manual would be released in November 2026; on this review date its official resource page still shows it as pending. Therefore, do not treat this review as final task sizing. Recheck the release page and forum after Part 1 becomes available.

## What the supplied preview covers

The supplied MATE Floats preview is explicitly **Task 3: The Vertical Game**. It describes designing, deploying, and operating a profiling float with a buoyancy engine, depth-hold, sensor sampling, and surface communications. At the World Championship this float station is separate from the ROV product-demonstration station. The preview gives no ROV gripper contact geometry or tool interface. Therefore, it must not be used to size the ROV gripper. [Official Task 3 preview PDF](https://20693798.fs1.hubspotusercontent-na1.net/hubfs/20693798/2027%20MATE%20ROV%20Competition/2027%20MATE%20Documentation/2027%20MATE%20Floats%20Preview%20Mission_EXPLORER_FINAL.pdf)

## Published ROV product-demonstration actions

The all-class briefing states that product-demonstration tasks are attempted in one run. It lists these actions relevant to a mechanical tool: [Official 2027 Product Demo and Specs Briefing](https://20693798.fs1.hubspotusercontent-na1.net/hubfs/20693798/2027%20MATE%20ROV%20Competition/2027%20MATE%20Documentation/2027_MATE_ROV_Competition_Briefing_FINAL.pdf)

| Task | Explicit action in the briefing | Mechanical implication — engineering inference, not a published interface requirement |
|---|---|---|
| Task 1 — Seagrass | Collect seagrass from a healthy bed; deploy seedlings in designated locations. | Provide a gentle way to capture, carry, and release the sample. The briefing does not say whether the safe contact is a carrier, root holder, or plant itself. Do not assume foliage is a safe grasp point; inspect the sample and confirm permitted contact. |
| Task 1 — Green crab | Deploy a new crab trap; return the old trap to the pool side. | A hook or clamp may retain a handle/bar during transport. Trap dimensions, handle features, submerged load, and release motion are unspecified. |
| Task 1 — Primary node and generator | Install the primary node. For Explorer, remove the generator-port cover and install the power connector. | The tool may need to transport/orient the node, pull a cover, and hold a plug body for axial insertion. The briefing gives no cover latch, connector key, insertion force, stroke, or allowed grasp zones. |
| Task 1 — Pressure/tilt sensor | Install sensor in its location, connect it to the primary node, and level it (leveling applies to Explorer/Pioneer/Ranger). | Requires controlled placement/orientation and cable/connector handling. Mount geometry, allowable seating force, leveling tolerance, and connector details are unspecified. |
| Task 2 — Solar panel | For Explorer, disengage the breaker, unplug main power, remove and replace the damaged panel, reconnect power, and re-engage the breaker. | A broad pusher or blunt hook may operate controls; the panel may need a padded edge grip; plugs should be aligned and pushed/pulled by their bodies. Breaker travel/force, panel retention, grasp points, connector type, and cable slack are unspecified. |
| Task 2 — Dropped tool | Secure and return the tool, either before it hits the bottom or after it lands. | Provide a quick capture plus retention during return; after-bottom access and approach direction matter. Tool geometry, orientation, and submerged weight are unspecified. |
| Task 2 — Cargo docking | Maneuver the cargo payload into a docking bay; manual operation is permitted for all classes. | A blunt pusher/alignment face may be sufficient; gripping is needed only if the actual payload exposes a safe capture feature. Docking clearance and permitted contact surfaces are unspecified. |
| Task 2 — SGANT | Install the new antenna; for Explorer, connect power and communications. | Carry/orient/seat the antenna and handle two links without loading the cables. Mount, approach axis, connector keying, and allowable forces are unspecified. |

Tasks such as imaging, visual identification, hurricane data work, and autonomous midwater analysis are also in the mission, but they do not establish a gripper interface. Do not add mechanical features for them without a specific task contact requirement.

## Published vehicle constraints that affect tool design

The all-class briefing gives the Explorer vehicle a 48 V, 30 A supply; any conversion to lower voltage must occur onboard. It permits pneumatic/hydraulic systems subject to the complete manual specifications, requires operation to 6 m at the World Championship, and sets a 22 kg maximum vehicle weight. The complete ROV and tools are included in size and weight measurement; any single ROV dimension over 1 m is disallowed, and all ROV systems must be safely hand-launchable. These are system-level requirements, not a gripper-force specification. A longer/wider tool or high-mass actuator directly spends vehicle size/weight margin, while a motor driver or voltage converter belongs on the vehicle if the selected actuator needs a lower voltage. [Official briefing, Explorer specifications and size/weight rules](https://20693798.fs1.hubspotusercontent-na1.net/hubfs/20693798/2027%20MATE%20ROV%20Competition/2027%20MATE%20Documentation/2027_MATE_ROV_Competition_Briefing_FINAL.pdf)

## What remains unavailable

As checked on 14 November 2026, MATE's 2027 season page marks the full Explorer manual and Part 1 Product Demonstration manual as **Pending**. Prop-building instructions, parts lists, prop demonstration/Q&A, and prop CAD appear as headings without active Explorer downloads on that page. The Explorer resource page says links turn blue when active; only the preview and all-class briefing are currently linked in the mission section. [2027 season resource/release status](https://materovcompetition.org/2027) · [Explorer resource page](https://materovcompetition.org/explorer)

Consequently, the briefing does **not** establish: prop dimensions; grasp/contact zones; connector or latch types; push/pull forces; travel; tolerances; cable bend radius; payload mass/buoyancy; or accepted allowable squeeze on delicate samples. Treat all contact geometry and actuator sizing as provisional until official prop CAD/drawings or physical practice props are available.

## Actionable concept implications

1. Start with one forward-facing powered clamp with a fixed broad reaction/push face, a blunt capture hook, and mechanically retained replaceable round/V/flat pads. This is an engineering choice for breadth, not a MATE specification.
2. Let the ROV provide approach and axial insertion motion. The gripper should retain and orient connector bodies; avoid using cables as pulling points. Add keyed connector guides only after the real plug geometry and insertion loads are known.
3. Keep soft-pad squeeze adjustable/limited for the seagrass sample and panel edges. Measure minimum holding force separately from maximum safe compression.
4. Test both dropped-tool cases, trap carry/release, sample handling, cover/breaker operations, connector insertion, panel removal/replacement, and payload docking against real props or faithful replicas.
5. Since the briefing places product-demo tasks in one run, avoid making an underwater tool swap a prerequisite. This is an inference from the run structure, not an explicit prohibition on changing tools.
6. Keep the working area visible to the forward camera and preserve full-stroke clearance to thruster guards and the tether. These are integration recommendations; exact vehicle geometry must come from the team's body CAD.

## Source links

- [2027 Product Demo and Specs Briefing (official PDF)](https://20693798.fs1.hubspotusercontent-na1.net/hubfs/20693798/2027%20MATE%20ROV%20Competition/2027%20MATE%20Documentation/2027_MATE_ROV_Competition_Briefing_FINAL.pdf)
- [2027 MATE Floats Preview Mission — Explorer (official PDF)](https://20693798.fs1.hubspotusercontent-na1.net/hubfs/20693798/2027%20MATE%20ROV%20Competition/2027%20MATE%20Documentation/2027%20MATE%20Floats%20Preview%20Mission_EXPLORER_FINAL.pdf)
- [2027 season resources and manual status](https://materovcompetition.org/2027)
- [Explorer resources](https://materovcompetition.org/explorer)
