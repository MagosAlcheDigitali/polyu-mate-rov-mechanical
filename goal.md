# Goal: standalone servo-driven simple gripper

Design a simple gripper mechanism around only the supplied reference mesh, `Michelangelo Dealberti FInal Clamp Design.stl`.

## Required behavior

- The gripper's existing central rod slides axially to open and close the clamp.
- A rack bar is mechanically clamped to that rod with a split sleeve and two set screws. A pinion turns the rack; a rear-mounted servo couples to the pinion shaft through a generic interface. Do not model servo bodies.
- Split saddle bands fasten the clamp body to a moving cradle. Rack guides, pinion support, and the servo shaft interface attach to the same cradle.
- X-axis trunnions on the moving cradle sit in matching fixed yoke bearings so the complete clamp and drive tilt together without binding.
- Provide pin interfaces on the moving cradle and fixed yoke for a pitch actuator/linkage.
- Keep this as a standalone simple gripper based on the supplied STL only.

## Deliverables

- Parametric OpenSCAD assembly in `simple_gripper/` showing the supplied STL and the mechanical connection path from gripper rod to rack/pinion and from clamp body to moving cradle to fixed pitch yoke.
- Design note and dated `progress.md` entries describing the connections and their remaining fit checks.

## Current status

The CAD includes explicit mechanical connection features: split rod sleeve with radial screws and a rack side web; bolted split body saddles tied to a cradle spine; a pinion cross-pin and servo-side shaft stub; coaxial X-axis trunnions and yoke bearings; and pitch-link pin holes in the moving arm and fixed anchor. Exact rod and saddle dimensions remain adjustable until measured against the mesh/body. Inspect clearances and linkage travel before fabrication.
