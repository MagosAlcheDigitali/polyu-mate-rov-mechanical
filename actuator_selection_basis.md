# End-Effector Actuator Selection Basis

**Reviewer:** Decimus-rho  
**Checked:** 16 November 2026  
**Status:** Comparison basis only. No actuator is selected, purchased, or qualified by this review.

## Decision in brief

Keep two architectures open until actual props, body CAD, and measured forces are available:

1. **Integrated depth-rated subsea gripper (commercial baseline):** compare the Blue Robotics Newton against the real vehicle and mission interfaces. Its published ratings and public assembly CAD make it the best current reference package, but its long axial envelope, fixed jaw kinematics, and unspecified task suitability prevent selection from this desk review.
2. **Custom geared rotary jaw:** retain the current pivot-jaw concept only if measurements show that its reach, contact shape, or service access offers a real advantage. Replace every motor, coupling, shaft, stop, and load assumption with selected hardware and rated interfaces. A generic hobby servo or ordinary motor in a sealed box is not a qualified underwater actuator.

Do not blend the Newton's published force rating into the custom jaw's torque calculation. The 97 N / 124 N values are Newton jaw-grip ratings; they are not a measured MATE task load, a custom actuator torque rating, or a verified force at each custom pad.

## Current model inputs are placeholders

`gripper_study.scad` currently describes a 20 x 45 mm coaxial motor envelope, 6 mm actuator-shaft proxy, 3 mm nominal engagement on each coupler side, 2 mm coupler web, and an 8 mm pivot shaft. The jaw study uses a 24 mm nominal opening, 0–44 degree commanded sweep, and an assumed 35.5 mm far-pad moment arm. The model has no selected drive, rated output torque, loaded speed, electrical interface, feedback, duty limit, or holding behavior. Its 4 mm integral stop pin and 2.5 mm stop plate are not approved for powered use.

These values are geometry-study inputs. They do not define a compatible actuator or establish force, safety factor, fit, depth rating, or production shaft engagement.

## Architecture comparison

| Criterion | Integrated commercial subsea gripper: Newton reference | Custom geared rotary jaw |
|---|---|---|
| Pressure/depth basis | Manufacturer lists 300 m pressure rating. | Must be proven for the chosen wet actuator or a designed pressure housing/feedthrough; the model has no rating. |
| Published mechanical basis | Manufacturer lists 62 mm opening, 97 N grip at tip, 124 N at middle, 3 kg push-rod axial-load rating, 13.5 mm piston travel, and 1.6 s open/close time. These ratings describe the Newton product only. | No verified output force/torque, speed, stroke, or efficiency is selected. Calculate from measured prop loads, actual contact arm, and real linkage geometry. |
| Package | 303.2 mm closed and 309.2 mm open overall length; 36 mm body diameter; 524 g in air and 267 g in water with cable. Two M5 mount screws at 16 mm spacing. | Current 20 x 45 mm actuator cylinder is only a proxy. Complete assembly envelope, mass, center of gravity/buoyancy, shaft and service path are unknown. |
| Electrical | Manufacturer lists 9–18 V supply, 6 A peak, 3.3–5 V PWM logic, and stall detection. | Supply, driver, peak/stall current, limits, PWM/CAN/interface, thermal behavior, and fault response are all open. An onboard converter is needed if the selected drive uses less than the 48 V ROV supply. |
| Mission flexibility | Manufacturer calls it a single-function manipulator. Its fixed linkage and jaw shape must be assessed against gripping, pushing, pulling, alignment, release, and delicate-item contact. | Geometry and passive interfaces can be tailored after the props are measured, but more mechanism, sealing, qualification, and maintenance work shifts to the team. |
| Initial view | Best commercial comparison to test in CAD and on practice props; not a purchase recommendation. | Keep as a conditional development route. Freeze only after a measured advantage and a complete load/power/pressure design. |

The team's verbal body envelope is approximately 250 x 150 x 150 mm. If the Newton's published overall length is aligned with the 250 mm vehicle dimension, it exceeds that envelope by roughly 53–59 mm before adding the mounting bracket or required clearance. This does not rule it out because forward projection may be acceptable; body CAD, thruster guards, camera view, and task approach space must decide.

## Competition integration constraints

- The 2027 Explorer Part 2 sets a 48 V nominal supply and a maximum of 30 A at 48 V, permits lower ROV voltages only when conversion is onboard, requires actual in-water full-load current to be measured, and requires powered ROV devices to be represented on the electrical SID. This means the Newton's 9–18 V supply cannot be obtained by a topside converter. Its 6 A peak is not the team's measured whole-vehicle FLA and does not select the primary fuse. [Official Explorer Part 2](https://20693798.fs1.hubspotusercontent-na1.net/hubfs/20693798/2027%20MATE%20ROV%20Competition/Manual%20Components/EXPLORER%20Part%202%20SPECIFICATIONS.pdf)
- The same Part 2 requires any watertight ROV housing to withstand pressure at 6 m and calls for motors and gear/pinch assemblies to be guarded to IP-20 access limits. A wet actuator needs a suitable rated design for operating depth; an electronics housing's rating does not qualify a separate actuator, and a pressure-rated motor alone does not satisfy the guard requirement. [Official Explorer Part 2](https://20693798.fs1.hubspotusercontent-na1.net/hubfs/20693798/2027%20MATE%20ROV%20Competition/Manual%20Components/EXPLORER%20Part%202%20SPECIFICATIONS.pdf)
- As checked 15 November 2026, MATE still lists the full Explorer manual and Part 1 Product Demonstration as pending. The high-level task briefing does not provide the gripper interface loads, dimensions, approved contact zones, or cycle duty needed to choose output torque and stroke. [2027 season resources](https://materovcompetition.org/2027)

## Measurements and drawings required before selection

### Mission/load inputs

- Actual reachable grasp-feature widths and tolerances, allowed contact zones, and minimum/maximum opening needed across the assigned task sequence.
- Wet retention, lift/carry, pull-off, cover release, connector insertion/removal, breaker travel/force, and panel/cargo seating loads, measured with a fixture and force gauge.
- Maximum safe squeeze for delicate samples, and the minimum holding force required for rigid items. Keep these as separate acceptance values.
- Required angular/linear travel, acceptable actuation time, repetitions and rest periods during a full run, time under load, impacts/overtravel, and whether the jaw must hold with power removed.
- The intended mechanism's perpendicular contact-to-pivot arm at each measured contact location; the resulting peak pivot torque through the entire stroke; transmission efficiency, impact allowance, and team-approved design factor.

### Actuator/interface inputs

- Manufacturer drawing for mounting faces/pattern, body envelope, output-axis position, output-shaft diameter/profile/usable length, connector/cable exit, and removal/service space.
- Continuous and peak output torque at the required loaded speed, stall/blocked behavior, duty/thermal rating, brake or unpowered holding behavior, backdrivability, and fault response. Do not size only from a stall-torque headline.
- Supply-voltage window, normal and peak current (including startup/stall), control logic and pulse range, current/torque-limiting method, feedback/position sensing, branch protection and wire requirements.
- Pressure/depth rating for wet components, sealing/penetrator documentation for any pressure housing, and corrosion/material compatibility.
- A positively retained coupling matched to both real shafts, a separate axial-retention stack, and a structural torque-reaction bracket. Size the complete stop/pin/sector/yoke path to worst-case deliverable torque, then design its guard and safe opening.
- Body STEP/STP assembly with the true front structural datum, eight thruster/guard solids and axes, camera/FOV, sealed electronics housing and removal path, foam, cables/tether, and allowed forward overhang.

## Required comparison and validation sequence

1. Obtain body STEP/STP and prop CAD or faithful practice props; measure the mission/load inputs above before changing the custom jaw's target geometry.
2. Import the Newton public assembly CAD and the current gripper study into the same body coordinate system. Compare full open/closed sweeps, approach corridor, jaw opening, camera view, thruster guards, service access, center of mass/buoyancy, and total forward projection.
3. On faithful inert props, passively test both architectures for capture, alignment, slip, axial push/pull, release, contact damage, and any necessary passive nose feature. Do not treat public rating numbers as substitutes for this test.
4. Choose the Newton only if its physical interface, task coverage, mounting, onboard 9–18 V supply/control, and whole-vehicle power budget pass. Choose a custom drive only if it demonstrates a specific task/package/service advantage and its complete actuator, shaft, retainer, reaction mount, hard stop, and depth design can be documented.
5. Before powered bench use, select real hardware and materials, establish load limits, replace the current printed stop, guard the drive and pinch regions, set current/torque limiting, and confirm an emergency disconnect. Test first on a secured, guarded bench fixture. Measure actual in-water ROV full-load current and record the selected system on the SID before mission use.

## Open decision

**No actuator selected.** The most useful next act is measurement and CAD overlay, not ordering a drive. The current model is an unpowered geometry study; there is no credible basis yet to claim that either architecture meets all task loads, vehicle fit, service access, safety inspection, or wet-cycle requirements.

## 16 November 2026 source and interface refresh

Blue Trail Engineering's current [resources page](https://www.bluetrailengineering.com/resources) lists a `Servo STEP Files Nov 2026.zip` archive. The current [SER-203X](https://www.bluetrailengineering.com/product-page/underwater-servo-ser-203x) and [SER-213X](https://www.bluetrailengineering.com/product-page/underwater-servo-ser-213x) pages continue to specify a 6 mm titanium D-shaft, list 5.4 N·m and 5.9 N·m respectively, and warn against sustained high torque and driving against a hard stop for more than 5–10 seconds. The manufacturer says these servos lack internal overheat/overvoltage protection. The current candidate motor-side coupling is round-bored with set-screw proxies, so the torque interface is geometrically unverified against the D-shaft and available [Titanium Servo Hub](https://www.bluetrailengineering.com/product-page/titanium-servo-hub). Use the November STEP archive and hub drawing/geometry to verify exact shaft flat, hub size, retention, mounting, and envelope before any CAD fit claim.

For context only, applying the listed torque to the study's 35.5 mm far-pad arm gives 152 N (5.4 N·m) and 166 N (5.9 N·m) in an ideal lossless static calculation. At the integrated candidate's 23 mm stop radius, the corresponding static reaction screens are 235 N and 257 N (`T/r`). These figures are not grip-force ratings or continuous-output guarantees and omit drivetrain loss, torque/speed behavior, duty, fault response, tolerance, impact, deflection, fatigue, and design factors. The selected actuator remains open pending measured task loads/travel/duty and body-STEP packaging.

## Sources

- Blue Robotics Newton Subsea Gripper product specifications, CAD, wiring/control information, and manufacturer's cycle warning: [product page](https://bluerobotics.com/store/thrusters/grippers/newton-gripper-asm-r2-rp/).
- MATE 2027 Explorer resources and live publication status: [2027 competition season page](https://materovcompetition.org/2027).
- MATE 2027 Explorer electrical, pressure-housing, and inspection requirements: [Part 2 PDF](https://20693798.fs1.hubspotusercontent-na1.net/hubfs/20693798/2027%20MATE%20ROV%20Competition/Manual%20Components/EXPLORER%20Part%202%20SPECIFICATIONS.pdf).

