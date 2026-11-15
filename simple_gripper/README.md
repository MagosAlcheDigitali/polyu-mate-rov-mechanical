# ARCHIVED EXPERIMENT — NOT THE ACTIVE END EFFECTOR

This rack-and-pinion plus pitch-cradle layout is an earlier standalone experiment around `Michelangelo Dealberti FInal Clamp Design.stl`. The active end-effector concept is the pivot jaw in the workspace-root `gripper_study.scad`. Do not use this folder's default geometry for fabrication or powered operation.

## Verified audit findings — 15 November 2026

- OpenSCAD compilation reports an undefined `servo_output_end_y` datum in the generic servo-interface module. The servo, horn/coupler interface, and actual shaft dimensions are not selected.
- **Cawl — rack/pinion review:** the rack rotation sign is wrong when `rear_sign = +1`; the near rack guide intersects the moving sleeve near the travel limit; and the two-guide layout does not fit within the current rack length without redesign. The gear mesh and full-stroke clearance have not been validated.
- **Dalathrust — clamp/cradle review:** the default saddle stations at Z≈3.8 and 27.8 mm do not match the local clamp sections. Candidate stations at Z=102 and 116 mm require different contoured profiles; the monolithic STL cannot identify fixed versus moving regions or validate clearance over motion. They are packaging leads only.
- The pitch linkage has no selected actuator, pushrod length/stroke, hard stops, or verified range. The shaft-to-servo torque connection and servo mounting pattern are not defined.

## Files and controls

- `rack_and_pinion_pitch_layout.scad` — parametric but unvalidated mechanism study.
- `../Michelangelo Dealberti FInal Clamp Design.stl` — original reference mesh.

The parameters can still support an educational layout discussion, but no assembly fit, torque transfer, jaw stroke, pitch range, clearance, or structural performance is established. Use the root `gripper_study.scad` and its review documents for the active project direction.
