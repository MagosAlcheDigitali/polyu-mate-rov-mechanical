# Drive, Pivot, Stop, and Guard Module Review

**Reviewer:** Ipluvien Maximal  
**Date:** 15 November 2026  
**Scope:** Read-only review of actuator, shaft/coupling, hard stop, and guarding assumptions in `gripper_study.scad` and the linked design notes. This review does not select hardware or approve powered operation.

## Decision

Retain the present drive and stop geometry as a packaging and kinematics study only. The team has no measured task loads, selected actuator, rated output curve, actual vehicle mount, or qualified material/joint stack. The current printed pin/slot should not be powered or used as a load stop.

The project's illustrative 17.9 N·m case is useful as a severity screen: at a 12 mm stop radius it produces about 1.49 kN tangential force. The CAD's nominal stress values are mechanically plausible for their simplified assumptions, but they are not safety factors or ratings. The pin bending value is especially severe; the result confirms the need to redesign the stop path, not what replacement dimensions to use.

## Calculation check

The SCAD uses:

- `F = T/r` for stop tangential force;
- `4F/(πd²)` for pin shear, which corresponds to a single shear plane on a round pin;
- `F/(d·t)` for projected slot bearing using the pin diameter and modeled plate engagement; and
- `32Fℓ/(πd³)` for elastic bending stress of a circular cantilever pin under a point-load resultant.

For the current entered values, `T = 17.9 N·m`, `r = 12 mm`, `d = 4 mm`, `t = 2 mm`, and `ℓ ≈ 3 mm`, these yield approximately 1492 N, 118.7 MPa, 186.5 MPa, and 712 MPa. The equations and arithmetic are consistent with those stated idealizations.

Important limits and corrections for interpreting them:

1. The shear result assumes one shear plane. It should not be described as double shear. A real fork support could have two shear planes, but uneven load sharing, clearance, and pin bending still need analysis.
2. The plate-bearing result treats the 2 mm slot engagement as uniform projected contact. Real slot contact is localized, edge distance and tear-out matter, and plate bending/post/fastener loads are absent.
3. The pin-bending result idealizes a circular cantilever. Actual restraint is through a thin rotating arm and slot edge, with a nonuniform contact patch and stress concentration. The modeled arm, pin, plate, and joints are not material-qualified.
4. Torque must be the worst credible torque at the stop, including the actuator's maximum supply and torque/current-limit tolerance, any gearbox output limit, and a separately justified impact/backlash allowance. The earlier 17.9 N·m figure came from an illustrative Newton-force conversion and 62-to-20 mm kinematic case; it is neither a 2027 load nor an actuator rating.
5. The `max(transmission_efficiency, 0.01)` clamp prevents a divide-by-zero in the jaw torque screen. It can also hide an invalid efficiency input. Keep efficiency within `0 < η ≤ 1` and apply a documented design factor only after measurement; current defaults of 1.0 make no allowance.

The jaw torque relation `F_pad × perpendicular pivot arm` is a valid first-order static relation when the entered force is the normal load at the modeled contact and the arm is measured perpendicular to that force. It does not account for compliant pad deformation, object geometry, frictional grip requirement, multiple contact points, off-axis force, mechanical advantage varying through travel, friction/backlash, or dynamic acceleration. The average direct-drive speed formula `angle/(6·time)` converts degrees per second to rpm correctly, but it does not prove loaded speed or cycle capability.

## Mechanical path and prototype architecture

The current modeled path is actuator rotor → short coupling proxy → pivot shaft/keyed jaw hub → rotating arm and integral pin → thin sector slot → posts/screws → bearing ear/yoke → assumed adapter plate/body structure. The actuator reaction mount is also a packaging proxy around an assumed 20 mm body. The drawing does not yet establish compatible interfaces or capacities through this chain.

For a passive prototype and eventual powered redesign, keep the functions separate:

- Use the actuator mount to react stator torque into a structural yoke that can be tied into the vehicle's real bridge.
- Carry jaw radial loads in two supported bearings and carry shaft axial loads with a matched, serviceable retainer/washer arrangement. Do not make the drive coupling the axial retainer.
- Use a keyed/splined/clamped coupling whose two bores, lengths, tolerances, material, and retention method match the selected manufacturer's output and the actual pivot shaft.
- Make the stop replaceable and positively retained: a supported thick moving lug with a captured pin contacting broad replaceable stop blocks or shoulders attached directly to the yoke. Favor double-shear support where the real package permits it. Size every block, bolt, post, plate, bearing ear, and vehicle member in the resulting torque path.
- Use a controller soft limit and verified current/torque limit to stop normal travel before the structural stop. Keep the mechanical stop as a fault/overtravel boundary, not the normal braking surface.
- Keep the gear/drive shroud structurally separate from the stop load path. Provide inspection, ring/pin service, and actuator removal access without exposing moving gears in operation.

The present 11.8 mm shaft opening is below the 12.5 mm opening limit cited in the Explorer Part 2 notes, but the as-built aperture must be checked at seams, fasteners, and cable exits. The open functional jaw remains a separate pinch hazard requiring the team's safety lead and inspection review. The competition reference is [MATE Explorer Part 2](https://20693798.fs1.hubspotusercontent-na1.net/hubfs/20693798/2027%20MATE%20ROV%20Competition/Manual%20Components/EXPLORER%20Part%202%20SPECIFICATIONS.pdf).

## Exact selection and sizing inputs

### Mission and jaw

- Practice-prop/replica dimensions, approved contact zones, largest opening, smallest retained feature, connector axes, and task approach directions.
- Wet force-gauge measurements for grip retention, cover release, connector insertion/removal, breaker operation, panel seating, and push/docking; repeat and record worst direction.
- Maximum safe squeeze for delicate samples, minimum hold load for rigid objects, submerged weight/buoyancy, planned vehicle acceleration, and the team's design factor.
- Perpendicular pivot-to-force arm at each actual contact position; required angular travel, close time, full-run cycle count/duty, time holding a load, and behavior on loss of power.

### Actuator and electrical interface

- Manufacturer assembly drawing and CAD: body, mount faces/pattern, output-axis datum, shaft profile/diameter/usable length, cable exit, connector, removal envelope, and allowable radial/axial loads.
- Rated output torque versus speed across the needed travel, continuous/peak torque and duration, gearbox maximum/blocked torque, backlash, maximum voltage, current/torque limiting and response, stall current, thermal duty, braking/self-locking/backdriving, feedback, and failure behavior.
- Voltage conversion, controller, branch fuse, conductors, connectors, electrical SID entry, in-water current impact, and an emergency disconnect compatible with the vehicle system.
- Manufacturer depth/pressure rating or pressure-enclosure design, seal/feedthrough details, materials and corrosion compatibility for every wet component. A housing rating does not qualify a separate wet actuator.

### Pivot, stop, and structure

- Exact shaft material, heat treatment/hardness, dimensions/tolerances, key/flat geometry, matched retaining ring drawing, groove dimensions, washers, bearing sleeves, endplay tolerance, and allowable radial/axial load.
- Measured stop radius, stop contact geometry, actuator speed at contact, backlash, moving inertia, blocked torque/current limit, cycle count, and a documented impact-energy/load model.
- Pin/lug/stop-block/plate/yoke materials and manufacturing process, support condition, thickness, edge distances, fastener grade/preload/engagement, insert data, tolerances, and corrosion protection.
- Real body STEP/STP structural datum and bridge section, frame material/thickness, backing or through-bolt access, allowable reaction load, camera/guard/tether clearances, mass/center-of-mass and buoyancy budget.
- Team-approved design factor, proof method, inspection criteria, and safety-lead interpretation for the powered jaw and access guards.

## Sources and evidence boundary

- SCAD parameter values and formulas were inspected in `gripper_study.scad`; no material stress, interference sweep, or physical load test was performed for this review.
- The stop scenarios are documented in `hard_stop_subsystem_review.md`; they are calculation examples, not mission requirements.
- The actuator comparison and manufacturer references are collected in `actuator_selection_basis.md`; the commercial Newton figures apply only to that product, not to this custom jaw.
- The pivot ring reference and its conditional supplier capacities are described in `pivot_hardware_basis.md`; the modeled annular proxy is not the vendor ring geometry or a shaft rating.

## Prototype gate

Proceed first with a manually operated, unpowered prototype for prop geometry, service access, and contact trials. Before powered testing, select the real actuator and matched drive parts, size the complete torque reaction and axial-retention paths at maximum credible output plus documented transient allowance, replace the current integral printed pin/slot, guard the gear and pinch hazards, and pass a secured bench proof/load-cycle review. CAD compilation and `Simple: yes` mesh output do not satisfy these gates.
