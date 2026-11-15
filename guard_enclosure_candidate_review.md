# Stop-guard enclosure candidate review

**Status:** unpowered prototype packaging candidate. It is not load-rated or inspection-approved.

## Geometry and service concept

`gripper_study_stop_guard_enclosure_candidate.scad` is a separate variant of the jointed gripper study. It adds a 360-degree wall around the drive/stop, a removable lid, and two lower panels. The panels have nominal reliefs for the existing bearing bracket, cheek, fixed rail, cross tie, and shell bosses. The lid is removable from above; lower screws are accessible from below. OpenSCAD selectors export the shell, left panel, right panel, lid, and hardware proxies individually.

Key nominal values:

- Radial enclosure: 92 mm OD / 84 mm ID; lid Ø100 x 2 mm.
- Shaft passages: Ø11.8 mm; cheek port: 12.4 x 12 mm; split-panel seam: 0.4 mm.
- Floor panels: z=10.3 to 11.8 mm. Shell flange begins at z=12.0 mm, leaving 0.2 mm nominal vertical service clearance.
- Lower bosses: Ø6.5 mm with Ø2.5 mm pilot, 3.2 mm engagement length; the reaction-rail-near station is placed at 165°. Panel relief Ø7.3 mm (0.4 mm radial clearance); a Ø9 x 1 mm underside screw-head flange bears on the panel around that relief.
- Lid bosses: Ø8.5 mm with Ø2.5 mm pilot and 5.5 mm boss height. Placeholder screw shanks pass through the lid and into the pilots.
- Large bracket, support, and beam reliefs depend on their matched structural members fully occupying the removed panel/wall areas. A static no-intersection check does not prove that they close every access path.

The screws are M3-class geometry proxies intended to self-tap into printed pilots. Pullout strength, repeated service life, print-material suitability, corrosion resistance, and exact hardware fit are untested. Select the print material and actual screws, then test pilot coupons before relying on the joint.

## Verification

`validate_gripper_study_stop_guard_enclosure_candidate.ps1` completed with exit code 0 using OpenSCAD 2021.01 and `--hardwarnings`:

- `assembly` and `stop_guard_enclosure_only` compiled without warnings.
- Floor/support, floor/bearing, floor/actuator, floor/bridge, floor/shaft, aggregate floor/structure, shell/floor, and wall/support intersection outputs were empty.
- Guard/mechanism intersections were empty at 0, 5, 10, 15, 20, 22, 25, 30, 35, 40, and 44 degrees (11 static samples).
- Individual STL exports were nonempty: shell 2,136 facets; left panel 384; right panel 404; lid 1,456; hardware proxy 2,656.
- Actual OpenSCAD previews were rendered for the full assembly and isolated enclosure.

Faustinius performed a read-only DfM review of the updated floor/shell seating and fastener layout. The geometry now separates without modeled shell/panel interference and the lower screw head bridges the panel relief. The review does not validate printed self-tapped joints or physical assembly.

QA logs, CSG and STL outputs, actual previews, and labeled earlier collision meshes are kept under `gripper_study_stop_guard_enclosure_candidate_qa/` and in the companion ZIP archive. This validates nominal static CAD geometry only. It does not validate continuous motion clearance, tolerance stacks, strength, material, hardware sourcing, sealing, physical fit, access protection, or competition compliance.

## MATE requirement and limits

Explorer Part 2 §3.2.6 requires gear assemblies to be fully shrouded, gives an opening criterion of less than 12.5 mm or solid covering, and says the guard is inadequate if a finger can touch the gear assembly. The 12.4 mm cheek port is nominally only 0.1 mm below that opening value. The larger reliefs rely on adjacent solids filling them. Assemble the actual actuator, coupler, retainers, fasteners, structure, and panels; inspect every seam and service state with the team safety lead/inspector. Jaw pinch protection is a separate assessment. No MATE compliance claim is made.

Source: [official 2027 Explorer Part 2 manual](https://20693798.fs1.hubspotusercontent-na1.net/hubfs/20693798/2027%20MATE%20ROV%20Competition/Manual%20Components/EXPLORER%20Part%202%20SPECIFICATIONS.pdf).

## Integration dependencies

- The supplied vehicle STL is a visual concept with electronics and thruster stand-ins. It has no units, mounting datums, axes, or separable parts, so the candidate is not positioned or verified against it.
- The vehicle STEP/STP assembly in millimetres is still needed to locate the end effector, mount, thrusters, cameras, and service envelope.
- Official task props or measured faithful practice props are needed to set jaw opening, contact geometry, forces, and task coverage.
- Verify selected actuator torque/current, shaft/coupler fit, and load path before powered operation.


