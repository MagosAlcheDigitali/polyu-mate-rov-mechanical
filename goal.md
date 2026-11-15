# Goal: standalone servo-driven simple gripper

Design a simple gripper mechanism around only the supplied reference mesh, `Michelangelo Dealberti FInal Clamp Design.stl`.

## Required behavior

- A central rod slides axially in and out to open and close the gripper.
- A servo sits behind the gripper and turns a pinion. The pinion meshes with a rack on the sliding rod, converting servo rotation into linear travel.
- Do not model or include the servo body. Show only the pinion/shaft and a generic, adjustable mounting interface.
- The gripper and its rack drive tilt together up and down about a separate pitch pivot.
- Keep this as a standalone gripper assembly. Do not use a larger rotating-jaw or vehicle design as the basis.

## Deliverables

- A parametric OpenSCAD layout in `simple_gripper/` showing the supplied clamp mesh, central sliding rod/rack, guides, pinion, and pitch yoke.
- A short design note with the operation, adjustable assumptions, and checks needed before fabrication.
- This file and `progress.md` track the goal.

## Current status

Concept layout is in the repository. It is a mechanism study, not a print-ready release: the STL does not expose a verified moving-rod interface in mesh metadata, and the final jaw connection, servo bolt pattern, clearances, strength, and physical travel still need measurement and validation.
