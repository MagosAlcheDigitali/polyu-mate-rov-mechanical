# SER top-face mount architecture study

This is a separate layout concept that addresses the package collision in the generic actuator mount. It rotates the 70 × 32 × 67 mm SER case 90° around its output axis, attaches a 66 × 36 mm face plate to the drawing-based 35 × 22 mm top-hole pattern, adds narrow post tabs for a 48 × 66 mm overall plate envelope, supports that plate on four posts, and carries the posts into a widened lower-bearing bridge. A short Ø34 mm guard encloses only the shaft coupler between the servo and pivot bearing; it does not wrap the sealed servo case.

The intended drive torque path is servo case top holes → adapter plate → four posts → lower-bearing bridge → yoke. The gripper's stop-impact load must remain on the pivot shaft, fixed stop and yoke; it must not be routed through the servo-case screws. The bridge retains the existing lower-yoke attachment hole datum as a placeholder and has a widened 48 mm span for the support posts. The output shaft, coupler, fasteners and bridge details are simplified proxies.

## Geometry screens

- The rotated case is 32 mm wide across the yoke; posts are centered 20 mm off-axis and have a nominal 2 mm gap from the case side.
- Each post is nominally 1 mm outside the Ø34 mm coupler guard's outer radius at its nearest corner; the source checks this simplified radial clearance.
- The face plate's rectangular corner radius is 37.59 mm. In a hypothetical same-plane Ø84 mm bore it leaves 4.41 mm radial margin. The adapter plate does not fill the entire actuator top face; it keeps the fastener pattern and includes narrow post-attachment ears.
- The 48 × 40 mm bridge is centered 12 mm aft of the pivot axis; its farthest corner is 40 mm from the axis. If it shares a plane with the existing Ø84 mm bore, nominal radial margin is 2 mm. The bridge uses a Ø12.4 mm bearing opening and retains the current yoke attachment-hole coordinates as a reference only; no actual vehicle/yoke or complete stop-sector geometry is shown in this isolated study.

## Open items

This is not an integrated gripper, vendor-STEP fit, selected actuator, load-rated mount, guard approval, or fabrication release. Obtain BTE's official November 2026 servo STEP and verify exact case corners, top/side holes, D-flat, connector and cable exit. Confirm the bridge against the actual pivot stack, yoke, guard and body STEP. Size the four face screws, posts, bridge and yoke joints from measured actuator duty and task loads; keep hard-stop loads independent. The servo rotation also needs a cable-exit and thruster/camera/service-clearance check.

Run `validate_ser203x_topmount_architecture.ps1` to compile, export plate, bearing-bridge and post study STLs plus the preview, and check the modeled post/case, post/guard, coupler/guard and plate/case intersections. Empty modeled intersections are only static geometry evidence.

