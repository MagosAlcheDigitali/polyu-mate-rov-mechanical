# Simple gripper rack drive and pitch cradle

This subassembly uses only `Michelangelo Dealberti FInal Clamp Design.stl` as its gripper reference. It leaves the clamp intact and adds a rack drive around the existing center member plus a pitch cradle.

## Drive layout

- The connected-component measurements identify the square center member (component 5) at approximately X=-26.397 mm, Z=61.751 mm, with a 20 x 20 mm section along Y. The rack now follows this Y axis.
- A split square saddle captures that existing member and joins directly to the rack with a side web. No replacement center rod is added.
- The rack teeth face the pinion; rack translation is along Y and pinion/output shaft rotation is about X. A generic 4 mm output shaft and a rear mounting datum are included. The servo body is intentionally omitted.
- Rack guides and the pinion datum attach to the cradle so the drive tilts with the clamp.
- The clamp and drive rotate together about the X pitch axis. The vehicle side uses a fixed yoke and a pin-to-pin telescoping pitch-link proxy. No pitch actuator body is included.

## Files

- `rack_and_pinion_pitch_layout.scad` — parametric assembly. Set `rack_travel_mm` for rack motion and `tilt_angle_deg` for pitch.
- `FIT_MEASUREMENTS.md` — mesh-derived member dimensions and remaining fit inputs.
- `reference_mesh_components.md`, `reference_mesh_axis_sections.md`, and `reference_mesh_projection.svg` — geometry inspection records.
- `pitch_-20.png`, `pitch_0.png`, and `pitch_20.png` — rendered down, neutral, and up pitch poses.
- `simple_gripper_tilt_model.zip` — model source and the reference STL in the correct relative folder layout.

## Limits

The supplied STL is a static mesh, so it does not encode the jaw motion. This model shows the rack and square saddle pushing/pulling the existing center member; it does not animate the internal jaw parts. The saddle bore, member direction, rack stroke, rack/pinion tooth engagement, pitch-link range, and vehicle mounting loads still need final fit checks before fabrication.
