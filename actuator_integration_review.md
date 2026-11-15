# Gripper Actuator Integration Review

**Scope:** Build-versus-buy screen for the current one-DOF gripper study. This review does not select or authorize purchase of an actuator; the 2027 prop interfaces and ROV body model are still missing.

**Reviewer:** Scaevola

## Candidate A: Blue Robotics Newton Subsea Gripper

The manufacturer currently lists a single-function, sealed lead-screw gripper with a 62 mm jaw opening, 97 N grip at the tip / 124 N at the middle, 13.5 mm piston travel, 1.6 s open/close time, and 300 m pressure rating. Electrical interface: 9–18 V supply, up to 6 A peak, 3.3–5 V PWM logic. Physical data: 303.2 mm closed / 309.2 mm open overall length, 36 mm body diameter, 524 g in air / 267 g in water, two M5 mount screws on 16 mm spacing, and a 635 mm cable. The manufacturer page lists a single-unit price of USD 780 and links public assembly CAD. These are current manufacturer-published values, not MATE prop requirements. [Manufacturer product page and CAD](https://bluerobotics.com/store/thrusters/grippers/newton-gripper-asm-r2-rp/)

**Fit against this concept:** The 62 mm opening is much wider than the study's 24 mm nominal opening, but the actual handles/frames may be smaller or larger. The Newton is a compact commercial clamp but its ~0.31 m closed length needs a true vehicle/prop sweep; don't compare its overall length directly to the custom study's 97.5 mm forward reach because those dimensions use different package datums. It is a single-function clamp. The task actions also include pushing/seating, pulling covers, breaker operation, panel handling, and connector alignment, so the team's pilots and any passive nose/guide features still need task-fit review. Its public rating does not prove fit or successful completion of any 2027 task.

## Candidate B: Custom pivot jaw in `gripper_study.scad`

The current study combines one pivoting jaw, a fixed reaction/push face, a blunt hook, and replaceable round-channel/V-channel/flat inserts. Its nominal opening is 24 mm and its study envelope is about 90.5 x 103.5 x 112 mm with 97.5 mm forward reach. The coaxial actuator is only a 20 x 45 mm packaging proxy; the coupler, shaft interface, motor, seal, torque, speed, current, and reaction mounting have not been selected or qualified. Current torque calculations using Newton grip force are screening examples only, not a mission load.

**Implication:** Custom geometry can be tailored to the measured props and combine grasping with the fixed pusher, but the team must select a real depth-rated drive, complete the torque reaction and axial-retention load paths, guard moving gears, and qualify the wet-side electrical/mechanical assembly. The 20 x 45 mm proxy is not evidence that a real underwater actuator will fit that space.

## MATE integration constraints

- Explorer Part 2 says vehicle electrical power is supplied at nominal 48 V, any lower-voltage conversion must be on the ROV, and all ROV power goes through the competition supply/fuse arrangement. It calls for full-load current to be measured for the complete in-water vehicle and documented on the SID. Therefore, the Newton's 9–18 V / 6 A input would require a suitable onboard power/control interface if selected; its 6 A device rating does not determine the competition fuse. [2027 Explorer Part 2](https://20693798.fs1.hubspotusercontent-na1.net/hubfs/20693798/2027%20MATE%20ROV%20Competition/Manual%20Components/EXPLORER%20Part%202%20SPECIFICATIONS.pdf)
- Explorer Part 2 requires vehicle watertight housings to withstand 6 m. The Newton's manufacturer-published 300 m rating exceeds this depth; a custom actuator needs a pressure/depth-rated wet-side design to the team's operating requirement. Do not assume an ordinary hobby servo or unsealed motor is suitable.
- MATE's current 2027 season page lists the full Explorer manual and Part 1 Product Demonstration as pending; the available high-level briefing does not give prop dimensions or manipulation force requirements. [2027 season resource status](https://materovcompetition.org/2027)

## Decision gate

1. Import the manufacturer's public Newton assembly CAD and the team's body STEP into the same CAD assembly. Use the actual mount datum; check the 62 mm swept jaw, ~309 mm open package, forward camera view, all thruster guards/axes, service access, and approach corridor.
2. Overlay 2027 prop CAD when released, or use dimensionally faithful practice props. Record largest capture width, smallest retained feature, approved grasp points, wet retention loads, connector/cover/breaker travel and forces, and safe squeeze limit.
3. Check whether one Newton clamp plus a fixed/purpose-shaped passive nose can perform the team's assigned grasp/push/pull actions without an underwater tool swap. Check the 9–18 V rail, PWM control source, converter, cable routing, and full-vehicle measured current.
4. Choose the commercial route only if fit, task coverage, vehicle power, and structure pass those checks. Choose the custom pivot route if those checks reveal a real advantage in reach, access, contact shape, serviceability, or package; then size its actuator from measured wet loads and rated loaded speed, and qualify the depth/load path before pool trials.

## Recommendation status

**No actuator selected.** The useful immediate action is CAD overlay and prop-interface measurement, not a purchase. If the Newton misses the vehicle or mission interface, the current custom concept remains a candidate but its actuator proxy must be replaced from measured requirements.
