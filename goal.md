# Goal: standalone servo-driven simple gripper

Design a simple gripper mechanism around only the supplied reference mesh, `Michelangelo Dealberti FInal Clamp Design.stl`.

## Required behavior

- The gripper's existing central rod slides axially to open and close the clamp.
- A rack bar is mechanically clamped to that rod with a split sleeve and set screws. A pinion turns the rack; a rear-mounted servo connects to the pinion shaft through the mounting interface. Do not model the servo body.
- Split saddle bands fasten the clamp body to a moving cradle. The rack guides, pinion support, and servo interface are attached to the same cradle.
- X-axis trunnions on the moving cradle sit in a fixed pitch yoke so the complete gripper and drive tilt together.
- Provide a moving pitch-link arm and fixed yoke anchor so a pushrod/actuator can control the pitch. Do not use a larger rotary-jaw or vehicle design as the basis.

## Deliverables

- Parametric OpenSCAD assembly in `simple_gripper/` using the supplied STL and showing the rod sleeve-to-rack link, body saddle-to-cradle link, rack/pinion/shaft link, trunnion/yoke link, and pitch-link interfaces.
- Design note and dated `progress.md` entry describing operation, fit assumptions, and remaining validation.

## Current status

The CAD now includes each mechanical interface, with adjustable dimensions for the exposed center rod and two clamp-body saddle stations. The reference STL remains the layout basis. The rod diameter/end location and body sections at the saddle stations still need exact measurement against the mesh/physical gripper; verify those fits and the pitch linkage before fabrication.
