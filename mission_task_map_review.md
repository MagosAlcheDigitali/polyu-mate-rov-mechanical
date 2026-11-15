# Explorer End-Effector Task Coverage Review

**Reviewer:** Videx  
**Checked:** 15 November 2026  
**Scope:** Mechanical task coverage for the current one-DOF pivot-jaw study. This review separates MATE's published task actions from mechanical design inferences; it is not a prop-interface or safety approval.

## Official evidence and limits

The current MATE 2027 season page lists the full Explorer manual and Part 1 Product Demonstration as pending. The available all-class Product Demo and Specs Briefing says that all product-demonstration tasks are attempted in one run. The Explorer page lists prop instructions, parts lists, Q&A, mission CAD and practice resources, but the current page view does not expose active links for those materials. The briefing is therefore an action list, not a set of grasp dimensions, contact permissions, loads, travels, tolerances, connector standards, or task sequencing details. [2027 resource status](https://materovcompetition.org/2027) · [Explorer task resources](https://materovcompetition.org/explorer) · [Product Demo and Specs Briefing PDF](https://20693798.fs1.hubspotusercontent-na1.net/hubfs/20693798/2027%20MATE%20ROV%20Competition/2027%20MATE%20Documentation/2027_MATE_ROV_Competition_Briefing_FINAL.pdf)

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

The single pivot jaw and fixed face can be a common grasp/push core for early trials. The task list spans gentle object handling, high-retention transport, axial insertion/removal, lever motion, edge handling and guided docking. That combination does not establish that one fixed jaw profile will serve every prop.

Keep the nose attachment capable of accepting a passive bolt-on contact tip, but do not finalize a tip shape or claim in-run tool swapping. Since the tasks are attempted in one run, test one installed configuration across the full sequence unless the detailed manual permits a change. Prefer to keep the gripper, pusher and alignment features on the vehicle simultaneously if trials show that the task approaches overlap. Do not add a second actuator based on action wording alone; determine whether ROV motion plus a passive datum can supply the required insertion and lever motions.

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

## Review conclusion

The current pivot jaw remains a testable core, not a fully demonstrated all-task end effector. The next high-value evidence is a prop-based fit and force set followed by a single-configuration full-sequence trial. The body STEP/STP assembly is separately required to check approach corridor, thruster/camera clearance, service access, and the structural reaction path. The missing Part 1/manual and practice props prevent final tip geometry, jaw range, or actuator sizing from being responsibly frozen.

