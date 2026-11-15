# Replaceable Contact Pad Prototype Module

**Review origin:** Faustinius; current module update by Cawl  
**Revision:** 16 November 2026  
**Scope:** Contact inserts, keeper strips, their screws/inserts, and staged fit/retention tests.  
**Status:** Prototype plan only. No profile, pad material, thread insert, fastener, retention strength, or powered operating condition is selected or qualified.

## Purpose and current geometry

Use a replaceable contact surface so the team can compare grasp shapes and materials without changing the jaw structure. The current OpenSCAD study (`gripper_study.scad`) models a nominal 9 × 24 × 14 mm pad insert. Its contact profile can be round-channel, V-channel, or flat; fixed and moving sides can be varied independently. Current exports include the separate coupon body, pad, and keeper-strip parts under `prototype_meshes/`. The combined coupon with positive screw/insert proxy solids is an assembly visualization only; do not print it as the real hardware-fit coupon.

The current retention concept uses upper and lower keeper strips with end fences and four M3 fasteners represented by geometric proxies. The current CAD has a Tappex Trisert-3 M3 insert candidate in the coupon rail: 4.73 mm nominal OD, 5.25 mm length, and 4.25 mm pilot diameter at 5.8 mm depth. The pilot is the midpoint of a cited approximate 4.10–4.40 mm plastic range. These dimensions are a fit-study starting point, not an instruction to install that insert or evidence that a printed boss will hold it. Verify current supplier installation guidance and the actual purchased insert before machining or printing a production part.

The 24 mm paired-coupon blank-face spacing does not equal a guaranteed local gap through the grooves. The user's Floats preview is about the separate float task, not the ROV gripper. The full Explorer Part 1 instructions and faithful prop geometry are still absent from the project evidence reviewed here; therefore no final pad curvature, width, contact zone, allowable squeeze, or material can be derived yet.

## Prototype build sequence

### 1. Freeze a measurable interface

Before revising pad geometry, measure each available official practice prop or dimensionally faithful replica. For each intended grasp, record:

- feature width/diameter, usable contact length, corner radii, surface finish, and measurement uncertainty;
- permitted contact zone and approach/release path, confirmed from the official task instructions or organizer;
- submerged weight/buoyancy, expected pull directions, handling acceleration/hold time, and safe sample-contact limit;
- interference with connectors, cables, levers, nearby features, camera sight lines, and one-configuration access across the mission.

Until these exist, use the existing round, V, flat, and asymmetric flat/V samples only for gentle, unpowered geometry screening on inert surrogates. Do not change the default round channel into a mission choice based on the Floats document or a generic object shape.

### 2. Screen profile geometry with rigid coupons

Print matched round, V, and flat pairs, plus the asymmetric flat/V pair if a one-sided reaction face appears useful. Keep blank dimensions, print batch, material, and slicer settings identical. Use a rigid prototype filament for this stage so profile fit is easier to compare than with a soft insert. Confirm coupon dimensions with calipers after printing.

For each prop/surrogate and profile, perform slow hand approach, seat, carry-or-pull direction, and release motions with the jaw actuator disconnected. Record contact position, alignment tolerance, capture, slip direction, snagging, release effort, surface marks, and whether the chosen profile obstructs another required action. Reject any profile that needs an unapproved contact zone or cannot release cleanly. A standalone coupon has no backing rail or keeper load path, so it provides no retention or force rating.

### 3. Build the passive keeper-and-insert assembly

Use the three hardware-free printable pieces from `prototype_meshes/` (coupon body, pad, and keeper strips) and actual candidate hardware. Do not use the fused visual coupon STL for this step. Inspect both pad surfaces and keeper seats for print artifacts; remove sharp flash without changing the documented geometry. Measure the printed body, pilot locations, pad pocket, screw holes, keeper overlap, and edge distances.

Treat the M3 Trisert-3 as one candidate only. First confirm its exact part number, material, dimensions, and installation process from the delivered supplier documentation. Assemble a small fit series using pilot sizes spanning the supplier's stated plastic range (for example 4.10, 4.25, and 4.40 mm if the chosen print process can reproduce them). Keep insertion method, print orientation, wall/perimeter strategy, and material lot controlled; record boss cracking, insert tilt/rotation, head seating, and installation damage. Five samples per pilot condition is a practical comparative screen, not a statistical qualification.

Install the actual screws with a measured usable thread engagement and a repeatable team-approved tightening method. Confirm that:

- every keeper sits flat and its end fences capture the pad without pinching or extruding it;
- heads and screw ends do not protrude into the contact zone or sweep/approach path;
- a hand tool can reach all screws and the pad can be changed without disassembling the jaw pivot;
- the insert cannot migrate toward the jaw opening or escape around an end fence;
- the pad has a way to drain/flush water and silt, and wear cannot expose a sharp structural edge;
- removal and replacement do not progressively loosen the installed inserts or crack the rail.

If the inserts rotate, crack a boss, or pull out, stop and compare another retention architecture (for example, a through-bolt/captive nut with accessible hardware) rather than increasing screw torque or relying on adhesive. Any fallback must preserve pad service access and be checked against the actual jaw section and clearances.

### 4. Compare pad materials passively

After profile fit is understood, compare same-profile pads made from documented candidate materials/processes: a controlled FDM TPU 95A lot and one sourced or cast elastomer with a known grade/hardness. A rigid print remains a geometry control, not a wet-grip material proxy. Record supplier/lot, hardness source, print or mix/cure process, orientation, conditioning, dimensions, and visible defects.

Start with non-living, inert replicas. With the actuator disconnected, mount the complete jaw/pad/keeper stack to a secured fixture and use a force gauge or load cell to apply repeatable pull directions. Wet samples in the intended test water and record force at first slip, pad compression/extrusion, release force, surface marking, tearing/cutting, permanent set, screw movement, insert rotation, keeper damage, and cycles to a visible change. Use repeated samples; three cycles is an initial screening run only. Stop at the known safe-contact/load limit. If that limit is unknown, use only gentle qualitative trials.

For a delicate seagrass/seedling task, use a compliant non-living surrogate until the permitted grasp zone and safe squeeze are confirmed. Softness or a favorable dry hand test does not establish sample safety or underwater friction.

### 5. Separate pad retention from object retention

There are two different load questions:

1. **Object-to-pad retention:** does the chosen wet surface hold the prop at the required contact force without slip or damage?
2. **Pad-and-keeper-to-jaw retention:** can the pad, keeper strips, screws, threaded inserts, and jaw rail carry the forces without migration, pullout, rotation, fracture, or loosening?

Measure object slip independently from keeper and insert movement. For the structural test, use sacrificial complete rail coupons with the real pad and hardware. Apply controlled pad extraction/shear loads in the directions that tend to pull the pad through the open jaw side and out along its long axis. Use a fixture that loads the keeper/pad interface without prying the test frame into an unrealistic lever. Log force/displacement and identify failure mode; inspect for hidden cracking after disassembly.

Set the required pad-retention test load only after measuring maximum expected jaw force and the task load path. The team must set the proof margin and acceptable failure criteria from its engineering/safety policy. Do not substitute catalog insert-fit dimensions, hand tightening, or one successful pull for a load rating. Record candidate-to-candidate variability and keep a sacrificial test separate from the part intended for the vehicle.

### 6. Wet-cycle and service test

Condition the assembled passive module in the intended fresh/salt water and sediment conditions before cyclic testing. Run a documented sequence of wet approach/contact/release cycles on a secured fixture. Recheck after each interval for pad displacement, extrusion, wear, permanent compression, tears, residue, corrosion, screw loosening, insert rotation, cracks, exposed hard edges, and trapped debris. Record soak duration, water condition, cycle count, applied load/direction, and cleaning method. Repeat a pad change using the vehicle's expected tools and service access; confirm the jaw remains captive and no loose hardware can fall into the mission area.

The passive wet test qualifies only the tested coupon/material/hardware combination at the measured conditions. It does not qualify the powered jaw, actuator, hard stop, complete vehicle mount, pressure exposure, or mission performance.

## Release gates

Keep this module at passive prototype level until all of the following are documented:

1. Official prop geometry/contact permissions or faithful replicas establish the actual contact interface.
2. A profile is selected from measured fit, release, wet slip, and task-sequence trials.
3. A specific pad material/process and actual keeper/fastener/insert hardware are identified and their assembled dimensions inspected.
4. Safe sample squeeze and required wet object loads are measured or defined by the team.
5. The complete retained-pad joint withstands the team's approved proof load and repeated wet cycles without migration, cracking, or loosening.
6. The powered actuator and mechanical stop are independently sized and guarded; powered testing is controlled and approved by the team.

Until those gates are closed, mark all pad/contact results as comparative prototype data, not a design rating or fabrication release.

## Record sheet for each candidate

| Field | Record |
|---|---|
| Prop/replica ID, source, and measured contact feature | |
| Officially permitted contact zone and confirmation source | |
| Profile pair / pad material / supplier lot or print batch | |
| Pad and rail dimensions after manufacture; instrument and resolution | |
| Print orientation, process settings, conditioning, and visible defects | |
| Insert part number/material, pilot diameter/depth, installation process, screw, and measured thread engagement | |
| Keeper seating / tightening method / measured torque if available | |
| Water type, temperature, soak/conditioning time, and sediment condition | |
| Load direction, fixture geometry, force/displacement readings, and first-slip force | |
| Pad movement / insert rotation / screw movement / failure mode | |
| Prop marks, pad wear, snagging, and release result | |
| Cycle count / service time / post-test inspection | |
| Team-set acceptance limit, its source/owner, result, and decision | |
| Evidence files (photos, data log, CAD revision) and unresolved risks | |

Before each comparative run, the team should write the acceptance value and source into the record sheet rather than deciding after seeing which candidate performs best. Where the task instructions or sample-safe load are still unknown, mark the limit **TBD** and keep the result qualitative/unpowered; do not backfill an assumed pass criterion.
