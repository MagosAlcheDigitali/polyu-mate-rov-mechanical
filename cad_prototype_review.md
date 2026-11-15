# CAD Prototype Readiness Review

**Reviewer:** Rho  
**Scope:** Read-only audit of `gripper_study.scad`, `gripper_torque_test_fixture.scad`, the mesh previews, and the existing concept brief.  
**Assessment:** The model is a useful packaging and assembly-order study. It is not yet a task-qualified or load-rated prototype design.

## Geometry confirmed in the current source

- The jaw is one powered revolute member against a fixed left-side reaction rail. The assembly includes a blunt hook lip, fixed push face, one selected pad geometry at a time, keeper strips, yoke, bearings, a rotary-drive envelope, and split guards.
- The current nominal pad opening is 24 mm and the estimated hard-close gap is about 2.73 mm. Jaw sweep is modeled from 0 to 44 degrees. The current concept envelope is roughly 90.5 x 103.5 x 112 mm with 97.5 mm reach from its model mount datum.
- The adapter is a generic 64 x 82 x 6 mm plate with four Ø5.5 mm mounting holes on 42 x 58 mm pitch. That pattern is not connected to real vehicle rails or a modeled front bridge.
- The actuator is a schematic Ø20 x 45 mm rotary cylinder; its output is a placeholder Ø6 mm shaft. The coupling uses 3 mm nominal engagement on either side of a 2 mm web. These values are not drawn from a selected actuator.
- The stop pin is integral to the rotating arm. Existing design notes estimate only about 2 mm effective slot bearing engagement and about 0.5 mm overlap at the arm root. It remains unsuitable for powered testing until redesigned.
- The torque accessory has a 100 mm force arm and an extended Ø8 mm shaft with three nominal retaining-ring grooves. Its retainers are illustrative proxies; the source instructs using the actual jaw/yoke stack and a secured external reaction fixture.
- STL previews exist for the full assembly, mount plate, jaw assembly, stop sector, and torque fixture. Their successful export confirms mesh generation, not material strength, dimensions, or assembly compatibility.

## What the mechanism can and cannot cover

The clamp and fixed face could support transport, broad pushing, and some bar or handle captures if practice props present safe grasp features. The hook is blunt and localized at one side of the jaw tip. Pad styles are alternative configurations (`round_channel`, `v_channel`, or flat); the CAD does not establish that one jaw setting can collect fragile seagrass, retain a trap, grip a tool, carry a panel, and handle connector bodies reliably in the same run.

There is no independent wrist rotation, translation, compliant alignment axis, connector-specific body nest, positive connector keying, dedicated breaker contact, or seedling-carrier cradle in this model. Those may be unnecessary if the ROV supplies the required alignment and a prop offers a suitable grasp surface, but that must be demonstrated against the actual task props. The model currently has only a 24 mm nominal opening, substantially below the 62 mm opening stated for the Newton benchmark in the concept brief; that comparison is a useful scale warning, not proof that the custom jaw must match it.

## Prototype blockers and risks

1. **No verified vehicle interface.** The four-hole plate has placeholder coordinates. The described acrylic centerline plane and side walls are not modeled as load-rated supports; the front cross-bridge described in the brief is also absent. Do not infer that the tool can be bolted to the center plane or electronics bay.
2. **No complete vehicle collision envelope.** The ghost body is a 250 x 150 x 150 mm assumption. Thrusters, full guards, camera field of view, tether, foam, service access, and all eight thruster axes are absent. A nominal envelope fit does not establish collision-free approach or actuator removal.
3. **Stop load path is unsafe for powered closure.** Replace the integral printed pin with a positively retained metal pin and support its reaction into a sufficiently thick, fastened sector and arm. Set dimensions from the selected actuator's maximum torque or enforced limit, including impact and a documented margin.
4. **Shaft and coupling interfaces are provisional.** The 3 mm coupling engagements, Ø6/Ø8 shaft pair, 2 mm web, grooves, split rings, and 0.2 mm endplay are not a matched commercial hardware design. Verify shaft torque/bending, key or flat bearing, groove stress, axial push/pull, washer contact, and actual assembly order.
5. **No chosen actuator or electrical interface.** The rotary proxy gives no rated torque at speed, stall behavior, duty cycle, brake/holding behavior, depth rating, current, connector, cable exit, or failure recovery. The split guard has no verified cable exit or installation/removal path around a real cable and actuator.
6. **Contact capacity is unknown.** The clamp force and safe squeeze are not defined. A single opening and pad size cannot be accepted until the largest target and the most delicate target have been measured. Wet pad friction, slip direction, axial connector force, panel-edge damage, and object release need separate trials.
7. **Torque fixture is incomplete as a bench system.** It provides a lever and shaft, not a reaction stand or load-rated yoke. The passive jaw/yoke, matched rings/washers, calibrated force gauge, secured bench anchorage, guarding, and safe load limit remain to be specified and assembled.

## Recommended next CAD iteration

Use actual interfaces as the next inputs, then revise the model in this order:

1. Import the body assembly and define a front structural bridge that spans both side rails. Add the actual plate, backing strips/fasteners, thruster guards, camera volume, tether path, electronics removal envelope, and service tool clearance. Sweep jaw open/closed and verify the intended approach corridor.
2. Model measured task props or simplified target volumes for the agreed grasp points. Record the maximum capture width, minimum hard-close width, hook/bar size, connector body, panel edge, carrier geometry, insertion depth, and allowed contact surfaces. Keep each contact module swappable if one geometry cannot pass all tasks.
3. Select the actuator from required force, speed, stroke or angle, duty cycle, wet depth, current, and failure mode. Replace the actuator, shaft, coupler, clamp, reaction rails, cable exit, and guard with vendor dimensions. Confirm removal access without opening the electronics bay.
4. Redesign the stop and pivot from a quantified torque path. Draw real pin, sector, fasteners, shaft-retention hardware, and bearing/bushing interfaces. Include impact/load cases and specify acceptable deflection at the jaw tip.
5. Define the wet-side prototype material and process per part. Separate printed fit parts from structural load path parts, then check minimum wall thickness, insert edge distance, screw access, corrosion-compatible fasteners, and pressure exposure.
6. Build an unpowered mockup and measure jaw opening, sweep, contact location, slips, object damage, insertion/pull forces, and service time. Use those measurements to update the CAD before powered bench tests.

## Minimum measurable acceptance checks

| Check | Measurement | Pass evidence |
|---|---|---|
| Target coverage | Largest and smallest grasp features across every assigned prop | Measured props fit/open and close with retained contact at the specified grasp zone |
| Wet retention | Pull force and direction per object with selected pads | No slip at the team-defined design load; no damage at the measured safe squeeze limit |
| Push/pull interface | Connector insertion, cover release, breaker travel, and panel seating forces | Gripper/vehicle alignment can complete each motion without unsafe probe contact or lost alignment |
| Stop and pivot | Actuator maximum/limited torque, stop reaction, shaft endplay, jaw-tip deflection | No permanent set, loosened joint, shaft walk, pin/slot damage, or guard failure through the documented test cycles |
| Vehicle fit | Full body/guard/camera/tether and service envelope through jaw sweep | No collision or snag; visible grasp point; accessible fasteners and removable actuator |
| Serviceability | Time and tools to replace pads, pivot, actuator, and wet-side cable | Each listed service item is replaceable without removing the electronics bay |

**Review outcome:** Continue with the present concept as an unpowered fit mockup. Do not power the current integrated printed stop-pin design or treat the STL previews as fabrication files. The most valuable next input is the body STEP/Parasolid assembly plus the official or physical props; actuator selection follows measured prop forces and real packaging.
