# Actuator and Power Integration Review

**Reviewer:** Lakius Danzager  
**Checked:** 14 November 2026  
**Scope:** Actionable actuator, electrical, and pressure-interface gates for the current gripper study. This is a review, not an actuator selection or purchase approval.

## Current design interface facts

- `gripper_study.scad` describes its dimensions as schematic. The custom actuator is a packaging proxy, while the modeled coupling assumes a 6 mm motor shaft, two 3 mm blind engagements, and a 2 mm center web. These are not selected component interfaces.
- The current custom-drive hard stop uses an integral printed pin with approximately 2 mm slot engagement. Earlier design review estimated about 0.5 mm arm-root overlap. The concept brief correctly prohibits powered use of this stop geometry.
- The study's power model does not contain a selected motor, driver, voltage rail, current limit, feedback device, cable entry, or duty-cycle limit. `desired_close_time_s = 0` means the model has no commanded cycle-time target.
- The current mounting plate/yoke geometry is not tied to the team's ROV body. No mass, center-of-buoyancy effect, cable route, structural load rating, or thruster/camera clearance is established.

## Candidate route A: Blue Robotics Newton

The manufacturer currently publishes a 62 mm jaw opening, 97 N grip at the jaw tip and 124 N at the middle, 3 kg push-rod axial-load rating, 13.5 mm piston travel, and 1.6 s opening/closing time. The unit is rated to 300 m. Its supply is 9–18 V with 6 A peak current; signal is 3.3–5 V servo-style PWM. Published dimensions are 303.2 mm closed / 309.2 mm open and 36 mm body diameter; its cable is 635 mm. Public assembly and mount CAD are linked from the product page. These are manufacturer ratings, not proof of task suitability. [Blue Robotics Newton product page](https://bluerobotics.com/store/thrusters/grippers/newton-gripper-asm-r2-rp/)

**Fit/integration consequences:** the 303 mm package cannot fit wholly within the team's approximate 250 mm-long vehicle envelope; it would need to project forward or mount elsewhere. Overlay its public assembly CAD on the body and camera/thruster envelopes before treating the Newton as a candidate. The 62 mm opening may be useful for large captures, but its 13.5 mm actuator piston travel and jaw linkage are not equivalent to the custom pivot's 21 mm estimated jaw-tip closure travel. The 3 kg push-rod rating is a separate axial-load limit; do not substitute the grip-force figure for a push or pull rating.

The Newton manufacturer warns against rapid continuous cycling for over a minute because the motor may overheat. Its internal stall detection stops the motor at a stall, but that is not a measured force-control or object-presence signal. Validate the required number and timing of cycles from the actual task run and the team's controls. [Manufacturer quick-start and safety notes](https://bluerobotics.com/store/thrusters/grippers/newton-gripper-asm-r2-rp/)

## Candidate route B: custom geared actuator

Keep the pivot concept only if practice-prop measurements show a meaningful advantage in reach, a combined grasp/push contact, body clearance, or serviceability. Select its output torque from measured wet jaw force at the actual contact radius, then include measured transmission efficiency, friction, impact/overtravel, and the team's documented design factor. Verify loaded output speed over the full stroke. Do not size from Newton grip force or the current 24 mm/44-degree study values as if those were mission requirements.

Replace the placeholder package and interfaces with a specific depth-rated actuator drawing: housing outline and mounting faces, output shaft diameter/flat/key, usable engagement, rated and stall torque, loaded speed, voltage/current envelope, duty cycle/thermal limits, cable/connector, and pressure/depth rating. Complete the load path through a real reaction bracket, positively retained pivot shaft, and redesigned metal stop pin/sector. Add torque/current limiting or an equivalent verified overload strategy; guard the drive and pinch hazards before powered testing.

## 2027 Explorer power and safety requirements

The available official 2027 Explorer Part 2 permits ROV voltages up to nominal 48 V, requires any lower-voltage conversion onboard the ROV, and limits the class to 30 A at 48 V. For 2027, teams must measure the complete ROV's full-load current in water and report it with the selected permitted fuse; the manual says not to itemize individual device currents in place of that measurement. The 48-to-actuator converter therefore belongs onboard, and the gripper's branch load must be present during final whole-vehicle current verification. [2027 Explorer Part 2: voltage and current rules](https://20693798.fs1.hubspotusercontent-na1.net/hubfs/20693798/2027%20MATE%20ROV%20Competition/Manual%20Components/EXPLORER%20Part%202%20SPECIFICATIONS.pdf)

Any electrical device on the ROV must appear on the applicable SID. A powered gripper therefore needs to appear on the ROV electrical SID, with the onboard voltage conversion and control/power path shown at the appropriate block level. The existing documentation requirement for in-water ROV current and the primary fuse still applies. The gripper branch fuse, wire gauge, converter, and connectors must be selected from the actual branch load, wire protection, fault behavior, and supplier requirements; 6 A peak from the Newton page alone does not size the competition's main fuse. [2027 Explorer Part 2: SID and FLA requirements](https://20693798.fs1.hubspotusercontent-na1.net/hubfs/20693798/2027%20MATE%20ROV%20Competition/Manual%20Components/EXPLORER%20Part%202%20SPECIFICATIONS.pdf)

The 2027 manual requires electronics housings to operate at 6 m depth, requires gear assemblies to be guarded to IP-20 access limits (openings below 12.5 mm or a solid cover), and prohibits harmful sharp edges/points. The 2027 competition pool may reach 5.2 m, so the electronics-housing rule and the mission operating depth should be considered separately. A gripper actuator mounted wet needs its own suitable depth rating or a designed, pressure-qualified enclosure; the electronics-can rating does not qualify an actuator. [2027 Explorer Part 2: depth and mechanism guarding](https://20693798.fs1.hubspotusercontent-na1.net/hubfs/20693798/2027%20MATE%20ROV%20Competition/Manual%20Components/EXPLORER%20Part%202%20SPECIFICATIONS.pdf)

## Design gates before the next powered prototype

1. Measure representative prop grasp widths, wet slip/retention, squeeze limits, push/pull/insertion force, travel, and desired actuation time. Keep official task statements separate from physical assumptions until the full Part 1 and props are released.
2. Import Newton public CAD and a dimensioned selected custom actuator into the same assembly as the body model. Check full jaw sweep, the complete forward projection, mounting, camera view, thruster guards, tool removal, and service access.
3. Close the custom actuator data sheet and interface drawing before editing its proxy. Freeze shaft/coupler/retainer, torque reaction, and bracket interfaces together; size the hard stop for worst-case deliverable torque before powered use.
4. Design the onboard rail and branch protection. Confirm PWM levels/control source and common reference from the chosen manufacturer's wiring documentation, cable pinout and strain relief, driver fault behavior, and current/thermal limits. Bench-test at the lowest and highest planned supply conditions with a current-limited source.
5. Update the SID for the selected gripper and converter. Measure full vehicle current in water with all loads, including gripper motion, under the MATE procedure; record the observed full-load value and choose the compliant primary fuse. Check the gripper branch independently for wiring and component protection.
6. Verify depth, leak containment, corrosion compatibility, guard openings, pinch access, and a safe de-energized state. Start with unpowered geometry fit, then guarded dry bench tests, then a restrained shallow-water test before mission trials.

## Decision

**No actuator selected.** The immediate next engineering gate is importing the body model and public Newton CAD, then comparing both package envelopes against the real approach corridor and a measured practice prop. The custom concept is not ready for powered actuation until its actuator interfaces and stop load path are replaced with rated hardware.
