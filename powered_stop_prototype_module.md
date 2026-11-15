# Powered Jaw Stop — Prototype Module Definition

**Module owner:** Cawl  
**Date:** 15 November 2026  
**Status:** Architecture and validation plan only. No replacement stop is dimensioned, built, or approved for powered operation.

## Purpose and release boundary

Replace the current integral printed pin and thin slotted sector before any powered jaw trial. Preserve the existing stop only as a kinematic feature in the study CAD and for unloaded hand-motion checks. A hard stop is a fault/overtravel boundary; closed-loop position and a verified current/torque limit should end normal motion before the stop is touched.

This module does not select a pin, metal grade, fastener, plate thickness, or allowable torque. The custom jaw's actuator is not selected, and the vehicle reaction structure and practice-prop loads are not available. The illustrative torque cases in project reviews are severity examples, not load requirements.

## Existing CAD hazard summary

`gripper_study.scad` models a Ø4 mm pin integral to a 4 × 12 × 2 mm rotating arm, about a 12 mm stop radius, engaging roughly 2 mm into a 2.5 mm-thick slotted sector. The pin has about 0.5 mm overlap at its root. The sector is retained schematically to the bearing/yoke area. The complete reaction chain is therefore not sized or proven.

At the illustrative 17.9 N·m case, the source screen gives about 1.49 kN tangential force, 118.7 MPa nominal single-plane pin shear, 186.5 MPa nominal slot bearing, and 712.2 MPa pin bending. These values use idealized formulas and omit impact, material/process allowables, stress concentrations, joint flexibility, plate/post/yoke loads, and fatigue. They confirm the current feature must not be used as a powered stop; they do not size its replacement. See `hard_stop_subsystem_review.md` and `drive_stop_module_review.md`.

## Recommended prototype architecture

Use a replaceable, positively retained cross-pin carried by a thick moving lug or fork that is structurally tied to the jaw hub. Where packaging allows, support the pin on two sides so the stop load is carried in double shear. The pin contacts broad, replaceable stop blocks at the open and closed travel limits. Mount those blocks to a rigid sector or bridge that reacts directly into the yoke; do not react stop torque through the guard, printed keeper strips, actuator housing, thin actuator clamp, adhesive, or electronics enclosure.

The stop blocks should locate repeatably and be captured against movement. If adjustment is required for pad compression or contact-angle tuning, make it lockable with positive features and retained fasteners; adjustment hardware must not be able to loosen into the mechanism. Keep stop faces clear of the pad/object contact path so the structural stop reaches its limit before a jaw, pad, or prop hard collision. Provide access to inspect and replace the pin and blocks without dismantling the main sealed electronics enclosure.

Keep the physical stop separate from the protective guard. The guard contains fingers, debris, and any failed small part, but does not carry stop torque. A broken or removed guard must not change stop position or structure.

## Load path to check

For either stop direction, trace and size the full load path:

`actuator output / torque limiter → coupling → pivot shaft and hub → moving lug → retained pin → fixed stop block → block retention and sector/bridge → yoke/bearing supports → vehicle structural mount`

At every joint, identify the material, section, support condition, fastening/retention, load direction, inspection access, and failure consequence. Analyze both open and closed stops; their supports and neighboring structures may see different loading. Include torsional reaction from the actuator mount as well as jaw-stop force. Do not use the guard as a parallel load path unless it is deliberately redesigned and fully checked as structure.

## Sizing workflow and equations

1. Establish maximum credible actuator torque at worst supply voltage and operating condition. Include manufacturer peak/stall or blocked-output limits, gear-train limits, current/torque-limit tolerance and response time, and any external torque limiter. Do not substitute a nominal or continuous torque when a jam can produce a higher peak.
2. Determine a separate impact case from moving inertia and speed at contact, measured backlash, and the compliance/stiffness of the assembled system. A first energy balance is `E = ½ J_eq ω²`; average stop torque over angular deflection `Δθ` is `T_avg = E/Δθ`. This does not give peak torque without the contact stiffness/damping or measurement. Set the impact allowance from a justified dynamic model or instrumented test, not an arbitrary unverified multiplier.
3. Use the larger applicable design case and a team-approved structural factor to define `T_design`. Record the derivation and factor approval. For the stop contact radius `r_s`, calculate tangential force as `F_stop = T_design / r_s` (consistent units: N·m / m = N).
4. Check the actual pin support geometry. For a round pin of diameter `d` and a true, symmetric double-shear arrangement, the average shear screen is `τ_avg = F_stop / [2(πd²/4)]`. For single shear, omit the factor of two. Do not claim double shear if the pin is cantilevered or if clearance prevents one support from engaging.
5. Check pin bending using the real support span and contact position. For an ideal simply supported pin with a central point load, `M_max = F_stop L / 4`; for a cantilever, `M_max = F_stop ℓ`. The nominal circular-section bending screen is `σ_b = 32 M_max / (πd³)`. Replace these idealizations with the actual bearing/contact distribution and include stress concentration and fatigue where applicable.
6. Check local bearing/crushing at pin-to-lug and pin-to-block interfaces (`p_avg ≈ F / (d t)` for a simple projected area), edge tear-out, net-section tension, block-face crushing, plate/lug bending, fastener shear/tension and prying, locating-feature loads, shaft/hub torque transfer, bearing reactions, and yoke/frame/vehicle-member stress. Include tolerances, corrosion/wear, print anisotropy if any polymer remains in the path, and combined load cases.
7. Compare calculated stresses and deformation with documented material/process allowables and team-approved factors. Ensure elastic deflection and tolerance stack cannot allow jaw collision, excess pad compression, pin escape, or fastener loss. If a mode cannot be calculated reliably, instrument and test it; do not infer capacity from CAD volume, supplier torque alone, or a mesh validity flag.

### Inputs required before dimensions can be released

- Selected actuator, complete torque-versus-speed and peak/stall limits, max voltage, current/torque-limit behavior and latency, duty, backlash, and failure behavior.
- Measured stop contact radius and pin/block geometry envelope; allowed jaw travel, pad compression, prop clearances, and manufacturing tolerance.
- Dynamic input: moving mass/inertia, speed at hard-stop arrival, angular backlash, contact stiffness/compliance, and a documented impact method or measured peak.
- Pin, lug, blocks, sector/bridge, fasteners, yoke, shaft/coupling, and actual vehicle mount materials and manufacturing processes; thicknesses, support spans, edge distances, fits, preload/engagement, corrosion protection, and inspection access.
- Team-approved load cases, structural factor, proof approach, required cycle life, safety-lead review, and wet environment/material compatibility.

## Prototype and verification gates

### Gate A — passive layout mockup

- With no actuator power, manually articulate the jaw through its intended range. Confirm separate open/closed contact surfaces, repeatable angles, no collision with jaw/pads/shaft/guard, positive retention, tolerance allowance, and practical service access.
- Verify that soft-limit targets can stop motion before physical stop contact and that any proposed guard fully covers the pinch/gear area without touching the stop components.
- This gate checks geometry and handling only; do not apply a torque lever to the current CAD pin/slot or represent a printed mockup as a strength test.

### Gate B — engineering check

- Freeze the real actuator and the complete structural load path, then complete the calculations above for both stop directions and static/dynamic cases.
- Review the drawings and calculations independently. Resolve every unknown load-bearing section, fit, fastener, support, and material before fabrication.
- Verify calculated stop deformation preserves clearances and fastener retention. Update CAD only from measured/selected inputs and retain inspection access.

### Gate C — secured bench proof

- Fixture the yoke and representative vehicle bridge rigidly. Keep hands outside the mechanism, install a test guard and emergency disconnect, and use calibrated torque/force instrumentation.
- Apply the team-approved proof load in incremental stages with a documented hold/dwell. Test both directions; do not let a powered actuator slam the stop as the proof method.
- Record applied load, displacement, residual travel change, fastener movement, and observed damage. Stop immediately for cracking, audible yielding, pin migration, loosened joints, unexpected deformation, or guard contact.
- After unloading, inspect pin, lug, blocks, retaining features, fasteners, sector/bridge, bearing ear, and fixture interfaces; measure stop angles and clearances again. Any permanent shift or damage fails the gate pending redesign.

### Gate D — guarded powered fault and cycle testing

Proceed only after Gate C passes and the team approves a written test procedure. Verify normal soft limits first; then perform controlled low-energy overtravel/fault tests with measured current/torque and angular speed. Increase energy incrementally under remote operation and a guard. Demonstrate repeatable limit detection, no pin/block escape, and no damage through the required cycle count. Reinspect and record wear. Wet trials require separate clearance of electrical/depth ratings, corrosion, and mission-prop/contact risks.

## Release decision

**Current state: fail for powered stop use; pass only as an unloaded geometry study.** Do not energize the main jaw against the existing integral pin/slot. A future metal pin and stop blocks are not automatically safe: the actuator, coupling, stop supports, fasteners, yoke, and vehicle structural reaction must all pass the same load-path review and physical gates. No fabrication dimensions or material grades are released by this module.
