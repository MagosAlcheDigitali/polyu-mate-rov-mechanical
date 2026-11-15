# Mechanism Design Review

**Reviewer:** Faustinius

Scope: read-only audit of `gripper_study.scad` and `gripper_torque_test_fixture.scad`. Findings distinguish modeled geometry from unverified engineering assumptions. No CAD render, strength test, or software test was run for this review.

## High-priority findings

### 1. Hard-stop pin is the dominant powered-load risk

**Verified in the model:** `gripper_study.scad` makes the Ø4 mm stop pin an integral part of `rotating_stop_arm()` (around lines 734-760). The fixed sector plate is 2.5 mm thick (around lines 142-148 and 698-731). From the defined z coordinates, the pin spans from 0.5 mm above the sector plate bottom to 2.0 mm beyond its top, so its slot-bearing engagement is only about 2.0 mm. The pin overlaps the rotating arm by only about 0.5 mm. This is a shallow root for a cantilevered pin and a short bearing length.

**Screening calculation, not mission load:** using the design brief's illustrative 6.5 and 17.9 N·m actuator cases at the modeled 12 mm stop radius gives tangential reactions of about 542 N and 1,490 N. With a Ø4 mm pin and 2.0 mm plate engagement, projected slot-bearing stresses are about 68 MPa and 186 MPa (`F/(d*t)`), before impact, clearance, stress concentration, and material anisotropy. These are force-scale scenarios only; the Newton tip-grip rating is not confirmed to equal per-pad normal force, and actual required/maximum torque is unknown.

**Recommendation:** before any powered prototype, replace the integral printed pin with a positively retained metal shoulder pin/bolt and redesign the sector/arm support so pin root and plate engagement are structurally supported. Size the plate, fasteners, pin shear/bending, and support joints for the selected actuator's maximum deliverable or current-limited torque. Do not power the current integrated-pin geometry.

### 2. Torque-test fixture has a defined shaft/retainer stack

**Verified in the latest model:** the M3 tap-drill pilot is accessible from +Y, clear of the +X lever arm, and the D-bore keys torque. The grub-screw proxy is centered at x=-1.5 mm. With a Ø3 mm proxy, its maximum x is 0 mm; the arm starts at x=0, so the nominal extents are tangent without overlap. The Ø2.5 mm tap pilot reaches only x=-0.25 mm and clears the arm by 0.25 mm. At x=-1.5 mm the screw tip still reaches the Ø8 mm shaft surface. The test shaft extends from z=-17 to 32.2 mm, carries mirrored upper/lower bearing-retainer grooves, and adds an upper washer/ring above the 12 mm lever hub. Its modeled 0.2 mm bearing-retainer endplay and upper lever retention stack are geometrically coherent as a study. The current +Y entry comment matches the modeled orientation.

The shaft/lever are still an accessory: install them through the actual passive jaw/yoke stack and secure that yoke to a bench reaction fixture before applying load. The file models retention proxies, not selected commercial rings, washers, or an assembled bench support. Verify the as-built hardware stack and swept clearance before applying force.

The 100 mm anchor-hole radius is correctly located for `T = F*r` when force is applied tangentially; 10 N at 0.100 m is 1 N·m. The lever's 12 x 6 mm arm remains geometry only. At the brief's illustrative extended-jaw 17.9 N·m case it would see 179 N at the anchor; check the bar root, hub, grub screw, test shaft, force-gauge hook, and reaction fixture material/load capacity. FDM is suitable for fit/low-force setup, not an assumed 179 N proof fixture.

### 3. Production pivot shaft remains distinct from the extended test shaft

**Verified in the model:** the production shaft's lower drive extension is set from the 3 mm coupler engagement plus roughly 2 mm of retainer/coupler spacing (`shaft_drive_extension`, around lines 197-202), so only about 5 mm extends below the lower bearing. The new 49.2 mm test shaft extends above the lever and has separate retaining grooves; it is intended to replace the production shaft in a passive test stack and does not mount onto the short production drive extension.

## Other design-review items

- **Coupling is a packaging placeholder:** the modeled coupler is Ø14 x 8 mm, with only 3 mm blind engagement on each shaft and a 2 mm web (around lines 188-205 and 887-916). No hub clamp, key, set-screw engagement depth, shaft material, or rated torque is selected. Replace these values from the chosen actuator drawing and verify torque transfer and axial clearance; do not fabricate this proxy as-is.
- **Actuator reaction path is not qualified:** a nominal Ø20 mm housing is held by a split 20.5 mm ID clamp with twin narrow rails/feet and small fasteners (around lines 188-246 and 929-1073). The motor's stator reaction passes through the clamp, rails, feet, lower bearing ear, yoke, adapter plate, and vehicle bridge. Each joint remains an assumption until actuator torque, material, fasteners, and frame mount are selected.
- **Axial-retention stack is schematic:** Ø8 mm shaft, Ø7.2 mm groove, Ø11 mm ring proxy, 0.5 mm washers, and 0.2 mm endplay are not a matched commercial retaining-ring system (around lines 118-141 and 668-696). Select shaft/ring/groove as one hardware set and check groove strength, ring capacity, wear, and assembly access.
- **Pad-retention details need real inserts:** the 9 x 24 x 14 mm pads, 1.5 mm keeper strips, end fences, and multiple M3 screw placeholders provide a concept for mechanical retention, but screw engagement and keeper peel strength are unverified (around lines 54-60 and 435-505). Check actual pad compression, drainage, release, and pad retention in wet trials.
- **Kinematic screens are not swept-solid verification:** analytical opening/closing functions and force moment arms (around lines 73-112) are useful for screening. They do not check full jaw/guard/anvil collisions, tolerance stack, pad deformation, trapped cable/mesh, or actual prop approach. Current 24 mm opening and 2.73 mm analytic hard-close gap remain placeholders.
- **Vehicle interface is only a ghost envelope:** the 25 x 15 x 15 cm reference body shows side plates and a center plane only (around lines 1226-1247). There is no structural bridge, thruster geometry, camera, tether, or service-access sweep. The 64 x 82 x 6 mm plate and 42 x 58 mm hole pattern are not validated against the team's body.
- **Safety envelope:** the guards are modeled around the stop and actuator drive, but assembly-level seam, fastener, and shaft openings need checking on as-built parts. The working jaw mouth remains an open pinch zone requiring team safety review; the gear-guard opening limit should not be generalized into a numeric jaw-gap requirement.

## Suggested correction order

1. Fit the extended test shaft through the passive jaw/yoke stack, source matching rings/washers and grub screw, and secure the yoke in a reaction fixture; verify clearance and torque measurement before using it.
2. Redesign the powered hard stop around a replaceable, supported metal pin and a load-rated sector/arm joint.
3. Select a real actuator and matched pivot shaft/retainer/coupler, then rebuild the reaction-mount interfaces from its CAD.
4. Import the body and prop CAD, set the adapter datum, and check the full swept/collision and service envelope.
5. Confirm wet retention, safe squeeze, connector/push loads, and jaw opening against measured props before releasing fabrication geometry.

## Re-audit — 14 November 2026

Checked the current source again at the stop, shaft, reaction mount, and guard modules (`gripper_study.scad`, current lines approximately 122–210, 680–760, 975–1085, and 1097–1240). The earlier high-priority findings still apply; no powered-use risk was cleared by the later geometry revisions.

- The current 44° commanded sweep uses hard stops at approximately −1.456° and 45.456°. The 2.5 mm sector plate, 5 mm slot, Ø4 mm pin, 12 mm stop radius, and 0.5 mm pin-to-arm root overlap still form a small, unqualified hard-stop load path. A current SCAD diagnostic also reports 2.729 mm pad gap and 3.572 mm hook-to-fixed-pad clearance at the close stop; those are analytic values, not swept-solid/tolerance proof.
- The actuator coupler remains an 8 mm long proxy with 3 mm engagement on each shaft and a 2 mm web. The modeled actuator shaft is only a generic Ø6 mm envelope, with no selected key/clamp/cross-pin detail. At hard-stop torque, a set-screw-only or friction-only drive could slip or damage the short engagement; use a vendor-rated coupling and a matched shaft interface after selecting the actuator.
- The 0.2 mm endplay and 0.5/1.0 mm modeled axial stack clearances are internally parameterized placeholders, not evidence that a real retaining ring fits or can carry the jaw’s axial loads. Select the shaft, groove, rings, washers, bearing, and assembly method as a rated set; verify axial load and endplay after assembly.
- The split actuator clamp and two narrow reaction rails transfer motor reaction into the lower bearing ear and yoke through several small screw/insert joints. The model gives no material, embedment, preload, fatigue, or maximum torque rating for these joints. Design and proof the complete load path against the actuator’s maximum output or a defensible hardware current limit, including stall and stop impact.
- The modeled stop guard has an 11.5 mm nominal shaft opening, and the lower actuator guard has an 11.8 mm nominal opening; the latter is below the 12.5 mm nominal opening threshold cited in the team brief. This does not establish assembled IP-20 access compliance: inspect the split seams, fastener recesses, bottom closure, shaft motion, tolerance, and every reachable path with the appropriate inspection probe. Keep the guard removable for service and reinstall it before powered operation.

**Prototype power-on gate:** keep the actuator electrically disconnected until the team has replaced the printed stop pin with a supported, positively retained metal stop; selected and installed the actual rated coupling and axial-retention hardware; sized and inspected the full reaction path; and checked assembled guard openings. First powered testing should be on a secured bench fixture with the jaw path clear, a conservative current/torque limit, emergency disconnect, and no hands near the mechanism. This gate does not authorize pool use; wet testing follows only after bench load and safety review.

No new strength test, CAD interference sweep, hardware selection, or formal software test was performed in this re-audit. These are source-geometry observations and prototype recommendations, not a design release.
