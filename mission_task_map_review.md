# Explorer End-Effector Task Coverage Review

**Original reviewer:** Videx; **refresh:** Hadron Omega-7-7  
**Checked:** 16 November 2026  
**Scope:** Mechanical task coverage for the current one-DOF pivot-jaw study. This review separates MATE's published task actions from mechanical design inferences; it is not a prop-interface or safety approval.

## Official evidence and limits

As rechecked on 16 November 2026, MATE's 2027 page marks the Explorer Full Competition Manual and Part 1 Product Demonstration as pending. The all-class Product Demo and Specs Briefing and the Explorer Floats preview are linked and available. The Explorer resource page lists prop instructions, parts lists, Q&A, mission CAD, and practice resources, but those entries remain unlinked in the page output; do not infer prop geometry from their titles. The briefing's Explorer tasks are therefore a provisional task-action source, not a set of grasp dimensions, allowed contact zones, loads, travels, tolerances, connector standards, or final ordering rules. [2027 resource status](https://materovcompetition.org/2027) · [Explorer task resources](https://materovcompetition.org/explorer) · [Product Demo and Specs Briefing PDF](https://20693798.fs1.hubspotusercontent-na1.net/hubfs/20693798/2027%20MATE%20ROV%20Competition/2027%20MATE%20Documentation/2027_MATE_ROV_Competition_Briefing_FINAL.pdf)

The supplied Floats Preview concerns Task 3 and does not specify the ROV gripper. The mechanical manipulator review here concerns the Task 1 and 2 product-demonstration actions.

## Action-to-mechanism coverage

| Published ROV action | Mechanical mode inferred for prototyping | Current concept evidence / gap |
|---|---|---|
| Collect seagrass; deploy seedlings in designated locations | Gentle pickup, carry, position and release; avoid grabbing foliage unless the prop defines it as the interface | A padded clamp may grip a carrier/base, but allowable grasp zone and squeeze limit are unknown. Current CAD has no compliant force control or validated seedling cradle. |
| Deploy a new crab trap; return an old trap to the pool side | Capture a handle/bar or frame and retain the trap during vehicle translation, turns and lifting | Blunt hook plus V/round pad is plausible for a bar/handle. No handle size, submerged load, catch orientation, or snag/release evidence exists. |
| Install primary node; install pressure/tilt sensor, connect it to node, and level sensor for Explorer | Hold and orient the module; push along its mounting axis; provide an alignment reaction and access to a connector | Clamp and fixed face provide only a grasp/push hypothesis. No known target datum, allowable misalignment, seating load/travel, leveling tolerance, or electrical connection sequence. |
| Remove generator-port cover; insert power connector into port | Pull against a cover lip/handle, then guide and push a keyed plug axially | Hook/pusher could provide reactions, but there is no plug funnel/key guide. Grasp must act on the plug body; cable cannot serve as a pull handle. |
| Disengage breaker; unplug/replug solar-array main power; remove/install replacement panel; re-engage breaker | Access and actuate a lever, perform axial plug work, and capture/seat a panel frame | Blunt hook/pusher and flat pad are hypotheses. The jaw may block lever travel or damage the panel edge. Lever direction, connector, panel handles and approach clearances are unknown. |
| Recover dropped tool before or after it hits the bottom; return it to the pool side | Acquire a free-water or resting tool, retain it under carry loads, then release | Hook/clamp could hold a handle or shaft. Floor clearance, tool orientation, contact zone and loss-of-power behavior are unverified. |
| Maneuver cargo payload into docking bay | Push and guide payload into the bay; grasp only if the detailed instructions require it | Broad fixed face is a reasonable push hypothesis. Docking clearance, contact surfaces, final seated condition and whether gripping is needed are unknown. |
| Install SGANT; connect power and communications link | Hold and orient the antenna/base and guide connector insertion | Clamp could carry an assembly but there is no repeatable orientation datum or connector guide; the allowable mast/base grip and cable path are unknown. |

The official briefing also includes image interpretation, survey/autonomy, hurricane mapping, communications-loss recovery and the separate float task. Those are vehicle, software, mission-station or NRD functions rather than a demonstrated gripper requirement; the gripper must not be credited with performing them.

## Architecture implications

**Ruling follow-up — 15 November 2026:** MATE's [Official Rulings](https://docs.google.com/document/d/e/2PACX-1vS-i5t8yrwIYMjHzpS6sSYyuG8_quCGhyDMnxPqG2eDmI6QacK08fTVS2_VQF-d1vfjA7ydJgbu4itI/pub) state that teams may grip any portion of a mission prop to carry it; dedicated carry mechanisms are optional. For traps, tools, panels, nodes, and SGANT, do not make a handle the only candidate carry interface. This does not remove task-specific interaction requirements (such as unlatching, connecting, planting, or seating) and does not establish that all prop surfaces can safely be squeezed.

**Order clarification — 16 November 2026:** the official rulings say teams may generally attempt tasks in any order and move between tasks, except where the manual uses sequencing language such as “first,” “before,” or “after.” Therefore, do not use the briefing's “one product-demonstration run” sentence to assume that every task must be performed in a fixed linear sequence. Keep the tool installed for representative full-run trials, but confirm any required task order in the eventual Explorer Part 1/manual. The rulings also allow any prop portion to be used for carrying; that clarification applies to carry contact, not the distinct operation needed to open a cover, connect a plug, actuate a breaker, install an item, or seat cargo. Source: [Official Rulings for the 2027 MATE ROV Competition](https://docs.google.com/document/d/e/2PACX-1vS-i5t8yrwIYMjHzpS6sSYyuG8_quCGhyDMnxPqG2eDmI6QacK08fTVS2_VQF-d1vfjA7ydJgbu4itI/pub).

The single pivot jaw and fixed face can be a common grasp/push core for early trials. The task list spans gentle object handling, high-retention transport, axial insertion/removal, lever motion, edge handling and guided docking. That combination does not establish that one fixed jaw profile will serve every prop.

Keep the nose attachment capable of accepting a passive bolt-on contact tip, but do not finalize a tip shape or assume in-run tool swapping is allowed. Because the product-demonstration actions are attempted within one run, test one installed configuration across a representative run; the official rulings allow flexible task order unless the detailed manual specifies sequencing. Prefer to keep the gripper, pusher and alignment features on the vehicle simultaneously if trials show that the task approaches overlap. Do not add a second actuator based on action wording alone; determine whether ROV motion plus a passive datum can supply the required insertion and lever motions.

## Prototype trials, in priority order

| Priority | Trial | Evidence to record | Decision informed |
|---:|---|---|---|
| 1 | Acquire and release each actual/faithful prop by the approved grasp zone, with the ROV or fixture approach directions represented | Feature dimensions; approach access; contact locations; jaw opening; release success; visibility | Whether the 24 mm opening and current hook/pad profiles can reach the interfaces |
| 2 | Wet retention with trap, tool, panel-frame and node/SGANT surrogates; carry through translation, yaw turns and representative acceleration | Submerged weight/buoyancy; force at first slip; orientation; jaw angle/contact point; damage and release effort | Pad profile/material, hook use and required holding force |
| 3 | Soft-sample pickup and seedling placement using an inert compliant surrogate first | Approved contact zone; minimum retention force; maximum non-damaging squeeze; foliage snagging; planting/release motion | Whether soft pad compliance or a dedicated passive cradle is needed |
| 4 | Pull cover and operate breaker on actual props using a force gauge; separately test axial connector removal/insertion with cable supported | Force vs travel/direction; alignment error; latch/key orientation; cable bend/strain; cycles; surface damage | Whether hook/pusher geometry, a passive guide or separate tool is required |
| 5 | Remove/seat panel and push/guide cargo into docking bay with proposed final nose installed | Required edge access; lateral/axial force; seating condition; snagging; clearance to adjacent features | Whether a combined nose can retain reliable access to all tasks |
| 6 | Rehearse the entire product-demonstration sequence with one fixed end-effector configuration | Task-by-task success, elapsed time, slips, collisions, visibility, cable snags, failures to release | Whether the one-core architecture covers the run, or needs a distinct interface or revised mechanism |

Use physical competition props or dimensionally faithful replicas. Conduct early trials with the actuator disconnected and a force gauge/secured fixture. Record measurements in `gripper_interface_measurements.md`. Apply no load rating or powered-use decision until prop limits, real actuator behavior, stop/guard, mount, and safety inspection are established.

## Ranked measurements before geometry freeze

The following order prioritizes information that can invalidate the overall jaw architecture before polishing component dimensions. The values are intentionally blank until measured; the briefing supplies no numeric target for them.

| Rank | Evidence to collect | Minimum recorded measurements | Why it gates geometry |
|---:|---|---|---|
| 1 | Full set of actual or faithful props, their build instructions, and allowed operation sequence/contact clarifications | Overall envelopes; reachable carry surfaces; task-specific port/latch/mount/docking faces; orientation and approach vectors; task sequence rules; contact restrictions | Determines whether one pivot jaw and fixed face can reach the tasks at all, and prevents designing around assumed handles or photos. |
| 2 | Axial connector interfaces (generator and solar-panel power, sensor/node, SGANT power/communications) | Plug-body dimensions; key and latch orientation; insertion/removal axis, travel and peak force; cable exit/bend radius; required access around the socket | Establishes whether the ROV can align and push/pull while leaving the cable supported and avoiding jaw collision. |
| 3 | Lever/cover interfaces (generator cover and breaker) | Release direction; lever/cover travel and force curve; free-space envelope; usable blunt contact patch; endpoint or detent condition | Determines whether existing jaw/hook faces can react the force safely or need a separate passive tip. |
| 4 | Carried/recovered objects (seedlings/carrier, traps, replacement panel, dropped tool, primary node, SGANT) | Submerged apparent weight/buoyancy; multiple safe contact dimensions and lengths; carry orientation; wet first-slip force; release effort; damage/snag observations | Sets pad shape, opening, retention requirement, and whether the current single fixed pad profile is viable. Do not conflate carry-grip measurements with task-operation interfaces. |
| 5 | Placement and docking interfaces (seedling sites, node/sensor mounts, solar-panel frame, cargo bay, SGANT mount) | Mount/pocket envelope; insertion axis, travel and peak force; alignment tolerance; final seated condition; allowed lateral contact | Determines jaw reach and reaction-face geometry and reveals when vehicle pose, rather than a new tool DOF, can supply alignment. |
| 6 | Vehicle STEP assembly and actuator datasheet/sample | Tool-mount datum; all thruster guard solids and axes; camera view; service path; power/current; rated torque vs speed/duty; shaft and bolt pattern | Checks the mission-derived tool against real reach, collision, service, torque and electrical constraints before committing mount or drive geometry. |

Ranks 1–5 belong in the prop trial and interface worksheet; rank 6 requires the team's dimensioned vehicle STEP/STP and the selected actuator's authoritative CAD/datasheet. Do not fill gaps with invented tolerances, forces, or jaw dimensions.

## Review conclusion

The current pivot jaw remains a testable core, not a fully demonstrated all-task end effector. The highest-value next evidence is the prop interface set and a force/travel characterization, followed by a one-installed-configuration run rehearsal subject to the final task-order rules. The body STEP/STP assembly is separately required to check approach corridor, thruster/camera clearance, service access, and structural reaction path. The pending Part 1/manual and unavailable prop build/CAD links prevent final tip geometry, jaw range, or actuator sizing from being responsibly frozen.
