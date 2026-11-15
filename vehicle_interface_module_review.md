# Vehicle-to-Gripper Interface Module Review

**Reviewer:** Scaevola  
**Date:** 15 November 2026  
**Scope:** Mount concept and body-CAD integration package for the current end-effector study.  
**Status:** Preliminary; the team has not supplied the STEP/STP assembly, so fit and structure cannot be verified.

## Design context and current CAD assumptions

The team describes an approximately 250 x 150 x 150 mm open-frame vehicle with side walls, a horizontal center plane for electronics support, no roof for access, bottom buoyancy foam, and eight thrusters. The written thruster locations are ambiguous. The perspective PNG communicates the general layout but cannot establish scale, axes, frame member dimensions, mount coordinates, or clearances.

The current `gripper_study.scad` uses millimetres and assumes a +Y forward tool direction. Its generic adapter plate is 84 x 82 x 6 mm with four Ø5.5 mm vehicle holes on a 42 x 58 mm pitch. A separate set of four M3-proxy fasteners attaches the plate to the gripper yoke. The yoke's rear tie is also 84 mm wide. The current tool-only study envelope is about 95 x 103.5 x 112 mm, with 97.5 mm forward reach from the nominal mount plane. All of these vehicle-side values remain placeholders; the plate pattern was not derived from the team's frame.

## Mount concept to carry into the next CAD revision

Use a **front structural bridge tied into both side rails/walls** as the gripper's reaction member. Bolt the end-effector adapter into that bridge through a broad, removable plate or two spaced attachment lugs. Let the bridge transfer push/pull force, jaw reaction torque, and off-axis handling loads into both sides of the vehicle frame. Keep the sealed electronics housing and its removable lid out of that load path.

The bridge can sit in front of the service bay so the open top remains available. Keep the tool and actuator fasteners accessible from the front or sides, and leave a clear vertical removal path for the sealed electronics housing through the roofless opening. Route the actuator lead along the structural frame with strain relief and keep it away from the jaw sweep, thruster propellers/guards, and tether.

The user's acrylic center plane may support the electronics enclosure or help tie the frame together only if its material, thickness, edge attachment, and load capacity are established. Do not assume a thin acrylic sheet or pressure-housing surface can carry the gripper's cantilever and actuator torque. If the existing frame cannot carry the load, add a separate metal or suitably reinforced polymer bridge tied to structural side members, then proof-test it against the measured loads.

Keep the bridge, adapter plate, and yoke removable as a service module. The mount should not require opening the electronics enclosure to remove the gripper. Choose the actual fastener pattern and bracket section only after the body assembly establishes available members, backside access, and clearances.

## STEP/STP handoff needed

The chosen handoff is a top-level STEP/STP assembly in millimetres. Include real solids or collision proxies for:

1. The structural side rails/walls, center plane, existing cross members, proposed front bridge/mount area, and available fastener access.
2. The sealed electronics housing, lid, connectors, and the space/path needed to remove it for maintenance. A simplified housing solid is enough if its internal components do not affect access.
3. All eight thrusters, mounting supports, propeller sweep or equivalent guard/keep-out volumes, axes, and cable exits. Identify each axis with a direction vector; the prose description does not completely specify their arrangement.
4. Camera lens point and approximate field-of-view cone, bottom buoyancy foam, tether, and any wiring that can enter the tool or propeller path.
5. The proposed tool mounting plane and candidate fastener coordinates, if known.

Add a short note stating the vehicle origin, front/approach direction, unit system, frame material/thickness, and which members are structural. Keep the major components separate and named. Include the electronics service volume and maintenance direction even if the assembly has no detailed electronics.

## Integration checks after STEP arrives

1. Normalize the STEP coordinates and map its vehicle front/approach axis to the study's assumed +Y direction, or transform the gripper into the team's coordinates. Record the chosen origin and mount plane.
2. Replace the assumed 42 x 58 mm / Ø5.5 mm plate interface with real frame geometry. Check edge distance, through-bolt/backing access, member thickness, tool access, and the load path through the bridge into both sides of the chassis.
3. Place the whole end-effector package at the mount and check open, nominal, and hard-close poses, the actuator/guard/cable envelope, and the full approach/release corridor against all eight thruster guards, camera view, foam, tether, and task-area access.
4. Check maintenance states separately: remove the gripper module, open the top service volume, remove/reinstall the electronics housing, reach its connectors, remove the actuator cover, and access the gripper mounting fasteners. Include the actual tool removal path rather than only testing the installed pose.
5. Add manufacturing and assembly clearances, not only coincident nominal surfaces. Review camera visibility and the vehicle's final outer dimensions/mass budget with the tool installed.
6. Once prop and actuator loads are measured, calculate or test bridge deflection and fastener/joint strength under jaw reaction torque, axial push/pull, and off-axis handling. The current screenshot, ghost bay, isolated adapter STL, and plate dimensions do not prove any of these.

## Open interface decisions

- Which frame member or front bridge can take the actuator reaction torque and tool push/pull load?
- Is the center plane structural, electronics-only, or a removable service shelf? What is its material and thickness?
- What is the vehicle's true front datum and which four/eight thruster axes/guards define the tool approach corridor?
- What is the electronics housing removal direction and required hand/tool service volume?
- What are the team's allowable tool overhang, tool mass/center-of-gravity, and buoyancy limits?

Until those inputs are measured in the STEP assembly, retain the adapter plate, hole pitch, tie width, and package clearance as study geometry. Do not call the mount vehicle-compatible or fabrication-ready.
