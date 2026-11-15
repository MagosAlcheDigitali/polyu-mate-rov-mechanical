# Vehicle Mount Interface Review

**Reviewer:** Regulus  
**Scope:** Independent audit of the current gripper-to-vehicle interface using the team's verbal open-frame concept, the supplied perspective PNG, `gripper_study.scad`, and existing interface notes.  
**Status:** Read-only geometry review. No vehicle CAD was supplied, so no vehicle fit, clearance, structural strength, or final mount pattern is validated.

## Separate the input types

- **Team design context:** approximately 250 x 150 x 150 mm body; open service top; side walls and a center plane; buoyancy foam below; eight thrusters with an incomplete/ambiguous written placement description. These are team-provided assumptions, not measured CAD dimensions.
- **Image evidence:** the PNG communicates an open-frame concept and a general gripper location. It is perspective-only and does not define scale, wall thickness, fastener coordinates, thrust axes, guard envelopes, camera visibility, service clearance, or a structural load path.
- **Competition rules:** the current Explorer Part 2 source requires the electronics housing to operate to 6 m. That is a pressure-housing requirement; it does not establish where or how the gripper attaches. The user’s open service frame should therefore be distinguished from the sealed electronics housing. The gripper reaction path should enter a structural frame member, not a pressure-housing lid or unsupported wall.
- **Assistant model assumptions:** the optional OpenSCAD “reference bay” is a ghost envelope, not a model of the real vehicle. Its coordinate convention assumes vehicle length along -Y, width along X, height along Z, and the tool projecting in +Y from a nominal Y=0 mount plane. The overlay omits the roof, buoyancy foam, thrusters, guards, camera, cables, and electronics enclosure.

## What the current mount actually assumes

- The model’s `adapter_plate` is 64 x 82 x 6 mm, with a four-hole vehicle-side pattern at 42 x 58 mm pitch and 5.5 mm holes. Those are assumed clearances and locations, not team-selected hardware or body features.
- The plate also contains a separate M3-proxy support-frame attachment pattern. Its insert depths, screw lengths, head clearances, and engagement have not been checked against real wall thickness or inserts.
- The yoke rear cross-tie is 78 mm wide by default while the plate is 64 mm wide, leaving a 7 mm projected overhang on each side. This needs a structural bridge and neighboring-part check; it is not automatically an error, but it cannot be accepted from the screenshot.
- Current gripper packaging reports a 90.5 x 103.5 x 112 mm swept study envelope and about 97.5 mm forward reach from its nominal mount datum. The broader “tool-only” STL cited in the brief is a compound review mesh with a manifold warning; do not treat it as a mount-ready print or as verified vehicle envelope geometry.
- The 250 x 150 x 150 mm comparison overlay, when enabled, has no structural bridge, accurate thruster/guard bodies, camera, electronics housing, foam, tether, or cable sweep. A visible overlap or apparent clearance against it is not a fit check.

## Minimum body-CAD package before freezing the mount

Provide a STEP/STP top-level assembly in millimetres (or a SolidWorks Pack and Go ZIP) that includes the complete structural vehicle frame and actual gripper mounting region. It must be possible to identify these items in one body coordinate system:

1. **Datums and axes:** vehicle centerline; front/tool approach direction; origin; mount-face plane; structural bridge center and orientation. Confirm whether the model convention `+Y = forward` applies or provide the transform to it.
2. **Mount structure:** real bolt-hole coordinates, edge distances, available flat area, member wall thickness/material, backside fastener access, threaded inserts or through-bolt stack, and the path that carries clamp reaction torque plus push/pull loads into the chassis.
3. **Whole-vehicle obstacles:** all eight thruster centers, actual axis unit vectors, propeller/guard sweep solids, cable exits, nearby frame members, foam and tether route. Resolve the prose ambiguity about how many are horizontal versus angled. Include the actual guards; axis lines alone do not expose collision/snag clearance.
4. **View and service:** camera lens point and field-of-view cone; electronics housing solid and removal path; top access volume; tools/hand access to mount and actuator fasteners; actuator removal path and cable service loop. Show whether tool installation blocks electronics-bay maintenance.
5. **Operating envelopes:** vehicle outer envelope with the gripper at open, nominal, and closed positions; gripper jaw and actuator/cable sweep; target approach corridor. Include design clearances/tolerance policy rather than only exact nominal surfaces.
6. **Vehicle constraints:** allowed overhang, payload mass/center-of-mass and buoyancy budget, frame member load limits or test basis, and actuator power/cable routing limits. These affect the mounting solution even if the local bolt pattern fits.

## Recommended interface sequence

1. Import the body assembly and normalize units/orientation. Record the team-approved front approach direction and the real front structural mount datum.
2. Replace the assumed 42 x 58 mm / Ø5.5 plate pattern with the measured bridge pattern; map the yoke load path into structural members and check the 78 mm tie against the actual bridge.
3. Add actual thruster guards, propeller sweep, camera cone, electronics housing, foam, tether, and cable bodies as collision solids. Sweep the complete jaw/stop/guard assembly over its operating range and review access in installed and removed states.
4. Check assembly fastener insertion/removal, actuator service, and electronics housing removal independently; resolve conflicts by changing mount location or bracket geometry before optimizing the jaw.
5. Only then select plate/bracket thickness, hardware, material, and reach. Verify push/pull and actuator reaction loads with a documented structural calculation or physical test. Keep all powered operation gated by the separate stop-pin, guarding, and actuator reviews.

## Review conclusion

The image and verbal 25 x 15 x 15 cm frame are enough to explain the concept but not to freeze a gripper interface. The actionable next input is a dimensioned STEP/STP assembly with the front structural bridge, all thruster guard geometry, camera, foam, sealed electronics housing, cable/tether routes, and service envelopes. Until then, retain the mount plate and hole pattern as explicit placeholders; do not claim fit from the ghost overlay or the isolated adapter-plate mesh.
