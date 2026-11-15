# 2027 MATE ROV Explorer: End-Effector Concept Brief

**Status:** Preliminary concept, 15 November 2026  
**Purpose:** Translate the released 2027 Explorer task summary and vehicle rules into a prototypeable ROV gripper direction. This is not a dimensioned CAD release; task-prop interfaces and the team's vehicle model are still needed.

## 1. What the competition materials establish

The supplied `2027 MATE Floats Preview Mission_EXPLORER_FINAL.pdf` is the official Explorer preview for Task 3, the independent profiling-float task. It requires the float to operate on its own; the ROV cannot interact with it, so it gives no gripper interface. The grabber addresses the ROV product-demonstration tasks in Tasks 1 and 2. MATE's current [2027 Explorer resource page](https://materovcompetition.org/explorer) links to this preview, and the [all-classes product-demo briefing](https://20693798.fs1.hubspotusercontent-na1.net/hubfs/20693798/2027%20MATE%20ROV%20Competition/2027%20MATE%20Documentation/2027_MATE_ROV_Competition_Briefing_FINAL.pdf) supplies the ROV task action list. The briefing says all product-demonstration tasks are attempted within one run. **Design implication:** treat the gripper as one multi-task head with passive contact inserts and ROV motion supplying approach/alignment; do not make an underwater head swap a prerequisite for completing the run.

The official 2027 briefing lists ROV actions involving:

- collecting and deploying seagrass seedlings;
- deploying a new European green crab trap and bringing back the old trap;
- placing the primary node, installing a pressure/tilt sensor, connecting it to the node, and leveling it;
- removing a port cover and installing a power connector;
- operating a breaker, unplugging a power lead, removing/replacing a solar panel, and reconnecting it;
- securing and returning a dropped tool;
- maneuvering the cargo payload into a docking bay;
- installing the SGANT and, for Explorer, connecting its power and communications link.

As rechecked on 15 November 2026, MATE's [2027 season resource page](https://materovcompetition.org/2027) still lists the full Explorer manual and Part 1 Product Demonstration as pending. The [Explorer resource page](https://materovcompetition.org/explorer) lists prop-building instructions, parts lists, prop demonstration/Q&A, and mission-prop CAD, but those entries remain unlinked in the current page output. The separately published Explorer Part 2 specifications are available. Official 2025 and 2026 prop-building PDFs are historical documents for different seasons; do not use their prop dimensions to size a 2027 tool. The available [2027 all-class briefing](https://20693798.fs1.hubspotusercontent-na1.net/hubfs/20693798/2027%20MATE%20ROV%20Competition/2027%20MATE%20Documentation/2027_MATE_ROV_Competition_Briefing_FINAL.pdf) confirms action names and a high-level task sequence; it does not give contact geometry, latches, connector types, travel, force, or tolerances. Do not finalize jaw dimensions until the active 2027 Explorer Part 1/manual, prop instructions, and prop CAD are inspected.

### What the task list means mechanically

The task labels are not detailed manipulator specifications. The table below translates only the published action verbs into likely tool functions; every prop contact and fit remains unverified until the 2027 prop CAD/drawings are available.

| Published action group | Likely mechanical function | End-effector implication and unresolved interface |
|---|---|---|
| Collect/deploy seagrass seedlings | Gentle capture, transport, release | Grip a carrier/base or approved holder, never foliage by assumption; limit squeeze and add a compliant cradle only if the actual sample requires it. |
| Deploy new / recover old crab trap | Hook or clamp a bar/handle and retain during lift | Blunt hook plus V-channel insert is a plausible starting mode; trap handle geometry and submerged load are unknown. |
| Install primary node; place, connect, and level pressure/tilt sensor | Controlled grasp, orientation, seating, cable/connector handling | Jaw alone may not align a keyed part. Use ROV motion for fine positioning; need actual mounting faces, approach axis, seating force, and allowable roll/pitch error. |
| Remove generator-port cover; insert power connector | Pull cover, orient and push a plug axially | Requires a reaction face and plug-body grip that does not load the cable. Confirm latch/cover retention, connector key, insertion depth/force, and cable bend space before adding any connector-specific nest. |
| Disengage breaker; unplug/replug power; remove/install solar panel | Push/pull or actuate a lever, handle a cable plug, capture a panel edge | Broad blunt pusher and hook can supplement the jaw; panel needs a safe edge grasp. Breaker travel/force and panel release/retention geometry are unknown. |
| Recover dropped tool and return it | Acquire before/after bottom contact; maintain grip during transport | A self-holding jaw and open hook should tolerate varied approach orientation; test wet retention with the real tool and loss-of-power behavior. |
| Maneuver cargo into docking bay | Align and push payload into a receptacle | Treat as a vehicle-guided push unless prop instructions require grasping; protect the payload and avoid making the end-effector obstruct the dock. |
| Install SGANT and connect power/communications | Capture, orient, seat, then handle two links | Likely needs repeatable orientation and strain-safe connector work; verify whether both connectors and antenna can be handled with one jaw orientation or need a passive guide feature. |

**Architecture consequence:** keep one powered degree of freedom for a robust grasp. The current study already combines a broad blunt fixed anvil, a rounded hook at the moving jaw, and mechanically retained compliant pad inserts with round-channel, V-channel, or flat profiles. Do not add a second actuator or connector-specific feature until released prop geometry proves it is needed. If connector alignment proves critical, first consider a passive keyed guide cartridge that reacts insertion force into the tool frame while the jaw retains the plug body; never use the cable as the pulling point.

### Questions for MATE's official Q&A forum

These questions target the information that changes the jaw, pusher, load path, and actuator. The briefing calls out the tasks but leaves these interfaces undefined. The forum is linked from the [2027 resource page](https://materovcompetition.org/2027); the team can post them once the official props are being discussed.

1. **Object grasp zones and loads:** For seagrass samples/seedlings, crab traps, the dropped tool, primary node, sensor, solar panel, and SGANT, which surfaces may an ROV contact or grip? Are handles/carriers built into the props, and will dimensions, submerged weights, and any maximum contact forces be published?
2. **Generator and solar power interfaces:** What exact connector, keying/latch style, insertion/removal travel and force, cable exit/bend allowance, and generator-cover retention/release motion are used? What direction, travel, and force are required to disengage and re-engage the breaker?
3. **Placement and leveling:** What are the primary-node, pressure/tilt-sensor, and SGANT mounting features and approach axes? What seating force and sensor-level tolerance are accepted, and how are the sensor/SGANT power and communications leads terminated?
4. **Cargo and trap movement:** What are the cargo payload and docking-bay envelopes, permitted push/contact surfaces, and required final seating condition? For the new and old crab traps, what handle/bar features and retention requirements should teams expect?
5. **Jaw safety:** What review criteria will inspectors apply to an intentionally accessible, force-limited gripper jaw mouth, given Part 2's explicit guarding language for gears but no numeric jaw-mouth gap?

These are draft team questions, not additional MATE requirements. Record the official responses in the interface measurement sheet and revise the CAD against those responses rather than treating the provisional contact concepts below as confirmed prop geometry.

## 2. Recommended prototype direction

Build one **forward-facing, one-degree-of-freedom clamp** with a rigid tool plate, a fixed anvil, and one powered pivoting jaw. The ROV itself provides the approach and alignment motion. This is a simpler first prototype than a synchronized parallel-jaw linkage, and it keeps the actuator and linkage count down around the small central bay. Keep the grasp zone visible to the forward camera. A concept sketch is in [`gripper_concept.svg`](gripper_concept.svg).

The PNG supplied by the team appears to show the **vehicle-body concept**: a central cylindrical enclosure within an open frame, with yellow components near the front/bottom that may be thrusters or mounts. It is a useful arrangement reference, but it is not a dimensioned model and does not show the gripper. Do not treat the cylinder as the stated 250 x 150 x 150 mm electronics bay; confirm whether it is a temporary canister, a rendering placeholder, or a design change. The image cannot establish scale, vehicle-side mounting locations, thruster envelopes, or gripper/prop clearances. The gripper study is a separate schematic; it now includes proxy axial retainers and a provisional actuator reaction bracket, but the actuator and all vehicle interfaces remain placeholders. The actual body STEP/SLDASM and mission-prop models are still needed for fit and clearance checks.

### Gripper body

- One fixed anvil and one pivoting jaw driven by a single actuator/link. The anvil is the reaction surface for gripping and pushing; the jaw tip follows an arc, so prop clearance must be checked through the full stroke.
- Rounded, compliant jaw pads with drainage openings. Use replaceable non-marking elastomer or similar pads; avoid sharp teeth. The SCAD defaults both pads to the same selected profile, but exposes independent fixed-anvil and moving-jaw styles for fit studies. A shallow rounded U-channel can retain round handles, tubes, and tool shafts; a flat pad may better contact panel edges or delicate carriers. No asymmetric pair is selected until the prop contacts are measured.
- Do not grip seedling foliage directly. Inspect the sample/root holder and planting interface before shaping a low-force cradle or dedicated soft insert.
- Rounded inward hooks at the jaw tips to capture a loop, handle, or cage bar. Keep the hooks blunt and open enough to release by backing away.
- A broad, blunt nose on the fixed anvil that can push a cover, panel, sensor, or node into its seat while the ROV braces against the target.
- A short tapered lead-in around the jaw nose to help guide an object into the grasp and align a plug before insertion.
- Mechanical travel stops and solid, removable covers around the actuator coupling and stop linkage. The 2027 Explorer Part 2 requires gear assemblies to be fully shrouded to IP-20 (openings below 12.5 mm or solid covers) and forbids harmful sharp edges/points. It does not state a numeric jaw-mouth guard gap. Treat the working jaw's accessible pinch zone as a safety review item: use blunt, compliant contacts and limit closing force; have the team's safety lead review the jaw approach before powered pool operation. Do not describe the 12.5 mm gear opening limit as an explicitly stated jaw-mouth rule.

This is a multi-contact gripper, not a claim that one jaw shape will match every prop. If prop geometry shows a dedicated contact is necessary, add a low-profile captive-pin attachment or a second tool head; do not make underwater tool swapping a prerequisite for completing the run.

### Mechanical stack and load path

Prototype the assembly as these serviceable parts rather than one printed monolith:

1. **Vehicle adapter / bridge:** a bolted bracket that spans the ROV's structural side rails or front cross-member. It transfers push and pull loads into the frame and comes off without opening the electronics bay. In the study, four counterbored M3 screws connect the two yoke cheeks to the tool plate through insert sleeves; four separate holes attach the tool plate to the vehicle. The M3 pattern, insert type, plate counterbores, and engagement length are placeholders until the frame material and mount geometry are known.
2. **Yoke and pivot support:** the side cheeks carry the fixed anvil; two extended bearing ears reach forward from the right cheek and support the through-shaft above and below the moving jaw. Use replaceable bushings so a worn pivot does not require replacing the structural cheek. The study shows two M3 screws through each ear into heat-set insert placeholders in the yoke cheek; the 12 mm screw length covers the 4 mm ear and 8 mm insert depth. This is a preliminary joint detail, so check insert pull-out, screw shear, edge distance, ear bending, and yoke material before loading it. The revised stack now models split-ring and thrust-washer proxies outside both bearing ears, with 0.2 mm nominal axial endplay. The upper stop plate is raised to leave 1.0 mm nominal clearance above the upper ring; the lower drive gap is 2.0 mm, leaving 0.5 mm nominal clearance between the lower ring and coupling. The ring, groove, washer, endplay, and standoff dimensions are schematic placeholders: choose a matched ring/shaft system and confirm groove stress, axial load capacity, wear, and fastener support before assembly. Keep the actuator coupling as a torque connection, not the only shaft retainer.
3. **Fixed anvil:** the current study makes the blunt reaction rail integral with the yoke. Its wet-contact pad is replaceable; the metal/plastic reaction rail is not a separate cartridge in this CAD. If the prototype needs a separate anvil block, add and size its bolted joint after the team selects the frame material and measures seating loads.
4. **Moving jaw and stops:** the jaw hub has a D-profile bore that keys it to the pivot shaft. The jaw, shaft, and rotating stop arm now co-rotate as one keyed assembly; in the main CAD, the pin travels in a curved slot in a fixed sector plate, creating hard stops near -1.5 degrees open and 45.5 degrees closed around the 0–44 degree operating sweep. **This integral printed pin/slot remains unapproved for powered use.** The separate `powered_stop_layout_study.scad` illustrates an alternative double-supported pin and two keyed replaceable stop blocks with a nominal 44-degree layout sweep; it is not integrated with the main gripper, dimensioned for an actuator, or load-rated. The latest analytic hard-close estimates are a 3.18 mm pad gap and 4.02 mm hook-to-fixed-pad clearance. These changed with the pivot offset; they remain bounding estimates, not a substitute for a solid-interference sweep with print tolerances. The 44 mm stop-sector envelope is modeled as a fixed skirt and removable lid held by four illustrative M3 screws; the lid has a nominal 11.5 mm shaft opening. Two internal feet now bolt the skirt and sector plate through the upper bearing ear with M2 screws and nuts. Check the small fasteners, tab roots, stand-offs, plate bearing stress, stop pin, and overtravel against the selected actuator's maximum output torque.
5. **Drive and cover:** the study places a coaxial geared-actuator envelope beyond the right-cheek edge, with a coupling proxy between drive and pivot shaft. It now includes a provisional two-piece Ø20.5 mm ID / Ø28.5 mm OD clamp ring, two narrow reaction rails and feet tied into the lower bearing ear, and a split Ø38 mm outer / Ø34 mm inner guard. These are generic proxies around an assumed Ø20 mm body; they are not sized for any selected actuator, and the clamp torque capacity is unknown. The pivot is offset 20 mm forward of the cheek edge to give the larger guard nominally 1 mm clearance from the cheek; verify in the full assembly. The guard encloses a 14 mm diameter, 8 mm long coupling proxy within a 21 mm diameter motor-cavity section; the stop-sector lid has a nominal 11.5 mm shaft opening, below MATE's 12.5 mm IP-20 aperture limit. The coupling has separate 3 mm blind engagements for a placeholder 6 mm motor shaft and the 8 mm pivot shaft, with a 2 mm center web; radial M3 pilot holes are shown for set screws. These engagement lengths and geometry are not torque-qualified and must be replaced by selected vendor dimensions. The lower coupler-to-bearing gap is 2 mm to provide space for the lower axial retainer stack. The actuator guard's lower aperture is nominally 11.8 mm so the 11 mm retainer ring clears; verify the as-built opening stays below 12.5 mm. The guard is modeled as two longitudinal service halves, clamped by six illustrative M3 screws into insert pockets. The split seam, tabs, insert strength, clamp torque, actual cover tolerances, cable exit, and removal path need fit and strength review with the chosen actuator; keep every as-built opening below 12.5 mm.
6. **Wet contact inserts:** retain replaceable pads mechanically, not with adhesive alone. The study now shows top/bottom keeper strips fastened into the fixed and moving jaw, with short end fences that capture the insert while leaving most of its contact face exposed. The fastener stations scale with pad length from the 24 mm reference pattern, and the model warns if the inner pair crowds 5 mm screw heads. Screw size, pilot depth, keeper thickness, material, and tolerances remain prototype placeholders; verify hardware engagement and edge distance for every resized pad. Evaluate the round channel, V-channel, or flat pad against real props; add a seedling-specific cradle only if inspection of the actual sample shows it is needed.

This part breakdown is a preliminary load-path recommendation. Final plate thickness, shaft diameter, bushing length, fastener size, and actuator torque must come from measured task loads and vehicle-frame geometry.

### Preliminary prototype parts and counts

Counts below describe the current CAD study, not a released purchase list. Vehicle and motor interfaces still determine the final hardware sizes.

| Part / subassembly | Study count | Build status / open detail |
|---|---:|---|
| Vehicle adapter plate | 1 | Generic 84 x 82 x 6 mm plate with four placeholder vehicle holes; replace the pattern from the ROV STEP model. |
| Support yoke with integral fixed reaction rail | 1 | CAD is one combined body; four M3 cheek-to-plate screws/inserts and four bearing-ear insert pockets are shown. Confirm print/machining material and insert installation. |
| Extended bearing ears, screws, inserts, and sleeves | 2 ears, 2 sleeves, 4 M3 screws/inserts | Each ear has two M3 screws into 8 mm insert placeholders. Verify insert pull-out, screw shear, edge distance, ear bending, and bushing fit against the selected material and loads. |
| Moving jaw and pivot shaft | 1 each | 8 mm shaft and D-flats are placeholders. Split-ring grooves, two 0.5 mm thrust washers, and two 0.8 mm split-ring proxies are now modeled with 0.2 mm nominal endplay; replace with a matched hardware pair and verify groove strength/axial load. |
| Actuator reaction mount | 2 clamp halves, 2 rails/feet, 2 insert proxies, 2 ring bolts, 2 foot screws | Generic Ø20 mm housing clamp; replace with selected actuator's real interface and verify torque, fit, fastener access, and material strength. |
| Contact pads, keeper strips, end fences | 2 pads, 4 strips, 4 fences | Round-channel insert shown by default; also selectable flat/V inserts. Eight M3 keeper screws are represented. |
| Fixed stop sector and rotating stop arm | 1 each | The current Ø4 mm pin is integral to the arm proxy. It bears in the 2.5 mm sector over only about 2.0 mm and overlaps the arm root by about 0.5 mm; redesign with a positively retained pin and supported arm/sector before powered operation. |
| Stop-sector guard skirt and lid | 1 each | Four M3 lid screws; two internal feet use M2 through-screws and nuts to secure the skirt and sector to the upper bearing ear. Check tab and fastener strength. |
| Geared actuator and coupling | 1 each | Proxies only. The coupling is currently Ø14 x 8 mm with separate 3 mm blind engagements, a 2 mm center web, and an Ø6 mm placeholder motor shaft; set the interfaces and rated torque from selected hardware. |
| Split actuator guard | 2 halves | Six M3 screws and six insert pockets are modeled as placeholders; confirm insert and seam strength in the chosen material. |
| Vehicle-to-plate fasteners | 4 placeholder positions | Not modeled; select after the frame material, thickness, and access are known. |

### Prototype material and fabrication basis

The current CAD is suitable for checking geometry and assembly order, not for inferring structural capacity. Use two distinct build levels:

| Component | First geometry article | Wet-load prototype basis | Selection check |
|---|---|---|---|
| Adapter, bridge, and yoke | FDM-printable parts can check reach, fastener access, and camera view without power. | Use a load-rated plate/rail material and a bridge that transfers jaw push, pull, and off-axis moments into both structural side rails. Do not load the acrylic center plane or electronics housing alone unless their strength and joints are calculated and tested. | Confirm wall/frame material, thickness, backing access, edge distance, and measured contact loads. |
| Pivot and bearings | Printed shaft/bushing geometry may check clearances only. | Use a real corrosion-resistant shaft with a replaceable commercial bushing and a matched axial-retention system; keep the coupling separate from shaft retention. | Match the shaft diameter, bushing clearance, ring/groove, thrust washer, and endplay as one stack. Check shaft bending and groove strength. |
| Hard stops | Printed stop features can check the slot path and service cover with the drive unpowered. | Use a replaceable metal stop pin and a load-rated stop plate/joint; do not power the current integral printed pin proxy. | Size for the actuator's maximum deliverable or current-limited torque, including impact and pin/slot bearing, then proof-check in a guarded fixture. |
| Contact inserts | Print several round, V, and flat coupons to compare against prop replicas. | Use mechanically retained, replaceable compliant elastomer pads; select hardness and surface from wet slip and damage trials. | Measure holding force and safe squeeze separately, especially for seagrass carriers and thin panel edges. |
| Fasteners and wet-side drive | Standard hardware can establish service access in the mockup. | Use fasteners, actuator, cable entry, and materials suited to the team's water depth and exposure; isolate dissimilar metals where needed. | Check corrosion compatibility, locking, cable strain relief, pressure/depth rating, and the actuator removal path. |

Treat the first printed article as an unpowered fit mockup. Before powered wet operation, replace the printed stop and pivot load path with selected hardware and material, and verify the bridge and vehicle attachment against measured loads. Material grades and plate thickness remain open until the team has its actual vehicle structure, prop loads, and actuator data.

Before ordering hardware, replace the axial-retainer proxies with matched hardware, replace the generic actuator clamp with an interface from the selected actuator drawing, add the actual output shaft, and integrate the vehicle interface. The bearing-ear, reaction-mount, and stop-sector joints are represented by placeholder fasteners; check them against selected actuator torque and measured task loads.

### Mounting and vehicle integration

- Put the tool plate at the front centerline of the ROV so both pilots can see the grasp point and push axis.
- From the described open-top body, the first vehicle-mount concept should be a removable front cross-bridge spanning both side walls, with the gripper adapter bolted to that bridge. If the side walls are acrylic, use through-bolts and broad backing/spreader strips where the geometry allows; the bridge should transfer jaw push/pull and off-axis moments into both walls instead of concentrating them in the centerline plane or electronics housing. This bridge is not yet modeled: confirm wall material/thickness, joint method, edge distances, backing access, and thruster clearance in the body STEP, then check local bearing/bending and the full load path.
- Keep the gripper envelope clear of the forward camera view, tether, and thruster guards. Ensure the tool cannot hit the 45-degree thrusters through the full jaw stroke.
- Leave room behind the gripper for the actuator and cable/hose strain relief. Make the actuator removable without opening the electronics bay.
- Route the actuator lead along and secure it to the ROV frame, with the real cable entry/strain relief transferring pulls into the frame. Keep the service loop away from the jaw sweep, thrusters, trap mesh, and plant samples; loose cable loops can snag on props. MATE's [November 2026 Expected Work Practices bulletin](https://20693798.fs1.hubspotusercontent-na1.net/hubfs/20693798/2027%20MATE%20ROV%20Competition/2027%20MATE%20Documentation/Safety/MATE%20ROV%20Competition%20Tech%20Bulletin%20-%20MATE%20Expected%20Work%20Practices%20Updated%202027.pdf) calls for securing ROV wiring to the frame and proper strain relief at enclosure penetrations.
- The current hull description gives a 25 x 15 x 15 box but no confirmed units, front-face definition, frame thickness, thruster dimensions, or mount coordinates. It calls for eight thrusters, but the placement details do not account for all eight consistently: they mention two horizontal units on each side plus vertical units, then later four 45-degree units and two rear horizontal units. Do not infer the missing positions; include all eight thruster axes and full guard envelopes in the body STEP model. The OpenSCAD file retains an optional `show_reference_bay` ghost overlay, assuming centimetres, with the 25 cm direction along vehicle length. It is now off by default and shows only two side plates and a horizontal center plane when enabled; roof and bottom foam are omitted. It is a visual envelope, not fit or structural CAD. Enable the overlay only for rough context, then replace it with the uploaded body model when available.
- Under that overlay assumption, if the mount plane is at the 25 cm body's front face, the study gripper adds about 97.5 mm of forward reach, giving a rough body-plus-tool length of 348 mm before thrusters, camera, tether, or vehicle adapters. The study's 95 x 112 mm cross-section fits within the assumed 150 x 150 mm body section, but this does not establish clearance from the actual 45-degree thrusters or their guards.
- Keep the complete ROV with the installed tool inside the Explorer limit of 100 cm in every dimension and 22 kg in air. MATE measures size as length + width + height and awards more points to smaller/lighter vehicles; the 2027 Explorer score table gives the top size band at a combined 120 cm or less. On the unverified 25 x 15 x 15 cm body assumption, the current tool reach gives a rough combined dimension sum of about 65 cm before thrusters, guards, camera, mounts, and any other protrusions. This is only a planning estimate: calculate the score envelope from the final assembled CAD and weigh the actual vehicle.

## 3. Task interface register

The **task and page** column below records actions stated in the [official 2027 Product Demo briefing](https://20693798.fs1.hubspotusercontent-na1.net/hubfs/20693798/2027%20MATE%20ROV%20Competition/2027%20MATE%20Documentation/2027_MATE_ROV_Competition_Briefing_FINAL.pdf). The mechanical-action and tool-contact columns are our engineering interpretation and concept proposals; MATE has not prescribed a gripper shape for them. A clamp can carry many objects, but it cannot safely be assumed to actuate every switch or connector. Check each proposal against MATE's prop CAD, build instructions, and physical practice props.

| Task and page: stated action | Mechanical interpretation | Proposed tool contact | Evidence needed before final geometry |
|---|---|---|---|
| T1 / p.5: collect seagrass; deploy seedlings | Pick, carry, and release a living sample/seedling carrier | Wide compliant cradle that supports the carrier/base; avoid foliage and roots | Practice sample dimensions, permitted grasp zone, wet fragility, planting release motion |
| T1 / p.5: deploy new crab trap; return old trap | Capture, retain during translation, and release/recover | Rounded hook plus opposed padded V-groove around a bar/handle | Bar diameter, handle/mesh access, trap buoyancy, catch/release direction |
| T1 / p.5: install primary node | Carry, orient, and seat a bulky object | Two-pad grip for transport; broad fixed-anvil face for final seating | Node grasp features, seat geometry, allowable seating load |
| T1 / p.5: remove generator-port cover; install power connector | Pull cover; orient and push a plug axially | Hook/shoulder for cover pull; connector-body nest and guided axial push | Cover retention/release, plug body and keying, insertion force/travel, cable bend radius |
| T1 / p.5: install pressure/tilt sensor; connect it to node; level it | Carry, seat, attach cable, make a small angular correction | Soft body cradle, broad push face; cable needs strain relief/avoid being pinched | Sensor dimensions, mounting interface, cable connector and slack, leveling tolerance |
| T2 / pp.5–6: disengage breaker; unplug/reconnect solar-array power; remove/install panel | Operate a control, manipulate electrical connector, retain and replace panel | Blunt rounded pusher or pull hook for breaker; connector-body nest; padded panel-edge grip | Breaker travel/force, plug shape/latch, panel grip zone and mass, connector access sequence |
| T2 / p.6: recover dropped tool before/after it reaches bottom | Intercept or pick up, retain, and return | Open hook mouth plus compliant clamp sized for the tool handle | Tool geometry, possible orientations, timing/access path, wet weight |
| T2 / p.6: install SGANT; connect power and communications | Carry, orient, seat antenna, and handle cable plugs | Padded bar/shaft grip; broad alignment face; connector-body nest | SGANT mounting orientation, allowable force, plug/key geometry, cable slack |
| T2 / p.6: maneuver cargo payload into docking bay | Push/guide payload into a target | Broad blunt bumper/pusher; clamp only if payload has a safe capture feature | Payload geometry, docking clearance, whether contact/grasp is permitted, insertion force |

Treat the clamp and blunt pusher as the first common tool, with passively interchangeable, captive inserts for round-bar and flat-edge contact. The listed connector work may need a separate connector nest or compliant guide once connector geometry is known. Do not design a generic probe to enter an electrical port: the plug itself should be held by its body, keyed from the actual connector, and advanced along its intended axis. A breaker tip, connector carrier, or seedling cradle should be a replaceable module if the prop interfaces show the common jaw cannot do that action reliably.

### First prototype operation sequence

1. Open the jaw and approach with the camera view unobstructed.
2. Use the fixed nose/pusher to make broad alignment contact where the task calls for seating or docking.
3. Close on the designated handle, frame, tool body, or carrier, using the matching soft insert. Never use the cable, foliage, or unsupported panel face as the grasp point.
4. Retain the object through the required ROV translation/turn. Keep cable slack outside the jaw and pivot sweep.
5. For connector insertion, the ROV supplies the main axial motion while the gripper holds and aligns the plug body; stop if the plug is not keyed/aligned rather than forcing it.
6. Open and back away along the release direction. Verify that the item stayed at its intended location.

| Task action | Primary gripper feature | Main handling issue |
|---|---|---|
| Seagrass collection and planting | Wide, soft pads; low-force closure; possible seedling-carrier cradle | Avoid gripping foliage directly; the sample/root holder and planting interface must be inspected before shaping the cradle |
| Crab-trap deployment and recovery | Blunt jaw-tip hooks plus V-groove pads | Secure a bar/handle and keep the trap from sliding during ROV translation |
| Node, sensor, SGANT placement | Fixed anvil and broad push face; jaw retains the item | Hold the object square while the ROV aligns it to a seat |
| Connector and communications link | Guided nose, V pads, controlled push | The official briefing says install/connect; connector type and whether it latches or twists remain unknown |
| Breaker and port cover | Jaw tip or broad face used as a pusher/puller | Need prop geometry and actuation travel; avoid a thin blade-like edge |
| Solar panel replacement | Long, padded jaw contact on panel edge/frame | Panel size, grasp points, and retention method remain unknown |
| Dropped tool recovery | Hook plus compliant clamp | Must acquire the tool both before and after it reaches the bottom |
| Cargo payload docking | Vehicle nose/bumper and alignment surfaces; gripper as needed | Task is described as maneuvering payload into a bay; exact docking geometry is not released here |

## 4. Actuation choice

Use an electric actuator for the first prototype, but keep sealed linear drive and geared rotary drive under consideration until required force, travel, fit, and the team's build capability are known. At the 2027 World Championship, the pool depth limit is 5.2 m and ROV electronics housings must operate to 6 m; the actuator and any wet-side penetrations must suit the actual depth exposure. A sealed commercial gripper is a useful benchmark for packaging and performance (below), but its geometry and price do not establish the team's selection. The revised OpenSCAD study uses an illustrative 20 mm diameter by 45 mm long coaxial rotary-drive body, a provisional reaction clamp and rails, and a 38 mm OD guard, with the pivot moved 20 mm forward of the support-cheek edge. The reaction mount and guard remain generic proxies, not a selected actuator or verified wet-side package. Recheck actual drive dimensions, torque reaction mounting, coupling engagement, shaft retention, sealing, cable routing, and service access before fabrication.

| Drive concept | Advantages for this tool | Main design burden | Current decision |
|---|---|---|---|
| Geared electric rotary drive | Compact at the hinge; can hold a jaw if gearbox is self-locking; simple command | 6 m wet-side housing/seal, current/stall protection, pivot torque, stator reaction mount, shaft retention | Compare with a sealed linear drive; no selection yet |
| Sealed geared electric linear actuator | Directly measurable stroke; a commercial ROV-gripper architecture provides a real packaging/performance benchmark | Wet-side rod seal or integrated pressure housing, linkage geometry, hard stops, pinch guard | Benchmark, then compare available parts and team fabrication capability |
| Pneumatic/hydraulic cylinder | High force in a compact cylinder; drive can stay off the wet jaw | Lines, valves, regulated supply, documented fluid system, pressure limits and inspection | Do not select without a force need that justifies the system |

### Commercial reference for scale and performance

Blue Robotics' [Newton Subsea Gripper](https://bluerobotics.com/store/thrusters/grippers/newton-gripper-asm-r2-rp/) is a useful public benchmark, not a purchase recommendation. The manufacturer reports a 62 mm jaw opening, 97 N grip at the tip / 124 N in the middle, 13.5 mm piston travel, 1.6 s open/close time, a 36 mm primary body diameter, and 303 mm overall length when closed. It uses a sealed, geared brushed-motor/lead-screw actuator; its stated pressure rating is 300 m, with a 9–18 V supply and 6 A peak current. The product page also provides assembly CAD. Compare the performance and dimensions with the prop measurements and the team's fabrication options; do not copy its 300 m housing or its jaw profile without need.

### Build-versus-buy screen

| Route | What is already supported by evidence | Main mismatch or work left | Decision gate |
|---|---|---|---|
| Adapt the Newton or a similar rated commercial gripper | Newton manufacturer page lists 62 mm jaw opening, 97 N tip / 124 N middle grip, 1.6 s stroke, 300 m pressure rating, 9–18 V, 6 A peak, PWM control, 303.2 mm closed / 309.2 mm open overall length, 524 g air / 267 g in water, and a public assembly CAD ZIP. The listed single-unit price is USD 780 when checked 14 November 2026. | It is a single-function clamp with a roughly 0.31 m overall length. The study's 97.5 mm figure is forward reach from its own mount plane, so those package values use different datums and cannot be compared directly. The team still has to design the structural vehicle mount and determine whether the commercial jaw can serve the actual task interfaces. Check 9–18 V compatibility and 6 A headroom against the ROV power system. | Import the manufacturer CAD and compare its true mount datum, swept jaw, overall length, camera view, thruster clearance, and task props in the assembled ROV. Consider purchase only if it reaches the measured grasp features and the full task sequence without a required underwater tool swap. |
| Build the custom pivot-jaw concept | Existing study packages a fixed push face, moving hook, and replaceable round/V/flat contact inserts in about a 95 x 103.5 x 112 mm envelope with 97.5 mm forward reach. | This is a geometry study, not a rated underwater actuator or qualified load path. The actuator, seal, coupling, mount, materials, strength, electrical load, and actual grasp range still need selection and testing. | Continue the custom route if the commercial CAD does not fit the body/task approach corridor or cannot access required contact features. Size the drive and structural parts from measured wet loads, then pressure/depth test the wet-side package to the team's operating requirement. |

This is a CAD and requirements gate, not a purchase decision. The commercial tool's published force and opening are benchmarks; neither proves that it can complete the 2027 task props safely.

This comparison exposes two useful sizing gates in the current study: the 24 mm nominal jaw opening may be too small if mission handles or frames approach the commercial tool's 62 mm opening, and the study's 45 mm actuator proxy is not a realistic whole-tool package. Neither observation sets the required jaw opening or actuator length; the 2027 props and vehicle STEP model must decide those values.

**Do not widen `jaw_gap` alone.** In the present single-pivot geometry, setting the nominal opening to 62 mm (approximately `jaw_gap = 80 mm` with the current 9 mm pad width) and keeping the current 35.5 mm far-pad arm gives a theoretical minimum gap of about 37.5 mm if the jaw can sweep to its kinematic optimum; the modeled 45.456-degree hard stop leaves about 40.7 mm. Holding that hard-stop angle, a 62-to-20 mm range requires about a 64.6 mm far-pad arm, while closing to about 3 mm requires about 88.4 mm. At equal pad force, those arms demand about 82% and 149% more ideal pivot torque, respectively, than the current 35.5 mm arm. The existing compact geometry instead opens to 24 mm and closes to about 3.2 mm over its modeled 0–45.5-degree stop range, providing about 21.3 mm of nominal closure. These are idealized kinematic screens from the SCAD equations, not prop-fit results. Any longer jaw or changed sweep also changes package reach, collision envelope, and stop load. Record both the largest opening feature and smallest feature that must be retained before changing the jaw. If the measured size span is wide, compare a longer pivot jaw against a parallel-jaw/sliding mechanism and weigh reach/torque against packaging and contamination tolerance. If task contacts are small, the current compact pivot architecture is mechanically simpler.

### Actuator sizing example (benchmark only)

The Newton manufacturer's published 97 N tip-grip figure is only a force-scale reference, not a 2027 mission load. If 97 N is treated as a single-pad normal force in the custom-jaw equation, the study's 23.5 mm center contact arm gives 2.28 N·m ideal pivot torque. With an illustrative 70% transmission efficiency and 2.0 design factor, that screens to about 6.5 N·m output torque at the required loaded speed. The manufacturer's rating is not confirmed to be equivalent to per-pad normal force, so this conversion is not a direct Newton-to-custom comparison. A 44° jaw sweep in 1.6 s averages 4.6 rpm; in 2.0 s it averages 3.7 rpm. For the 62-to-20 mm kinematic case, the corrected 64.6 mm far-pad arm gives about 6.26 N·m ideal torque for that same assumed 97 N, or about 17.9 N·m with those illustrative margins. At the study's 12 mm stop radius, 6.5 and 17.9 N·m correspond to approximately 542 N and 1,490 N of tangential stop reaction. The modeled Ø4 mm pin engages the sector slot over only about 2.0 mm of the 2.5 mm plate thickness, giving simple projected slot-bearing stresses of about 68 MPa and 186 MPa, before impact, stress concentration, print anisotropy, or clearance effects; the pin overlaps the rotating arm root by only about 0.5 mm. Treat the current integral printed stop-pin geometry as a packaging placeholder: the first powered prototype should use a replaceable, positively retained metal pin and a supported stop plate/joint whose material and thickness are checked against the actuator's maximum deliverable torque or current-limited torque. Increasing the stop radius reduces reaction force but enlarges the guarded package. These numbers are illustrative screens, not a motor recommendation: replace the benchmark force, efficiency, design factor, and close-time with measured prop loads and the team's policy before selecting an actuator. Stall torque alone is not enough; verify rated torque at speed, holding behavior without power, peak current, duty cycle, and hard-stop load.

The study's 45 mm actuator proxy is not a realistic whole-tool package. If considering a custom rotary actuator, its mount must react stator torque into the yoke, and the pivot shaft needs independent axial retention; neither load path is complete in the current CAD.

Any electric actuator on the ROV draws from the MATE-provided supply through the vehicle's required fuse arrangement. For the Newton benchmark specifically, the manufacturer requires 9–18 V, up to 6 A, and a 3.3–5 V PWM control signal. At 12 V, 6 A is a 72 W peak planning point; from the nominal 48 V bus that is at least 1.5 A ideally before converter losses. The 2027 Explorer specification requires any lower-voltage conversion to occur onboard the ROV, with the ROV bus supplied at the provided voltage. Select and protect a suitable onboard converter/controller only after checking the team's available voltage rails and actuator control interface. MATE's 2027 fuse method is based on measured in-water full-load current for the complete vehicle; do not infer the competition fuse from this actuator-only estimate. Show the actuator/converter on the electrical SID and include it in the full-vehicle power test.

If the team chooses pneumatic or hydraulic actuation, design to the 2027 Explorer limits and documentation requirements before buying parts: the specification sets compressed air at no more than 40 psig and water hydraulics at no more than 150 psig; component ratings, diagrams, and pressure controls are required. The ROV's 48 V / 30 A supply and fuse are shared system constraints, so the gripper's measured current must be included in the vehicle power budget.

For loss of power, retention matters because the task includes carrying a recovered tool and moving mission objects. Prefer an actuator/gear train that holds the jaw without continuous power, with a guarded manual/service release for recovery at the surface. Include a current limit or mechanical closing stop so a held object cannot be crushed by a stalled drive. Confirm the jaw-mouth guarding with the team's safety lead before powered water trials, and make the actuator de-energize before hands-on service. Final actuator selection still depends on measured wet holding loads, connector insertion forces, jaw travel, and the 48 V / 30 A shared power budget.

## 5. Confirmed design constraints to carry into CAD

- Explorer ROV maximum: 100 cm in any one dimension and 22 kg maximum in air; smaller and lighter vehicles score better.
- The gripper counts in the ROV's size and weight measurements. Size is the sum of overall length + width + height; the tether is excluded. Explorer earns the top size band at 120 cm or less and the top weight band at 8 kg or less, so keep the tool's forward overhang and mass visible in the whole-vehicle budget.
- The [2027 Part 2 specifications](https://20693798.fs1.hubspotusercontent-na1.net/hubfs/20693798/2027%20MATE%20ROV%20Competition/Manual%20Components/EXPLORER%20Part%202%20SPECIFICATIONS.pdf) set the World Championship pool maximum depth at 5.2 m and require ROV electronics housings to operate to 6 m; regional pools may differ. I interpret the described roofless 25 x 15 x 15 bay as a structural/access frame, with a separate sealed electronics housing inside it. If that open bay is intended to contain unsealed electronics directly, it conflicts with the housing-depth requirement. Include the sealed housing envelope and its removal path in the vehicle model.
- No sharp edges or hazardous points on the ROV or related systems. Fully shroud the gear assembly to IP-20: solid cover or mesh openings below 12.5 mm. The manual and safety-inspection examples flag pinch points; the powered jaw mouth remains a safety-review item because the released specification does not state a separate numeric limit for its working opening.
- Vehicle motors require shrouds/guards. Keep the jaw swing, hook lip, and actuator linkage outside the thruster guard envelope so tool contact cannot snag the guards or cables.
- Any fluid-powered equipment needs the prescribed pressure controls, component ratings, inspection, and diagrams.
- Electrical and fluid-powered equipment must be included in the appropriate SID. The ROV electrical supply is a single MATE power connection and fuse system; include manipulator loads when measuring full-load current.
- Equipment used during the demonstration must pass safety inspection.

These are vehicle-level constraints. The mission task manual and prop geometry may add more requirements when released.

### Gripper safety hold point

The drive/coupler and stop-slot mechanism are covered by a solid or sub-12.5 mm guard in the concept. The grasp opening itself has to stay available for mission props, so the current one-jaw clamp cannot be claimed to meet the safety requirement from its CAD envelope alone. Before powered water trials, present the jaw-mouth concept to the safety lead and confirm whether additional screening is required for the functional pinch zone. Preserve rounded, compliant contact edges, limit closing force/current, make the actuator de-energize before hands-on service, and keep the hook blunt. Record the final inspection decision in the build's safety review.

## 6. CAD and prototype inputs needed to dimension it

For a direct rotary drive, enter desired_close_time_s to get the ideal average output speed for the current commanded jaw sweep. The model does not account for speed loss under load; compare the required value with the actuator's rated loaded speed at the selected torque, not its no-load speed.

### Exporting a study mesh

Open `gripper_study.scad` in OpenSCAD, choose a `part_view` value in the Customizer, set `jaw_angle_deg` if exporting the moving assembly, press **F6** to render, then use **File → Export → Export as STL**. The study uses millimetres. Selected parts remain at their assembly coordinates, so center/orient them in the slicer or downstream CAD. STL drops colors and parametric features; these exports are for fit checks and concept prototypes, not released fabrication geometry.

For a measured torque screen, enter wet `normal_force_per_pad_N`, select `contact_position_fraction` (0 at the pad end nearest the pivot, 1 at the nose), and enter defensible `transmission_efficiency` and `design_factor` values. The model echoes ideal pivot torque and a factored output-torque estimate; the default force is zero so no unmeasured load is implied. This calculation does not check strength, stall impacts, current, or the complete jaw arc and is not an actuator selection.

The study also echoes its estimated fully open pad gap, hard-close gap, and available closure travel. Enter measured `target_min_grasp_width_mm` and `target_max_grasp_width_mm` to flag targets outside those approximate limits; zero disables the corresponding check. This is a kinematic screen only: it does not include pad compression, contact tolerance, or a full swept-solid collision check.

An editable OpenSCAD study assembly is provided in [`gripper_study.scad`](gripper_study.scad), with a fillable [`interface measurement sheet`](gripper_interface_measurements.md) for prop and vehicle inputs. Use its `part_view` customizer to isolate the adapter plate, support yoke, bearing set, jaw, pivot shaft, axial-retention set, reaction mount, stop parts, or actuator package for separate mesh export; selected parts remain in assembly coordinates and may need centering/orientation for fabrication. The `pad_coupon` and `pad_coupon_pair` views export standalone contact samples; the fixed and moving styles can be set independently for fit studies while the full-assembly defaults match. These are study meshes, not fabrication-release files. The study's default millimetre dimensions are illustrative only; change the parameters after confirming the body and prop geometry. It shows a tool plate and generic vehicle-hole pattern; yoke, D-keyed jaw and through-shaft; extended bearing ears and sleeves; paired split-ring/thrust-washer axial-retention proxies; guarded curved-slot hard-stop sector; selectable round-channel/V-channel/flat pad shapes with keeper strips and end fences; and a coaxial rotary-drive envelope with coupling proxy, provisional split reaction clamp/dual rails, and serviceable split shroud. The latest OpenSCAD diagnostic reports a study envelope of approximately 95 x 103.5 x 112 mm (X/Y/Z), including the generic plate, reaction mount, and guard; the jaw reaches 97.5 mm forward of the mount plane. A clean tool-only assembly STL and oblique/open/commanded-close PNGs are now exported from this current source. The mesh contains 49 modeled volumes and OpenSCAD warns it may not be a valid 2-manifold; treat it as a review mesh, not a one-piece print release. Direct mesh bounds are 95 x 103 x 112 mm at the default jaw angle; the half-millimetre Y difference from the diagnostic is because the diagnostic is a conservative study envelope. The model excludes the vehicle, vehicle fasteners, and mounting bridge. The pivot is offset 20 mm forward of the cheek edge; the Ø38 mm guard has nominal 1 mm cheek clearance. The reaction clamp uses a 20.5 mm ID around the assumed Ø20 mm body, twin 2.2 x 4 mm rails, and 8 x 8 x 3 mm feet attached to the lower bearing ear with M3 fastener/insert proxies; dimensions and torque transfer are unverified. The 14 mm coupling sits behind an 11.5 mm shaft opening; it is 8 mm long with separate 3 mm blind engagements, a 2 mm central web, and an Ø6 mm motor-shaft placeholder. The nominal lower retainer-to-coupler clearance is 0.5 mm; upper retainer-to-stop-plate clearance is 1.0 mm. The actuator, reaction clamp, and shroud remain packaging proxies. The separate stop-sector guard has a nominal 11.5 mm shaft opening, a removable lid with illustrative M3 screws, and two internal M2 through-fasteners. The actuator cover is split into two halves with six illustrative cross-screws and insert pockets. The `show_reference_bay` overlay is a 25 x 15 x 15 cm assumption, not a pressure housing. The older `gripper_study_preview.png` was rendered with the ghost envelope on and only shows the assumed frame context; it includes no dimensioned vehicle rails, actual thruster bodies/guards, camera, or props. The current tool-only images omit vehicle and mission props, and no image is a fit or collision check. The operating sweep is 0–44 degrees; the latest hard-stop clearance estimates are 3.18 mm pad gap and 4.02 mm hook-to-pad clearance at hard close. Treat these dimensions, clearances, apertures, stops, fasteners, inserts, and joints as placeholders pending selected hardware, body CAD, prop dimensions, and fabrication review; verify every as-built opening remains below 12.5 mm. The jaw mouth still needs safety review. Set `insert_style` to `"round_channel"`, `"v_channel"`, or `"flat"` for matching defaults; optionally set `fixed_pad_style` and `moving_pad_style` independently for fit trials. The model is not pressure-rated or fabrication-ready.

Key OpenSCAD study dimensions are collected here for a first mechanical-team review. They are defaults for discussion, not fabrication dimensions.

| Feature | Current study value | Status |
|---|---:|---|
| Vehicle adapter plate | 84 x 82 x 6 mm; 42 x 58 mm hole pitch; Ø5.5 mm holes | Vehicle-side pattern unverified |
| Jaw and contact pads | 24 mm open gap; 0–44° commanded sweep; pads 9 x 24 x 14 mm | Prop sizes and grasp zones unverified |
| Pivot and bearings | Ø8 mm keyed shaft; 4 mm bearing ears; 2 M3 screws per ear (4 total) | Strength, bushing fit, and matched axial-retainer hardware unresolved |
| Hard stops and stop cover | -1.46° to 45.46°; Ø4 mm stop pin; 44 mm skirt / 48 mm lid | Check against actual actuator torque |
| Clearance at hard-close stop | 3.18 mm pad gap; 4.02 mm hook-to-fixed-pad | Analytic estimates; verify solid clearances and print tolerances |
| Actuator packaging proxy | Ø20 x 45 mm body; Ø20.5/28.5 mm ID/OD clamp ring; twin rails and feet; Ø38/34 mm OD/ID guard; Ø14 x 8 mm two-bore coupler | No actuator selected; clamp torque unknown; 3 mm coupling engagement per side is schematic and not torque-rated |
| Full study envelope | 95 x 103.5 x 112 mm; 97.5 mm forward reach | Includes generic reaction mount and guard; excludes vehicle, vehicle fasteners, and mounting bridge |

When ready, upload:

1. Attach a STEP (`.step` / `.stp`) of the body and frame directly in this chat. Parasolid (`.x_t`) also works. For SolidWorks, make a Pack and Go ZIP containing the `.SLDASM` and every referenced part, then attach that ZIP. Include structural rails/plates, thruster bodies and guards, the proposed tool-mount area, and simplified bounding solids for the electronics bay and camera; omit internal details that do not affect mounting, access, or collisions. Keep major parts separate and named if possible.
2. Attach the official mission-prop CAD ZIP for the Explorer tasks when its download is active; otherwise attach the prop drawings/photos and measurements for handles, ports, panels, covers, traps, connector plugs, and payload.
3. Add a short note with units, vehicle front/approach axis, assembly origin or mount datum, camera location, thruster axes/guard envelopes, frame material/thickness, and proposed tool mounting face. Top/front/side screenshots with dimensions are useful alongside the CAD, especially if axes or units are ambiguous.
4. Actuator options the team has access to: for rotary units, output torque (continuous/peak), speed, duty cycle, holding/brake behavior, current, depth rating, shaft interface, and cable exit; for linear units, force, stroke, speed, duty cycle, current, depth rating, and cable exit. Include any wet-side cable/hose arrangement.

STL/3MF is useful for viewing a shape but is not enough for a precise mounting design because it loses parametric features and may obscure the intended dimensions. If STEP export is unavailable, send a mesh plus dimensioned orthographic drawings and mount-hole measurements.

## 7. Recommended next engineering step

Import the vehicle and prop models together, then establish (a) the tool mount datum, (b) collision-free approach corridor, (c) required jaw opening from the largest object, (d) jaw closing force from the most delicate object, and (e) insertion/pushing travel from connector and panel interfaces. Prototype the jaw contact geometry before optimizing the actuator. Update this brief when the detailed task manual or prop files become available.

## 8. Force and actuator sizing method

Do not select an actuator from the ROV's maximum thrust or an arbitrary advertised clamp-force number. Measure or estimate the loads at the actual contact point, then size the jaw linkage around them.

For an object held between the moving jaw and fixed anvil, approximate the total frictional holding capacity as:

`F_hold ≈ 2 μ N`

where `N` is the normal force at each contact face and `μ` is the wet friction coefficient of the actual pad/object pair. For the intended worst-case carry direction, estimate the tangential load from submerged object weight, water drag, and vehicle acceleration. Set:

`N_required ≥ SF × F_tangential / (2 μ)`

`SF` is the team's chosen design factor. Measure wet friction or use a conservative estimate; dry rubber-on-plastic values are not reliable underwater. A very delicate task sample may set a maximum permissible jaw force, so check both the minimum holding force and maximum safe compression.

For a pivoting jaw, estimate required pivot torque using the jaw contact arm `r_jaw` and linkage efficiency `η`:

`T_pivot ≥ N_required × r_jaw / η`

For the current study geometry only, the pad-normal moment arm is 23.5 mm at the pad center, 11.5 mm at the end nearest the pivot, and 35.5 mm at the nose end. That is a first-pass torque ratio of 0.0235 N·m per newton of pad-normal force at the center before transmission losses. These values match the current SCAD diagnostics. The actual contact location, jaw/pad deformation, and torque through the closing arc must still be checked against prop geometry and the actuator linkage; an off-center grasp changes torque.

This sensitivity table converts a measured **normal force at each pad** into the ideal pivot torque at representative contact locations. It is not a force recommendation or an actuator selection; it omits linkage/coupler losses, acceleration, tolerance, and stop impact.

| Normal force per pad | Near pivot, 11.5 mm arm | Pad center, 23.5 mm arm | Nose end, 35.5 mm arm |
|---:|---:|---:|---:|
| 5 N | 0.058 N·m | 0.118 N·m | 0.178 N·m |
| 10 N | 0.115 N·m | 0.235 N·m | 0.355 N·m |
| 20 N | 0.230 N·m | 0.470 N·m | 0.710 N·m |
| 40 N | 0.460 N·m | 0.940 N·m | 1.420 N·m |

Use the contact arm for the actual grasp point, then add measured transmission losses and the team's design factor. A design based on the nose-end column needs about 51% more ideal torque than one based on the pad-center column at the same pad force. Confirm worst-case required torque over the full stroke; the maximum actuator output torque must also be checked against the hard stops and structure.

For a direct actuator link at effective moment arm `r_act`:

`F_actuator ≥ T_pivot / r_act`

For the coaxial rotary-drive baseline:

`T_actuator,out ≥ T_pivot / η_coupler`

Use the measured contact angle and perpendicular pivot-to-contact arm for each target, then check the required torque across the full jaw stroke. Select against rated output torque at the needed closing speed and duty cycle; peak stall torque alone is not a usable design rating. Add mechanical stops and a current or torque limit so the actuator cannot overload the prop or crush a fragile sample. Measure connector insertion and panel-seating forces separately; the ROV should provide the main axial push wherever possible, with the gripper aligning and retaining the object.

### Prototype checks before selecting a final actuator

1. Measure the largest grasp width and smallest capture feature from the real prop or a faithful replica.
2. Measure submerged mass / buoyancy and wet pad slip load for the trap, tool, panel, and representative seedlings or samples.
3. Measure connector insertion, cover-release, and breaker forces with a spring scale or force gauge.
4. Check jaw opening, hook release, and actuator force through the full pivot arc.
5. Verify that camera visibility and the no-contact clearance to thruster guards remain acceptable across the full tool stroke.
6. Repeat grip and release cycles underwater with the real objects before deciding on pad material, actuator, and bracket thickness.

Record results in a small load table before ordering the actuator: object, grasp point, wet normal force, retention load, allowable squeeze, and required travel. This converts the present concept into dimensioned design inputs without assuming prop dimensions that MATE has not published in the currently available Product Demonstration material.

The bench fixture's test-shaft groove proxies now match the main CAD's Rotor Clip DSH-8 reference of Ø7.6 mm root diameter and 0.9 mm width. This aligns the two geometry studies only; the ring outline, shaft material/tolerance, axial capacity, and load suitability remain unselected. Do not machine from the proxy without the chosen ring supplier's drawing and a shaft-strength check.

## 9. Prototype acceptance requirements

Use these as pass/fail checks for the first wet prototype. Replace the stated target with measured prop geometry and team-selected margins once the props are available.

| ID | Requirement | First prototype passes when |
|---|---|---|
| GR-01 | Capture and retain handled objects | The jaw captures each actual handle/shaft/edge needed for the assigned tasks and holds it through the planned ROV translation and turn without slipping. |
| GR-02 | Release on command | The pilot can release each held object without a second tool or a manual dive-side intervention. |
| GR-03 | Avoid damaging delicate mission material | The lowest grip setting that retains the object does not visibly crush, cut, or snag the seagrass sample/seedling. |
| GR-04 | Push and seat components | With the object aligned by the pilot, the anvil can transmit the required insertion/seating force without the bracket flexing enough to lose alignment. |
| GR-05 | Operate cover, breaker, and connector interfaces | The actual interface can be engaged and released through the available ROV approach motion; no thin or sharp probe is needed unless the task instructions explicitly require one. |
| GR-06 | Recover the tool in both stated conditions | The jaw or hook can secure the practice tool before it reaches the bottom and after it is resting on the bottom. |
| GR-07 | Preserve vehicle access and maneuvering | The fully open/closed gripper clears thrusters, guards, tether, float, bay access, and frame; it stays in the forward camera view during the grasp. |
| GR-08 | Meet competition inspection constraints | Gear/coupler/stop mechanisms are fully covered to IP-20; the working jaw-mouth approach is reviewed and accepted by the safety lead/inspection process; no hazardous sharp edge is present; attachment remains secure during launch/recovery and operation. |
| GR-09 | Remain serviceable | The actuator, pivot pin, pad inserts, and wet-side cable/hose can each be inspected or replaced without removing the electronics bay. |

The mission descriptions establish the action list, not all physical contacts. Mark GR-01 through GR-06 **not yet verifiable** until the relevant props or representative replicas are available. GR-07 and GR-09 require the team's vehicle model and mounting choice. GR-08 can be checked against the published inspection specifications during the design review.

## 10. Prototype sequence and design gates

Build in stages so the team can reject a poor contact shape before spending time on the final actuator bracket. These gates use the acceptance IDs above; they do not replace the official safety inspection or the detailed mission manual when released.

| Stage | Prototype / test | Gate to proceed |
|---|---|---|
| A. Prop interface mockups | Measure available props or make dimensionally faithful replicas. Print a 1:1 jaw/anvil outline and round-channel, V-channel, and flat pad coupons. Hand-check approach, grasp, release, and contact zones for each assigned object. | Required grip features fit within the real opening and pad length; delicate samples have an approved carrier/contact location; the vehicle can approach and back away along the needed directions. Record the geometry and photos in the measurement sheet. |
| B. Passive load-path rig | Make a manually operated jaw/yoke with the intended pivot and structural material. Use a force gauge to measure wet slip force, insertion/seating force, and safe squeeze on representative interfaces. Measure contact location and jaw angle for each trial. The separate [`gripper_torque_test_fixture.scad`](gripper_torque_test_fixture.scad) models a 100 mm lever and an extended 8 mm test shaft with bearing-retainer and lever-retainer proxies. Install the test shaft through the actual passive jaw/yoke stack; replace the rotating stop arm, actuator, and drive guard during this bench-only setup, and secure the yoke to a reaction fixture. Pull with a force gauge perpendicular to the lever and calculate `T = F x r`; at 100 mm, 10 N of tangential force is 1 N·m. | The yoke, pivot, stops, pad retention, and mounting fixture withstand measured loads without cracking, permanent deformation, loose fasteners, pad escape, or damage to the prop. Loads and safety factor are recorded before selecting the actuator. Fit matched retention hardware and verify endplay before loading; secure and guard the fixture, limit manual jaw travel, and do not use the test lever on the vehicle or exceed the team's controlled load limit. |
| C. Powered guarded bench unit | Fit the chosen actuator, real coupling, both pivot retainers, mechanical stops, reaction mount, current/torque limit, service disconnect, and guards. Test without hands in the jaw path. | Full stroke is repeatable; no coupler slip or retainer migration; hard stops survive the actuator's maximum deliverable torque; drive openings meet the published inspection limit; measured current fits the vehicle power budget; safety lead reviews the jaw mouth before pool use. |
| D. Vehicle fit and clearance | Import the actual body/frame, thruster guards, camera, tether path, and service-bay envelope. Install the gripper at the structural mount datum and sweep open/closed poses. | No collision or snagging through the complete vehicle motion envelope; the camera sees the grasp zone; the sealed electronics housing remains removable; mount fasteners are accessible; total ROV size and mass remain within Explorer limits. |
| E. Wet mission trials | Test every assigned grasp, placement, connector/panel interaction, tool recovery, and cargo docking with the actual or faithful practice props. Repeat in the intended sequence and record failures, slips, damage, current, and completion time. | GR-01 through GR-09 have recorded pass evidence, including the delicate-material limit and accepted safety inspection. Update the pads, stops, and actuator controls from measured results, then freeze the prototype geometry. |

Do not use the powered bench unit on a person or use fingers as a fit gauge. De-energize and secure the jaw before adjustment; use purpose-made test blocks and fixtures when checking pinch geometry or hard-stop loading.

## 11. Preliminary failure review

This is a design-review checklist, not a scored FMEA. Revisit it after prop loads, actuator, vehicle interface, and materials are selected.

| Failure mode | Likely mission effect | Design control | Prototype check |
|---|---|---|---|
| Object slips from wet pads | Dropped trap, tool, panel, or payload | Select pad profile and material from wet tests; use a positive blunt hook only where the prop offers a safe bar/handle | Measure slip force underwater in worst carry direction; run the planned ROV translation/turn with a representative load |
| Delicate seedling or carrier is crushed/snared | Damaged sample or failed planting | Grip the holder/carrier, not foliage; use a compliant, mechanically retained insert and limit closure force | Measure the minimum retention force and maximum safe squeeze separately; inspect the sample after repeated wet cycles |
| Pivot shaft walks axially | Jaw binds, stop pin misaligns, or drive disengages | Provide bearing-side positive retainers and thrust surfaces; do not depend on the coupling alone | Apply axial push/pull to the shaft through repeated stroke cycles; measure endplay and inspect retainers before/after |
| Coupling slips or actuator reaction mount loosens | Jaw position is lost or actuator spins in its mount | Match coupling to both real shaft interfaces; support the actuator housing on a structural yoke feature; use suitable fastener locking | Mark shaft/coupler and mount interfaces; cycle at measured design load and inspect for relative movement/loosened fasteners |
| Hard stop, pin, or sector fails at stall | Jaw over-travels or gear train is damaged | Size the stop path for maximum deliverable actuator torque and limit current/torque; add compliant impact treatment only if it does not mask the hard stop | Load the stops with a guarded fixture; inspect pin shear, slot bearing, fasteners, and permanent deformation |
| Cable, tether, plant foliage, or trap mesh catches in jaw/pivot | Tool jams, mission item is damaged, or vehicle is pulled off pose | Route/strain-relieve cables outside the swept envelope; keep pivot guarded; avoid exposed hooks where no loop/bar is needed | Sweep full jaw motion with representative cable, foliage, and mesh placed at worst-case positions; verify release by backing away |
| Drive or stop guard opens, cracks, or leaves an accessible gear gap | Failed safety inspection or operator injury | Retain the service cover with positive fasteners; keep all openings within the current MATE gear-guard rule; de-energize for service | Inspect the as-built guard at every seam and fastener after load cycling; confirm no finger can reach the gear train |
| Water enters actuator/housing or corrodes the drive | Loss of grip or unsafe electrical fault | Use a depth-rated actuator/enclosure and cable entry; keep electronics in the separate sealed vehicle housing | Pressure/depth test to the team’s operating requirement and inspect for ingress before connecting to the ROV power system |
| Vehicle mount cracks or flexes | Tool misalignment, lost object, or damaged ROV frame | Spread loads across the structural side walls/front bridge with suitable backing; avoid loading the electronics enclosure or a small unsupported acrylic patch | Apply measured push/pull and off-axis loads to the mounted tool; inspect acrylic, holes, joints, fasteners, and permanent deflection |
| Thruster guard, camera, or service access is obstructed | Reduced control, visibility, or maintainability | Check full vehicle/tool envelope with real thruster guards, camera FOV, tether, and housing removal path | Run a CAD sweep and confirm with a physical vehicle mock-up before wet mission trials |

## Sources

- [2027 MATE ROV Competition: Product Demo and Specs Briefing](https://20693798.fs1.hubspotusercontent-na1.net/hubfs/20693798/2027%20MATE%20ROV%20Competition/2027%20MATE%20Documentation/2027_MATE_ROV_Competition_Briefing_FINAL.pdf)
- [2027 Explorer Preview Mission Task (Task 3: MATE Floats!)](https://20693798.fs1.hubspotusercontent-na1.net/hubfs/20693798/2027%20MATE%20ROV%20Competition/2027%20MATE%20Documentation/2027%20MATE%20Floats%20Preview%20Mission_EXPLORER_FINAL.pdf)
- [2027 Explorer Part 2: Vehicle Design & Building Specifications](https://20693798.fs1.hubspotusercontent-na1.net/hubfs/20693798/2027%20MATE%20ROV%20Competition/Manual%20Components/EXPLORER%20Part%202%20SPECIFICATIONS.pdf)
- [MATE Explorer class resources, including current manual/resource link status](https://materovcompetition.org/explorer)
- [MATE's official competition Q&A forum](https://materovcomp.discourse.group/)
- [2027 season page and class manual release status](https://materovcompetition.org/2027)
- [MATE Expected Work Practices bulletin (updated November 2026)](https://20693798.fs1.hubspotusercontent-na1.net/hubfs/20693798/2027%20MATE%20ROV%20Competition/2027%20MATE%20Documentation/Safety/MATE%20ROV%20Competition%20Tech%20Bulletin%20-%20MATE%20Expected%20Work%20Practices%20Updated%202027.pdf)
- [Blue Robotics Newton Subsea Gripper specifications and public CAD](https://bluerobotics.com/store/thrusters/grippers/newton-gripper-asm-r2-rp/) (commercial benchmark only)
- [2026 EXPLORER/PIONEER/RANGER prop-building instructions (historical; not 2027 sizing data)](https://20693798.fs1.hubspotusercontent-na1.net/hubfs/20693798/2026/Supporting%20Documents/EX%20PN%20RN%20Prop%20Building%20Instructions%202026_Final.pdf)
- [2025 EXPLORER/PIONEER/RANGER prop-building instructions (historical; not 2027 sizing data)](https://20693798.fs1.hubspotusercontent-na1.net/hubfs/20693798/EX%20PN%20RN%20Prop%20Building%202025_Final.pdf)
- User-supplied [MATE Floats! preview mission PDF](C:/Users/dealb/Desktop/2027%20MATE%20Floats%20Preview%20Mission_EXPLORER_FINAL.pdf)
