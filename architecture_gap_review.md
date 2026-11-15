# 2027 Explorer End-Effector Architecture Gap Review

**Reviewer:** Zagreus Kane  
**Checked:** 14 November 2026  
**Scope:** Compare the current one-DOF pivot-jaw study with the official Explorer ROV product-demonstration action list. This is a mission-coverage review, not a prop-interface or safety qualification.

## Evidence boundary

The MATE briefing says that all product-demonstration tasks will be attempted within one product-demonstration run. It lists the ROV actions below but does not provide gripper contact dimensions, permitted grasp zones, loads, forces, connector geometry, or travel in the briefing. The 2027 season page still lists the full Explorer manual and Part 1 Product Demonstration as pending; the Explorer resource page labels the prop instructions, shopping lists, Q&A, and mission CAD resources but those items are not active linked downloads in the current page view. Recheck before freezing geometry. [2027 briefing](https://materovcompetition.org/2027) · [Explorer resource page](https://materovcompetition.org/explorer)

The supplied Floats Preview is Task 3, the profiling float, not a mechanical specification for the ROV gripper. The ROV manipulator is relevant to Explorer product-demo Tasks 1 and 2. [Official 2027 briefing PDF](https://20693798.fs1.hubspotusercontent-na1.net/hubfs/20693798/2027%20MATE%20ROV%20Competition/2027%20MATE%20Documentation/2027_MATE_ROV_Competition_Briefing_FINAL.pdf)

## Current architecture under review

The workspace concept is a forward-facing single powered pivot jaw against a fixed blunt anvil/push face, with a blunt capture hook and replaceable mechanically retained pads. The ROV supplies approach motion. The CAD has round, V, and flat pad profiles, but no validated 2027 prop dimensions. The current architecture is therefore a useful common prototype core; its coverage of every listed task is not demonstrated.

## Task-to-mechanism gap matrix

| Official ROV action | Minimum mechanical mode suggested by the action (inference) | Current concept fit | Interface evidence still needed |
|---|---|---|---|
| Collect seagrass; deploy seedlings at designated locations | Gentle capture, transport, and release | A compliant pad or cradle might help; the current clamp could over-squeeze or contact foliage if the grasp zone is guessed. | Practice sample/carrier dimensions, allowed contact zone, safe squeeze, release method, and any planting motion. Use a non-living surrogate first. |
| Deploy a new crab trap; return the old trap to the surface/side of pool | Capture a handle/frame and hold through lift and vehicle motion | The hook plus V-pad is a plausible capture hypothesis, not a confirmed interface. | Trap handle/bar geometry, submerged load, permitted grasp area, orientation, and release behavior. |
| Install primary node; install, connect, and (Explorer) level pressure/tilt sensor | Grasp/orient a module, push to seat, handle a connection, maintain orientation | Clamp and blunt anvil provide basic grasp/push hypotheses; no alignment datum or validated seating tool is present. | Mount features, approach axes, allowable misalignment, seating forces/travel, connector handling and level tolerance. |
| Remove generator-port cover; install power connector | Pull cover, then guide and push a keyed plug axially | Hook/anvil could provide pull/push reactions; ordinary pads do not guarantee plug alignment. Cable must not be the pulling surface. | Cover latch/lip, plug body/key/latch, insertion/removal axis and loads, cable bend/strain limits, handoff sequence. |
| Disengage breaker; unplug/replug solar-array main power; remove/install replacement panel; re-engage breaker | Lever/push/pull actuation, connector work, and panel-edge handling | Pusher/hook and flat pad are hypotheses. Jaw closure alone may obstruct lever travel or damage an edge. | Breaker geometry/direction/travel/load, connector body/keys, panel frame/grasp area and retention, access and release sequence. |
| Recover dropped tool before or after it hits bottom; return it | Capture in free water or acquire a resting tool, then retain during transport | A hook and clamp are plausible, but approach orientation and bottom-resting access are unknown. | Tool geometry, bottom orientation/access, acceptable contact, retention load, and no-power behavior. |
| Maneuver cargo payload into a docking bay | Push/guide payload into a target; possibly grasp if required by the actual rules | Broad anvil is a reasonable push hypothesis; hook/pads may snag or obstruct docking. | Payload contact surface, docking envelope/clearance, whether grasp is required, final seated condition and allowable lateral force. |
| Install SGANT; connect power and communications link | Capture/orient antenna assembly and support connector alignment | Clamp may carry the assembly, but the current nose lacks a validated repeatable orientation datum or connector guide. | Base/mast grip, mount axis, connection geometry, insertion/removal loads and cable routing. |

Official action wording is drawn from pp. 5–6 of the briefing. Functions and gaps in the second and third columns are engineering interpretations, not added MATE requirements.

## Highest-value architecture decision available now

Keep the single-DOF clamp as the common load-bearing core, but make the **front contact/nose a mechanically replaceable, passive interface** in the architecture. Reserve a simple captive/bolted nose interface for interchangeable blunt noses such as a flat pusher, hook/guide, or future connector cradle. Do not yet dimension a connector key, breaker finger, seedling cradle, or panel hook: the current official material does not publish the mating geometry. This preserves the common gripper and allows a tested task-specific passive nose to be added without introducing another actuator or changing the whole assembly.

This is a provisional packaging decision, not a claim that the team may swap tools during a run. Since all tasks are attempted in one run, any chosen nose must either remain installed for the complete sequence or the actual run rules and task sequence must confirm when a safe swap is possible. Prefer one fixed multi-contact nose if actual practice-prop trials show it covers the sequence.

## Prototype evidence needed before a coverage claim

1. Use the real or dimensionally faithful props to test grasp, push, pull, guide, and release separately. Keep contact on approved surfaces; use a compliant non-living surrogate for early seagrass trials.
2. Record alignment error, approach direction, force/travel, slips, snagging, surface damage, and release success for each action in `gripper_interface_measurements.md`.
3. Demonstrate connector pulling by the plug body, axial insertion without cable loading, breaker operation, panel removal/replacement, and stable docking push on the actual props. If one nose cannot reach or align them, add a passive nose only after measuring the interface.
4. Test bottom-resting dropped-tool access, loss-of-power retention, and trap carriage; confirm the hook cannot snag task structures during approach or release.
5. Only after the action tests and physical geometry are available should the team decide whether one clamp with passive tips is adequate or a separate actuator/tool head is necessary. Do not select actuator torque from the task list alone.

## Recommendation summary

The currently modeled clamp is an appropriate general-purpose prototype core, but it is not yet a fully verified all-task end effector. The task list mixes soft-object handling, load retention, axial plug work, lever actuation, and guided pushing. The best current decision is to preserve a modular passive nose interface and test the common core against practice props; detailed end features and actuator sizing remain gated on official Part 1/prop information or measured faithful props.
