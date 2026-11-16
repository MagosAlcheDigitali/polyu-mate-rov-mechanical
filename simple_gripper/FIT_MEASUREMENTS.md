# Simple gripper drive fit sheet

Reference: `Michelangelo Dealberti FInal Clamp Design.stl`. The center member is already part of this gripper; the model adds a drive saddle around it and does not add a replacement rod.

## Interfaces used

| Interface | Model value | STL basis / status |
|---|---:|---|
| Existing center member axis | Y | Component 5 bounds run from Y=-38.000 to +14.445 mm |
| Center member section | 20 x 20 mm | Component 5 bounds: X=-36.397…-16.397, Z=51.751…71.751 mm |
| Center member center | X=-26.397, Z=61.751 mm | Component 5 center |
| Split saddle bore | 20.6 x 20.6 mm | 0.6 mm total nominal clearance; check the actual member surface |
| Saddle outside | 28 x 28 mm | 22 mm axial length with two M3.4 clamp-bolt passages |
| Rack motion | Y, +/-20 mm preview | Provisional travel range |
| Pinion axis | X | Gear face lies in the Y-Z plane |
| Pinion | module 1.5, 16 teeth | Approximate visual gear geometry |
| Servo output datum | 4 mm shaft, servo body omitted | Confirm selected servo shaft/coupling before manufacture |
| Pitch | +/-20 degree preview | Clamp, drive, and cradle rotate about X |

The rear end is assumed to be the negative-Y side. `rack_direction` in the SCAD source controls that orientation.

## Model limits

The STL is a static mesh and does not carry assembly motion constraints. At the neutral setting, the saddle is placed around the measured square member. Changing `rack_travel_mm` moves the rack/saddle to show drive travel, while the reference STL remains in its neutral pose; this preview does not animate the internal jaw parts.

The model does not establish the exact rack stroke needed to open/close the jaws, contact pressure required at the saddle, gear tooth contact, pitch actuator selection, vehicle bolt loads, or full collision clearance. The rack, pinion, mounting datum, and saddle are layout geometry for the user's existing gripper—not a fabrication release.
