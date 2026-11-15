# Gripper Interface Measurement Sheet

## Current vehicle-mesh evidence

The team-supplied [`vehicle body concept STL`](vehicle_reference/vehicle_body_concept.stl) has 3,860 binary-STL triangles and coordinate bounds X −124.409…348.409, Y −171…85, Z −266…442 (472.819 × 256 × 708 coordinate units). The file has no encoded units or separated component names. Treat these as raw model coordinates, not confirmed millimetres or vehicle fit. The mesh only supports rough envelope/collision review; it does not define the bay, structural mount, thruster guard solids/axes, camera, or maintenance envelope. Confirm units, origin, front/approach axis, frame members, and mount datum from the team before any placement.

Use this with the physical practice props or accurate replicas before changing the OpenSCAD defaults or selecting an actuator. Record units, the prop/source, measurement method, and date. Do not infer a contact dimension from a perspective photo.

MATE's [2027 Official Rulings](https://docs.google.com/document/d/e/2PACX-1vS-i5t8yrwIYMjHzpS6sSYyuG8_quCGhyDMnxPqG2eDmI6QacK08fTVS2_VQF-d1vfjA7ydJgbu4itI/pub) state that a team may grip any portion of a mission prop to carry it; a dedicated carrying feature is optional. Record several reachable, non-damaging carry-contact candidates rather than assuming a handle is mandatory. Keep carry-contact candidates separate from the task-operation interface (port, latch, mounting face, planting or docking feature), whose handling still depends on the detailed task instructions and actual prop.

## A. Geometry and grasp points

Measure each item at the location the gripper can actually reach. Use millimetres unless the prop drawings specify another unit.

| Mission item / action | Reachable grasp feature | Minimum width / diameter | Maximum width / diameter | Usable contact length | Cable / obstruction clearance | Grasp allowed here? | Notes / photo ID |
|---|---|---:|---:|---:|---:|---|---|
| Seagrass sample collection | Holder/base, not foliage |  |  |  |  |  |  |
| Seedling placement | Carrier/base or approved grasp zone |  |  |  |  |  |  |
| New crab trap deployment | Any reachable, non-damaging portion for carrying; test bars, frame, and solid surfaces |  |  |  |  |  |  |
| Old crab trap recovery | Any reachable, non-damaging portion for carrying; include floor-access positions |  |  |  |  |  |  |
| Primary node placement | Any reachable body/rail area for carrying; record the node's separate mounting interface |  |  |  |  |  |  |
| Pressure/tilt sensor placement | Sensor body / mounting feature |  |  |  |  |  |  |
| Generator-port cover removal | Exposed lip, loop, or handle |  |  |  |  |  |  |
| Power / communications connector | Plug body; note keying and cable exit |  |  |  |  |  |  |
| Breaker operation | Lever, slider, or push surface |  |  |  |  |  |  |
| Solar panel removal/replacement | Any non-damaging frame or sheet portion for carrying; record the separate retention/release feature |  |  |  |  |  |  |
| Dropped tool recovery | Any reachable, non-damaging portion for carrying; test body and shaft contacts |  |  |  |  |  |  |
| SGANT installation | Any suitable base/body area for carrying; do not assume the mast is a safe contact |  |  |  |  |  |  |
| Cargo docking | Safe push/contact surface |  |  |  |  |  |  |

For each plug, also record its body shape, key orientation, latch or twist action, insertion depth, cable bend radius, and whether the ROV can approach along the connector axis. Do not use the cable itself as the grasp feature.

## B. Loads and travel

Use a force gauge or spring scale on the actual prop. Test underwater where practical, since buoyancy, drag, and wet friction change the loads. Repeat each measurement three times and record the highest measured value and the direction of pull/push.

| Interface / operation | Force direction | Peak force (N) | Travel (mm or degrees) | Test condition / fixture | Trial 1 | Trial 2 | Trial 3 | Damage or slip observed? |
|---|---|---:|---:|---|---:|---:|---:|---|
| Grip retention, crab-trap bar | Tangential to jaw pads |  |  | Wet; pull in worst carry direction |  |  |  |  |
| Grip retention, dropped tool | Tangential to jaw pads |  |  | Wet; test multiple orientations |  |  |  |  |
| Grip retention, panel frame | Tangential to jaw pads |  |  | Wet; test intended grasp location |  |  |  |  |
| Grip retention, primary node / SGANT | Tangential and off-axis at approved grasp point |  |  | Wet; test planned carry orientation and turns |  |  |  |  |
| Seedling holder retention | Tangential to soft pads |  |  | Wet; note maximum safe squeeze |  |  |  |  |
| Cover release | Pull away from port |  |  | Wet; record release direction |  |  |  |  |
| Connector insertion | Along connector axis |  |  | Wet; keyed alignment correct |  |  |  |  |
| Connector removal | Along connector axis |  |  | Wet; latch operated as intended |  |  |  |  |
| Breaker actuation | Push / pull / rotate |  |  | Wet; record required direction |  |  |  |  |
| Panel release and seating | Normal to panel frame |  |  | Wet; record retention and seating |  |  |  |  |
| Node / sensor / SGANT seating | Along mounting axis |  |  | Wet; record alignment sensitivity |  |  |  |  |
| Cargo payload docking | Axial push and lateral guide load |  |  | Wet; contact only at approved surfaces |  |  |  |  |

For each jaw-grip trial, record the jaw angle at first contact and the pad location that carries the load. Also record the submerged weight or buoyancy of each carried item, expected ROV acceleration/turning, and the team's chosen design factor. Keep the minimum holding force and maximum allowable squeeze as separate requirements for delicate items.

## C. Vehicle mounting and clearance

| Vehicle input | Measurement / value | Datum / view / photo ID |
|---|---|---|
| Units used for body model |  |  |
| Vehicle front and tool approach axis |  |  |
| Structural mount face and available flat area |  |  |
| Mount-hole coordinates and fastener access |  |  |
| Available forward overhang and full vehicle length/width/height with gripper fitted |  |  |
| Gripper plus adapter mass and remaining vehicle weight budget |  |  |
| Rear-face clearance for tool-plate fastener heads / vehicle bracket |  |  |
| Material and thickness of mount members |  |  |
| Roofless service-bay frame versus sealed electronics housing; housing envelope, 6 m rating, and removal path |  |  |
| Camera lens position and field of view |  |  |
| All eight thruster axes and full guard envelopes, including 45-degree units |  |  |
| Tether path and minimum bend radius |  |  |
| Gripper/actuator cable route, ROV-side strain relief, frame attachment, service loop, and clearance from the jaw/prop approach path |  |  |
| Electronics-bay access envelope |  |  |
| Available power rail, fuse, and current headroom |  |  |
| Candidate actuator envelope, output-shaft dimensions/protrusion, axis, mount pattern, and cable exit |  |  |
| Actuator housing/flange mounting faces and bolt pattern; stator reaction-torque path into the yoke |  |  |
| Output-shaft diameter/profile and protrusion; coupling engagement on both shafts and axial gap |  |  |
| Pivot-shaft axial-retention method and available clearance at both bearing ears |  |  |
| Rotary actuator output torque (continuous/peak), speed, duty cycle, and unpowered holding/brake behavior |  |  |
| Actuator service/removal path and required tool clearance |  |  |
| Guarded actuator/coupler and stop-sector envelopes; as-built opening sizes |  |  |
| Safety-review decision for the powered jaw-mouth pinch zone; reviewer/date |  |  |

### Thruster layout register

The written body description is internally ambiguous: it can be read as four horizontal thrusters plus four 45-degree units, but it also mentions only two rear horizontal thrusters. Do not place the gripper or set its approach corridor from that prose. Fill all eight rows from the body CAD or a dimensioned drawing, and identify every thruster by its actual position and thrust axis.

| ID | Mount position from body datum (x, y, z) | Thrust-axis unit vector (x, y, z) | Horizontal / 45° / other | Guard envelope or CAD part | Cable/prop-snag clearance to gripper sweep | Verified from CAD/drawing? |
|---|---|---|---|---|---|---|
| T1 |  |  |  |  |  |  |
| T2 |  |  |  |  |  |  |
| T3 |  |  |  |  |  |  |
| T4 |  |  |  |  |  |  |
| T5 |  |  |  |  |  |  |
| T6 |  |  |  |  |  |  |
| T7 |  |  |  |  |  |  |
| T8 |  |  |  |  |  |  |

Use one consistent body coordinate system and state its origin and forward direction above or in the vehicle CAD. A nominal 45° label is insufficient for collision checking; record the actual axis vector and guard solid, including propeller sweep and cable exit.

Check the jaw through its entire open/closed sweep against thruster guards, camera view, tether, bay access, and the target approach corridor. The tool mount must transfer push and pull loads into the structural frame, not an unsupported electronics enclosure face.

## D. Translate measurements into CAD changes

| Measurement result | CAD parameter / design decision |
|---|---|
| Largest and smallest reachable handle or frame width | Set the open gap for the largest feature plus insertion clearance, then solve the pivot geometry and closing sweep for the smallest feature. Do not increase `jaw_gap` alone: with the current 35.5 mm far-pad arm and a `jaw_gap` of 80 mm (62 mm nominal opening), the theoretical minimum is about 37.5 mm and the modeled hard stop leaves about 40.7 mm. At the same 45.456° hard-close angle, reaching a 20 mm gap would require about a 64.6 mm far-pad arm (about 82% more pivot torque at equal pad force); reaching 3 mm would require about an 88.4 mm arm (about 149% more torque). Treat these as ideal kinematic screens; a longer jaw, changed pivot, greater sweep, or parallel/sliding mechanism would also change packaging, torque, and stop loads. |
| Minimum object width to retain | Set the closing stop and soft-pad compression so the gripper can retain this object without metal contact. |
| Length of safe contact region | Set `pad_size[1]` and the jaw contact length; keep fasteners outside the usable contact area. |
| Round shaft diameter | Set `pad_channel_radius` to about half the measured diameter, then wet-test slip and release. |
| Flat panel/frame thickness | Use `insert_style = "flat"`; size pad length and compliant thickness around the actual frame edge. |
| V-shaped handle / bar contact | Use `insert_style = "v_channel"`; tune the channel depth and width from the real cross-section. |
| Maximum measured tangential retention load | Calculate wet pad normal force and pivot torque with the method in the concept brief. |
| Actuator body, output torque/speed, output shaft, and mounting dimensions | Check the rated output torque at the required closing speed and duty cycle, then check the body and coupler against support cheeks, bearing ears, camera view, pad sweep, cable exit, and service path. Set coupler length and clamp/key features so both shafts have sufficient engagement without axial collision; the current model's pivot-side overlap is only 3 mm. Do not size from advertised stall torque alone. |
| Actuator housing mount and stator reaction torque | Add a rigid, removable bracket from the actuator's mounting flange or clamp points into the structural yoke. Do not use the removable safety shroud as the motor's only torque reaction support. Check the mount fasteners for the actuator's peak torque and preserve the shaft/coupler service path. |
| Drive/coupler and stop-sector guard openings | Enclose the moving drive parts with a solid guard or openings below 12.5 mm; inspect seams and fastener clearances through the full jaw sweep. |
| Safety lead / inspector decision on the functional jaw-mouth opening | Record whether additional screening is required; revise the jaw and its guard before powered pool trials if the proposed contact opening is not accepted. |
| Maximum actuator torque at the hard stop | Check the stop pin in shear, the sector-slot wall in bearing, and the sector-plate/yoke joint; include the actuator's maximum torque or mechanical stall limit. |
| Connector insertion force and travel | Keep the ROV as the axial pusher; size the plug-body nest for alignment and retention, not for arbitrary port probing. |
| Breaker/cover travel and force | Add a blunt, replaceable pusher or hook tip only if the prop requires a distinct contact. |
| Frame and collision envelope | Set mounting plate pattern, reach, cheek spacing, and jaw stop from the STEP assembly. |
| Jaw-to-shaft fit and stop angles | Set the keyed hub clearance and hard-stop pin/slot from the measured jaw sweep; verify that the stops prevent pad or metal collision at maximum actuator torque. |
| Minimum hook, fixed-pad, and keeper-strip clearance at hard stop | Check the entire swept jaw against the fixed pad, keeper strips, anvil, and vehicle frame; preserve the team's chosen tolerance after fabrication and pad compression. |
| Available axial space above/below the bearing ears and actuator coupler | Verify the matched retaining-ring/thrust-washer stack against the modeled 1.0 mm upper and 0.5 mm lower placeholder clearances; check shaft groove strength, measured axial load, endplay, rotation wear, and interference with the stop arm, guard, and coupler. |

Do not order an actuator or release fabrication drawings until the largest grasp feature, delicate-item squeeze limit, required travel, measured loads, and vehicle mount datum have been entered above.

## E. Official mission clarifications

Record answers from the [MATE Q&A forum](https://materovcomp.discourse.group/) or an official 2027 mission document. Keep the topic URL/post number and date so the mechanical design review can distinguish confirmed requirements from team assumptions.

| Topic | Question / decision needed | Official answer or source reference | Date checked | CAD / test change required |
|---|---|---|---|---|
| Seagrass and seedlings | Approved grasp zone; carrier/holder geometry; contact-force limits |  |  |  |
| Crab traps and dropped tool | Handle/bar/shaft geometry; permitted contact; retention or lift condition |  |  |  |
| Generator cover, plugs, breaker | Cover release, connector/key/latch, insertion/removal travel and force, breaker travel and force |  |  |  |
| Node, sensor, SGANT | Mounting/grasp faces, approach axes, seating/level tolerance, connector layout |  |  |  |
| Solar panel and cargo | Allowed grip/push surfaces, payload/docking envelope, required final seating |  |  |  |
| Gripper safety | Inspector interpretation for the functional jaw-mouth pinch zone |  |  |  |

