# Geometry and Interface Review

**Reviewer:** Arkhan Land  
**Scope:** Read-only review of `gripper_study.scad` and current gripper interface notes. No CAD edits or physical qualification were performed.  
**Status:** The current model is a parametric concept and packaging mockup, not a fabrication-ready mechanism.

## Directly verified in the current source

- Model units are millimetres. The gripper is a single revolute jaw against a fixed reaction rail, with a nominal 24 mm open pad gap, a 44 degree commanded sweep, and a stated analytical hard-close gap of approximately 2.73 mm. These are default study calculations, not measured prop fit.
- The current study uses a 64 x 82 x 6 mm adapter plate with a 42 x 58 mm four-hole pattern. A separate M3-proxy pattern mounts the side cheeks. The vehicle attachment geometry is not derived from a body model.
- The support frame's rear cross tie is parameterized to 78 mm wide at the defaults (`jaw_gap + 2*jaw_thickness + 18`), while the adapter plate is 64 mm wide. The cross tie therefore projects 7 mm beyond each plate edge in the model. The side-cheek attachment holes themselves are within the plate. This may be intentional, but check the overhang against the real bridge, neighboring thrusters, and access before fixing the dimensions.
- The fixed contact is part of the left structural rail. The moving contact is carried by the pivoting jaw; both pads are nominally 9 x 24 x 14 mm and held by top/bottom keeper strips and end fences. The standalone coupon exports do not contain the keeper or jaw backing.
- Some secondary dimensions do not automatically scale with the primary pad parameters. In particular, keeper fastener stations are fixed at 3.5 and 8.5 mm offsets from pad center, several blind pilot depths are fixed at 8.5 mm, and the modeled pad insert screw arrangement is built around the default 24 mm pad length. Changing `pad_size`, pad thickness, jaw width, or jaw gap requires checking pilot positions, edge distance, fastener access, keeper overlap, and collisions instead of treating those parameters as independently adjustable.
- The `max_jaw_angle_deg` variable controls the illustrative stop sector and analytical gap calculation. It does not establish safe clearance across the actual swept solids, pad compression, manufacturing tolerances, or object release.
- The adapter, support frame, actuator reaction ring/rails, shaft, coupler, retaining rings, stop pin, and guard interfaces use nominal or placeholder geometry. The 3 mm shaft engagements, 2 mm coupling web, printed stop pin, and 0.2 mm axial endplay are not selected hardware dimensions.
- `show_reference_bay` is off by default. Its optional 250 x 150 x 150 mm envelope is only a visual assumption and has no thruster guards, camera, tether, buoyancy foam, or access envelope.

## Geometry risks that can be handled now

1. **Keep the source parametric, but treat dependent dimensions as a coupled set.** Before changing jaw gap, pad length, pad thickness, or jaw sweep, list and inspect the dependent mount, keeper, pin/slot, bearing, and guard geometry. The current model has local formulas, but not a general tolerance or swept-interference solver.
2. **Add a dimension check before the next print package.** Export or measure the assembled gripper-only envelope from the current source and compare it with the stated study diagnostics. Do not use the existing assembly preview STL for printing: it includes the ghost vehicle frame, and the individual jaw/adapter meshes are subassemblies only.
3. **Check the cross-tie/plate overhang as a real interface question.** Preserve the 78 mm cross tie only if its overhang is supported and clear in the actual front bridge. Otherwise derive both from the team's structural rail spacing and fastener edge distances.
4. **Make pad-size revisions deliberate.** If a prop requires a longer contact surface, update the keeper and fastener pattern together, preserve material edge distances, and confirm that end fences do not block insertion/release. Re-export coupons after the real prop dimensions are entered.
5. **Do not increase the jaw opening by changing only `jaw_gap`.** At the current 35.5 mm far-pad arm, the design notes calculate that a nominal 62 mm opening needs new pivot/jaw geometry; a larger gap alone leaves insufficient closing range and changes torque, width, guard, and bearing placement.
6. **Retain the no-power gate.** The integral printed stop pin and placeholder coupler/retainers remain unsuitable for powered tests. Their redesign depends on actuator maximum torque and a matched shaft/coupler/stop hardware set; those must be treated as an upstream interface, not solved by arbitrary CAD strengthening.

## Inputs required before the geometry can be frozen

- The team's dimensioned body STEP/Parasolid or SolidWorks Pack and Go assembly, with the structural front mount bridge and real coordinate datum.
- All eight thruster axes and full guard/propeller envelopes, plus the camera field of view, tether path, buoyancy foam, and electronics-bay service/removal envelope.
- 2027 prop CAD/drawings or faithful practice props with measured allowed contact zones, feature sizes, connector key/latch geometry, required motions, and loads.
- A selected actuator drawing and data: mount faces, shaft size/protrusion, rated torque at speed, maximum/stall behavior, duty cycle, holding behavior, cable exit, power, and depth rating.
- A matched pivot bearing/shaft/retainer/coupler/stop hardware selection and team safety review of the accessible jaw pinch zone and assembled guards.

## Recommended next CAD sequence

1. Import the body and establish a front-mount coordinate system; create the real structural bridge and include the service/removal envelope.
2. Add actual thruster guards, camera, tether, and foam as collision solids; sweep the jaw and confirm the approach corridor.
3. Add dimensioned prop grasp features and their load directions; test the current jaw envelope before adding special tools.
4. Select the actuator and matched drive hardware from measured task forces, travel, and required cycle time; redesign the reaction mount and stop around rated maximum torque.
5. Adjust pad geometry/retainers from the measured grasp zone, perform unpowered fit and passive wet tests, then issue fabrication drawings only after bench and safety gates are met.

## Review conclusion

No immediate geometry change is justified without body, prop, and actuator inputs. The most concrete current CAD check is the 78 mm cross-tie versus 64 mm plate overhang, followed by enforcing dependent-dimension checks when pad or jaw parameters change. No test suite, swept-solid check, body collision check, or physical test was run as part of this review.

## Follow-up CAD update — 15 November 2026

The current SCAD changes the adapter plate and rear cross-tie to 84 mm, removing the previously noted 7 mm-per-side mismatch in the study geometry. The pad rail is now 12 mm thick to package a candidate insert boss and wall allowance, and the keeper screw inner-pair spacing was increased to 10 mm. Current source diagnostics give a 3.18 mm analytic hard-close gap and a 95 x 103.5 x 112 mm study envelope. These are CAD values only. The actual mount remains unverified until the team's STEP/STP assembly establishes the front datum, structural member, rail thickness, and nearby thruster/guard clearances.
