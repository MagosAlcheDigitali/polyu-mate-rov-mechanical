# Rotary actuator candidates for the custom jaw

**Reviewer:** Tiresus  
**Checked:** 16 November 2026  
**Status:** Manufacturer-data comparison for a future CAD overlay. No actuator is selected, purchased, or approved for powered use.

## Decision boundary

The main `gripper_study.scad` still contains a generic Ø20 × 45 mm body and Ø6 mm shaft placeholder. Neither represents a servo model. The separate SG90 quick gripper is a different, light-load dry mockup. Replace the main placeholder only after prop force/travel and the vehicle STEP/STP assembly are available.

## Candidate comparison

| Candidate | Manufacturer-stated package and output | Electrical/control and immersion | Fit and evidence limits |
|---|---|---|---|
| **Blue Trail Engineering SER-2031** (submersible rotary servo) | 70 × 32 × 80.1 mm drawing envelope; 310 g in air / 170 g in water; 6 mm titanium D-shaft. Listed stall torque 5.4 N·m; no-load speed 0.18 s/60° at 6.0 V and 0.15 s/60° at 7.4 V; default ±60° travel, programmable to ±130°. | 400 m rating; 4.8–8.4 V; PWM 3–5 V; 8 A stall current. | Potential PWM candidate. Its published torque is stall torque, not a documented continuous-duty output. Vendor CAD/drawing and application confirmation are needed for case fit, mounting, shaft projection, hub, cable exit, duty and loaded output. The actual package is larger and boxier than the generic cylinder in the gripper CAD. |
| **Blue Trail Engineering SER-2131** (CAN submersible rotary servo) | Same nominal 70 × 32 × 80.1 mm envelope; 310 g in air / 170 g in water; 6 mm titanium D-shaft. Listed stall torque 5.9 N·m; no-load speed 0.14 s/60°; default ±60°, programmable ±150°. | 400 m rating; 8–32 V; CAN 2.0A/B; 8 A stall current; BLDC with magnetic encoder. | Could use CAN for actuator command, but needs a compatible CAN interface and team controller. Confirm torque duty, load limits, connector and full vendor interface package. 8 A stall is a branch/converter input, not an assumed vehicle full-load current. |
| **TMI-Orion Dynamics ERLA** (combined rotary/linear underwater actuator) | 248 × 113 × 90 mm; 2.8 kg in air / 1.75 kg in fresh water; max 16 N·m rotation torque; 8 s per 360°; adjustable linear range up to 18 mm; max thrust 80 kg. | 600 m rating; 9–24 VDC (65 W max at 24 V); RS-485 half duplex at 115,200 baud; SubConn MCBH8M input and MCBH8F output connectors. | A complete subsea actuator architecture and jaw system, not a drop-in micro-servo. Its envelope nearly equals the entire 250 mm vehicle length and exceeds the current 95 × 103.5 × 112 mm gripper-study envelope in two dimensions; wet mass and load path are substantial. Consider only if the team deliberately redesigns around a larger forward-projecting actuator and confirms its interface. |
| **Blue Robotics Newton Subsea Gripper** (integrated tool benchmark, not a bare actuator) | 303.2 mm closed / 309.2 mm open; Ø36 mm main body; 62 mm opening; manufacturer lists 97 N at jaw tip, 124 N at middle, 3 kg axial push-rod rating, and 1.6 s open/close. | 300 m rating; 9–18 V; 6 A peak; 3.3–5 V servo-style PWM. Manufacturer warns against rapid continuous cycling for over one minute due to heating. | Useful whole-tool comparison and available public assembly CAD. It is a single-function linear gripper, not a rotary drive to transplant into the custom jaw. The 303 mm body exceeds the stated 250 mm vehicle length if kept entirely within that envelope; a forward projection needs actual body, camera, guard and approach checks. Do not transfer its force ratings to the custom mechanism. |

Blue Trail values are checked against the manufacturer's [Underwater Servos datasheet, Rev. 2.1, October 2026 (PDF)](https://www.bluetrailengineering.com/_files/ugd/e4c7c5_f6ed898cfb8e4f18b432bcfd0b5dd3fb.pdf?index=true). It lists the SER-203x programmable travel limit as ±130° (not the ±175° value in the superseded comparison), and the SER-213x limit as ±150°. It also warns that the servos lack internal overheat/overvoltage protection and can be damaged by prolonged hard-stop loading or sustained high-torque operation. This matters directly because the current CAD hard stop is not suitable for powered use.

ERLA figures come from the manufacturer's [product page](https://www.tmi-subaxis.com/products/erla-electrical-rotary-and-linear-actuator/) and [technical datasheet (PDF)](https://www.tmi-orion-dynamics.com/medias/2024/10/TMI-Orion-Dynamics-ERLA-ed7.pdf). The datasheet says it is not contractual and calls for contacting the manufacturer because products may be updated.

Newton values come from [Blue Robotics' current product page](https://bluerobotics.com/store/thrusters/grippers/newton-gripper-asm-r2-rp/), including the public model links and its 17 February 2026 PWM-logic revision.

## Geometry-only torque screens

The main study uses a 35.5 mm far-pad arm and a 12 mm stop radius. If a candidate's listed torque were available at the output under load, the ideal static pad-force screen would be `F = T / 0.0355 m`; the stop tangential-load screen would be `F_stop = T / 0.012 m`.

| Listed output torque | Ideal far-pad force screen | Static stop-force screen |
|---:|---:|---:|
| 2.8 N·m (SER-2011) | 79 N | 233 N |
| 3.3 N·m (SER-2021) | 93 N | 275 N |
| 5.4 N·m (SER-2031) | 152 N | 450 N |
| 5.9 N·m (SER-2131) | 166 N | 492 N |
| 16 N·m (ERLA) | 451 N | 1,333 N |

These arithmetic screens are **not grip-force ratings** and do not account for servo torque definition, voltage sag, loaded speed, drivetrain losses, jaw angle, contact position, compliance, backlash, object damage, impact, controller limiting or fatigue. In particular, the existing stop pin/slot must not be powered against at any of these scenarios. Redesign and size the whole stop-to-yoke-to-vehicle reaction path for the selected actuator's maximum deliverable torque and transients.

## Inputs required before selecting or modeling a drive

1. Faithful props or official prop CAD: reachable grasp surfaces, largest and smallest capture widths, approved contact zones, required jaw travel, connector/lever axes, and safe squeeze limits.
2. Wet force/travel measurements for retention, cover release, insertion/removal, breaker, panel seating and cargo pushing; record direction, repeats, and force-gauge calibration. Distinguish allowable sample squeeze from required holding force.
3. Vehicle STEP/STP assembly with the true structural mount datum, front approach axis, all eight thruster axes and guards, camera, sealed electronics housing and removal path, foam, tether/cable routes and available forward overhang.
4. Electrical limits and interface: available rail, onboard conversion, branch current protection, PWM/CAN controller and logic, stall/current-limit behavior, cable/connector and strain relief, cycle rate and hold time.
5. Manufacturer drawing/CAD and written definitions of continuous versus peak/stall torque, maximum blocked torque, loaded speed, duty/thermal limits, shaft usable length, radial/axial load allowance and warranty/pressure conditions.
6. The redesigned hard stop, coupling, shaft retention, structural yoke/bridge and guards, with a documented load factor and secured bench proof plan.

After these inputs arrive, overlay SER-2031/SER-2131 and the Newton public CAD against the complete body and task envelopes, then compare measured loads against each candidate's documented output across the required motion. No purchase decision is supported by this desk comparison alone.

## CAD availability

Blue Trail Engineering's current [Resources page](https://www.bluetrailengineering.com/resources) now lists a **Servo STEP Files Nov 2026** ZIP. Once the team chooses which servo model(s) to evaluate, use the manufacturer's STEP rather than the cylindrical placeholder to check the case, mount faces, shaft projection, connector and service path. The archive itself has not been downloaded or inspected in this workspace, and no servo model is selected. Do not assume that package dimensions alone define shaft engagement or mounting-hole locations; verify those details from the supplied CAD and current datasheet.

