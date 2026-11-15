# Gripper Geometry Mockup Meshes

These 25 STL files were exported from `../gripper_study.scad` with OpenSCAD 2021.01 after the 15 November 2026 CAD update. Units are millimetres. Component views retain assembly coordinates, so translate and orient them as needed for an unpowered shape mockup.

**Repository note (15 November 2026):** this inventory and the source CAD are on the public GitHub snapshot, but the generated STL mesh bundle remains in the local project folder and is not mirrored there yet. Do not interpret a missing repository mesh as a completed print release.

## Inventory

| File | OpenSCAD view | Use and limits |
|---|---|---|
| `adapter_plate.stl` | `adapter_plate` | Generic vehicle interface mockup; the current plate is 84 x 6 x 82 mm and its hole pattern is assumed. |
| `support_yoke.stl` | `support_yoke` | Yoke/fixed-anvil envelope mockup; the rear tie now matches the 84 mm plate width. |
| `fixed_contact.stl` | `fixed_contact` | Fixed rail, pad, keepers, and fastener proxies. |
| `fixed_pad_insert.stl` | `fixed_pad_only` | Replaceable fixed contact shape mockup. |
| `fixed_keeper_strips.stl` | `fixed_keeper_strips_only` | Fixed pad keeper arrangement. |
| `fixed_keeper_fasteners_mockup.stl` | `fixed_keeper_fasteners_only` | M3 screw proxies; not a hardware specification. |
| `fixed_pad_thread_inserts.stl` | `fixed_pad_thread_inserts_only` | Tappex M3 insert geometry proxies; host-material retention is unqualified. |
| `jaw_assembly.stl` | `jaw_assembly` | Moving jaw, pad, keepers, and fastener-proxy assembly. |
| `moving_jaw_body.stl` | `moving_jaw_body_only` | Moving jaw body mockup; pad rail is 12 mm thick. |
| `moving_pad_insert.stl` | `moving_pad_only` | Replaceable moving contact shape mockup. |
| `moving_keeper_strips.stl` | `moving_keeper_strips_only` | Moving pad keeper arrangement. |
| `moving_keeper_fasteners_mockup.stl` | `moving_keeper_fasteners_only` | M3 screw proxies; not a hardware specification. |
| `moving_pad_thread_inserts.stl` | `moving_pad_thread_inserts_only` | Tappex M3 insert geometry proxies; host-material retention is unqualified. |
| `pad_retention_coupon.stl` | `pad_retention_coupon` | Assembled visual reference containing printed solids for screw and insert proxies. Do not print as the functional fit coupon. |
| `pad_retention_coupon_body.stl` | `pad_retention_coupon_body_only` | Printable rail coupon with pilot bores for real M3 inserts; `Simple: yes`, 2,588 triangles. |
| `pad_retention_coupon_pad.stl` | `pad_retention_coupon_pad_only` | Printable contact insert; `Simple: yes`, 1,608 triangles. |
| `pad_retention_coupon_keepers.stl` | `pad_retention_coupon_keepers_only` | Printable keeper strips; `Simple: yes`, 4,888 STL triangles (3,200 CGAL facets). |
| `bearing_set.stl` | `bearing_set` | Bearing-ear and fastener-proxy arrangement. |
| `pivot_shaft.stl` | `pivot_shaft` | Shaft shape mockup using the DIN 471 size-8 groove reference; selected shaft and ring strength remain unresolved. |
| `axial_retention.stl` | `axial_retention` | Washer/ring proxy stack; select and verify matched hardware before loading. |
| `stop_sector.stl` | `stop_sector` | Fixed stop-sector envelope. |
| `rotating_stop.stl` | `rotating_stop` | Rotating stop-arm envelope; the integral printed stop pin is not approved for powered use. |
| `stop_guard.stl` | `stop_guard` | Stop guard and fastener-proxy fit mockup. |
| `actuator_reaction_mount.stl` | `actuator_reaction_mount` | Bracket packaging around an assumed 20 mm diameter body. |
| `actuator_package.stl` | `actuator_package` | Actuator packaging visualization only; OpenSCAD reported `Simple: no` and a manifold warning. Do not print or use for actuator selection. |

All 25 STL exports are current with the source geometry. OpenSCAD reported `Simple: yes` for the individual component views except `actuator_package.stl`. The coupon print pieces were rendered separately and each STL has a correct terminator; only `pad_retention_coupon_body.stl` has the insert pilot holes and should be used for real insert installation. Direct STL triangle counts are 2,588 for the body, 1,608 for the pad, and 4,888 for the keepers. The assembled `pad_retention_coupon.stl` is for visual reference because STL carries no distinction between hardware proxies and printable parts. The adapter plate is 84 x 6 x 82 mm (1,772 triangles), support yoke 84 x 97 x 42 mm (2,068 triangles), fixed contact 20.997 x 26.998 x 20.3 mm (9,360 triangles), and jaw assembly 29.444 x 46.193 x 20.3 mm (10,580 triangles). Other component bounds and export logs should be regenerated from the source if needed for a fabrication drawing.

The complete `../gripper_toolonly_preview.stl` assembly review mesh has 44,772 triangles and direct bounds of 95 x 103.198 x 112 mm. OpenSCAD reported `Simple: no` and a multi-volume/manifold warning. Keep it as a review mesh, not a one-piece print file.

## Prototype limits

- These are geometry mockups for manual, unpowered fit checks. A `Simple: yes` result does not establish vehicle/prop fit, material choice, strength, wet retention, depth rating, safety inspection, or powered operation.
- The adapter pattern, 20 x 45 mm actuator body, shaft, coupling, retaining parts, stop, and vehicle interfaces remain study placeholders.
- The pad thread insert dimensions are a manufacturer-based fit candidate. Print the coupon in the actual rail material and process, inspect the insert and screw fit, and measure retention before using the joint under load.
- The `jaw_frame_overlap` and `pad_overlap` CAD views check selected discrete poses only. They do not cover tolerances, continuous motion, keepers, fasteners, props, body geometry, or deformation.
- Do not power the integral printed stop pin. No mesh is a load-rated or final fabrication file.

