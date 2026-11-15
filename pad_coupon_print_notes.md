# Pad Contact Coupon Notes

These are quick, unpowered contact samples for comparing the existing pad profiles by hand against practice objects. They do not change the gripper's load path, jaw opening, or actuator selection.

## Files

- `pad_coupon_round_channel.stl` — open round channel for cylindrical handles or shafts.
- `pad_coupon_v_channel.stl` — open V groove for angular bars or handles.
- `pad_coupon_flat.stl` — flat contact face for edges or surfaces.
- `pad_coupon_pair_round_round_24mm.stl`, `pad_coupon_pair_v_v_24mm.stl`, and `pad_coupon_pair_flat_flat_24mm.stl` — matching fixed/moving pad pairs.
- `pad_coupon_pair_flat_v_24mm.stl` — an asymmetric flat anvil / V-groove jaw pair for comparison.
- `gripper_study.scad` — authoritative parametric source; set `part_view = "pad_coupon"` and choose `insert_style` to export another profile. The `pad_size` and `pad_channel_radius` parameters can be changed from measured props.

For paired exports, set `part_view = "pad_coupon_pair"`, then choose `fixed_pad_style`, `moving_pad_style`, and `pad_coupon_pair_gap_mm`. In the assembly, the fixed anvil uses `fixed_pad_style` and the moving jaw uses `moving_pad_style`. Both default to the same `insert_style`; separate styles are optional study settings, not a selected final arrangement.

## Current dimensions and use

The STL coupons use a nominal 9 x 24 x 14 mm blank from the SCAD defaults, in model millimetres. The channel cuts change the final shape, and the faceted round-over makes the exported bounds differ slightly from the nominal blank. Paired STL files place the two nominal blank faces 24 mm apart; a channel groove changes the actual local contact gap. They are pads without the jaw, fasteners, keeper strips, or a structural backing. Treat them as fit/contact samples only, not as load-bearing parts or final elastomer selection.

Compare insertion, capture, slip direction, snagging, release, and visible damage on the actual or dimensionally faithful practice props. Test wet if the mission interaction will be underwater. Record prop dimensions, contact location, pad material, compression, and pull direction in `gripper_interface_measurements.md`. Never test against plant foliage unless the official grasp zone allows it.

## Print and material boundary

The CAD gives shape only. It does not specify a validated polymer, hardness, print orientation, infill, durability, or wet friction. Use low-force unpowered samples first; select the contact material after wet slip and damage trials. The complete jaw retains pads with keeper strips and fasteners; adhesive alone is not the design retention method.

## Fair comparison procedure

1. Export round, V, and flat coupons at the same nominal blank size and from the same candidate material/process batch. Record slicer version, nozzle/layer settings, print orientation, and material lot; do not compare profiles printed with different settings.
2. Orient each coupon so the channel opening faces upward during printing and keep the groove axis parallel to the build plate. This avoids placing support material on the contact surface. Rotate in the slicer if needed; the STL coordinates are not a prescribed print orientation.
3. Use the same number of perimeters and the same infill settings for all samples. Do not infer structural strength from the coupon; it has no jaw backing or fastener retention.
4. Before wet trials, check each coupon against the measured prop/replica by hand for capture, release, snagging, and contact area. Reject any sharp flash or visibly damaged insert before testing.
5. In a secured, unpowered hand fixture, run three approach/grip/release cycles per profile, then three wet retention pulls in each required direction. Record peak force, slip, release difficulty, visible surface damage, and damage to the prop. Stop before the prop's known safe-contact limit; if that limit is unknown, use only gentle hand loading and do not test a delicate sample.
6. Repeat the comparison with the same prop orientation and pull direction for every profile. Choose a profile only from the measured task contact and retention results; the default round channel is not a selected mission solution.

| Trial record | Entry |
|---|---|
| Prop or faithful replica / measured grasp feature |  |
| Feature diameter or width / usable contact length |  |
| Coupon profile / material / print lot |  |
| Print orientation and slicer settings |  |
| Wet/dry condition and test fixture |  |
| Pull direction / three peak-force readings |  |
| Slip, snag, release difficulty, or prop damage |  |
| Preferred profile and reason |  |

These are coupon comparison checks only. They do not qualify the pad, keeper strips, screws, jaw, actuator, or vehicle mount for powered or underwater mission loads.
