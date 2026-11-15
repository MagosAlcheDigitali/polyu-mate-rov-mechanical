# Hard-Stop Subsystem Review

**Reviewer:** Hyus N’dai  
**Date:** 15 November 2026  
**Scope:** Read-only audit of the mechanical jaw stop in `gripper_study.scad` and the existing mechanism review. No CAD was changed and no strength or powered test was performed.

## Decision

Keep the existing stop only as an illustrative kinematic limit in the study model. A lightly hand-operated geometry mockup may be used to inspect motion, but the team should not load the stop, repeatedly impact it, or power the jaw against it. Before powered testing, replace the thin slotted plate and integral printed pin with a captured metal stop assembly sized from the selected actuator’s maximum output torque and the complete supporting structure.

## Verified current geometry

The current SCAD parameters and modules define:

- A Ø4 mm pin modeled integrally with the rotating stop arm; the arm is a 4 x 12 x 2 mm rectangular bar at a 12 mm stop radius.
- A fixed, 36 mm diameter sector plate only 2.5 mm thick, with a 5 mm wide arcuate slot and 0.3 mm nominal tangential clearance.
- Approximately 2.0 mm of pin engagement through the slot plate and approximately 0.5 mm overlap between the pin and its supporting arm, as calculated in the existing mechanism review.
- Two Ø4 mm sector-plate posts tying it to a bearing ear; the guard/stop-base screw arrangement remains schematic hardware.
- The pin/slot establish a geometric range of about −1.456° to 45.456° for the current 0–44° jaw command. This is not a torque rating or impact-qualified limit.

The implied reaction path is actuator output → short unqualified coupling → pivot shaft and keyed hub → rotating stop arm/pin → thin slot edge → sector plate/posts and fasteners → bearing ear/yoke → vehicle mount. Every interface after the pin remains materially and dimensionally unqualified in the current model.

## Force screen

At a 12 mm stop radius, the static tangential force is `F = T/r`:

| Illustrative torque | Tangential force | Nominal slot bearing screen, `F/(4 mm × 2 mm)` |
|---:|---:|---:|
| 6.5 N·m | 542 N | 68 MPa |
| 17.9 N·m | 1,492 N | 186 MPa |

These are scenarios copied from the team's earlier torque study, not selected actuator loads or mission requirements. The projected bearing screen omits stop impact, pin cantilever bending, slot edge distance/tear-out, plate bending, post and fastener loads, fatigue, polymer anisotropy, stress concentration, corrosion, and the rest of the reaction path. It cannot be used to approve a material or size.

## What can be specified before actuator selection

- Make the stop a separate, replaceable mechanical subsystem rather than an integral printed feature.
- Provide two broad, opposed stop faces that define the open and closed limits; use the motor controller/current limit and a control soft limit to stop motion before normal contact with the physical stops.
- Carry stop reactions directly into a structural yoke or frame bridge, not through the guard, a thin actuator clamp, keeper strips, electronics housing, or adhesive.
- Use positive mechanical retention for the pin and stop blocks, with service access and a guard that prevents access to moving hardware after assembly.
- Keep stop contact outside the fragile pad/contact path, and leave clearance for pad tolerances and the chosen compliant insert so the structural stop engages before metal jaw collision.
- Retain adjustability only if it can be locked positively and its fasteners are captured; a loose adjustment must not become a projectile or change the closure unexpectedly.

These are architecture and inspection requirements. They do not establish pin diameter, plate thickness, fastener count, material, or allowable torque.

## Recommended prototype load path

Use a replaceable hardened steel shoulder pin or dowel carried by a thick, positively retained moving lug. Support the pin in a fork/double-shear arrangement where packaging permits, rather than as a short cantilever attached to a thin printed bar. Let it contact two broad replaceable stop blocks or shoulders mounted to a substantially thicker sector/yoke plate. Transfer plate load into the bearing/yoke structure with separated fasteners and locating features so fastener bearing/shear and plate prying can be checked. Keep the guard structurally separate from this force path.

Treat that as a layout direction only. Select the final geometry and materials after the actuator, shaft/coupling, yoke material, and vehicle reaction datum are known. Avoid using an unverified printed plastic stop as a powered backup; even a metal pin is insufficient if the slot, block mounts, posts, or yoke fail first.

## Failure modes to assess

1. Pin shear or cantilever bending; pin walkout, loosening, or fracture at a stress concentration.
2. Slot/block bearing crush, edge tear-out, peening, or permanent deformation that changes jaw travel.
3. Stop plate bending or cracking; post, bolt, insert, or yoke failure; load entering a weak actuator bracket or vehicle member.
4. Impact amplification from backlash, speed, motor inertia, repeated cycling, or a hard jam; controller current limiting may not act quickly enough.
5. Stop engagement at the wrong angle causing pad extrusion, jaw/keeper/anvil collision, loss of grasp, or a trapped object.
6. Guard opening or fastener failure exposing the moving stop/pinch mechanism; corrosion, wear debris, or sediment inhibiting the stop.

## Measurements needed to size it

- Selected actuator’s maximum output/stall torque at maximum supply voltage, gear ratio, speed, duty cycle, and its current/torque limiting response; include any mechanical torque limiter or brake behavior.
- Stop radius, stop contact width, engagement geometry, and measured backlash/impact speed at first stop contact.
- Actual pin, lug, plate, block, joint, and yoke materials, manufacturing process, thicknesses, edge distances, tolerances, fastener grade/preload/engagement, corrosion protection, and cycle target.
- The complete torque-reaction path into the team's real structural vehicle mount; do not react against an electronics housing.
- Required jaw travel and clearance from measured practice props, pad compression, and the team's chosen manufacturing tolerance.
- Team-approved structural safety factor, inspection criteria, and applicable inspection interpretation for the enclosed moving stop.

## Test and powered-use gate

1. Inspect the unpowered mechanism by hand for stop-angle repeatability, clearance, retention, and service access. Do not force the stop or use the torque lever to proof the present pin/slot.
2. After selecting real actuator and hardware, calculate pin shear/bending, stop bearing/tear-out, plate/block bending, bolt/post loads, and yoke/frame reactions at the maximum credible actuator torque plus a separately documented impact allowance.
3. Verify dimensions and contact at both limits on an assembled passive prototype; confirm a positive structural stop engages before pad or jaw hard collision.
4. Proof the completed stop and reaction structure on a secured bench fixture using a calibrated torque/force method, guarded test area, emergency disconnect, conservative incremental loads, and post-test dimensional inspection. The proof method and margin must be set and approved by the team before testing.
5. Power the jaw only after the stop, coupling, axial retention, actuator mount, guard, and vehicle reaction path pass review. Add wet cycling only after the bench gate and mission contact limits are known.

The current SCAD dimensions do not pass this gate. A successful CAD compile or a simple-mesh result is not evidence of stop strength.

## Follow-up CAD screen — 15 November 2026

The OpenSCAD study now has an optional `stop_screen_design_torque_Nm` input. A zero value suppresses the screen; setting the value to the team's peak design torque reports tangential force and nominal pin shear, plate bearing, and pin bending using the current proxy diameter, engagement, and overhang. It is a calculation aid, not a material check or a release criterion.

At the previously documented illustrative 17.9 N·m scenario and 12 mm radius, OpenSCAD reports 1,491.7 N tangential force and approximately 118.7 MPa pin shear, 186.5 MPa slot bearing, and 712.2 MPa pin bending for the current Ø4 mm pin, 2.0 mm plate engagement, and approximately 3.0 mm unsupported bending arm. The screen omits impact amplification, pin/plate material allowables, the arm root, joint loads, plate bending, fatigue, and yoke/vehicle reactions. The torque is illustrative, not an actuator specification. These results reinforce the no-power gate and support the architecture change toward a positively retained replaceable pin, thicker moving lug, and replaceable fixed stop blocks structurally tied into the yoke; they do not size that hardware.
