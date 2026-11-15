# Stop-guard enclosure candidate review

**Status:** unpowered packaging study; not a fabrication release or an inspection-compliance result.

## Candidate geometry

`gripper_study_stop_guard_enclosure_candidate.scad` is a separate copy of the jointed gripper study. It adds a 360-degree radial wall, a removable top lid, and two removable lower panels around the stop/fork mechanism. The lower panels and wall have close-fitting reliefs for the modeled bearing bracket, support cheek, fixed reaction rail, and cross tie. One lower panel screw station is intentionally shifted to 180 degrees to clear the bridge foot and cross tie; the remaining three stay at 45, 135, and 315 degrees.

Nominal geometry reported by the model:

- 11.8 mm top and lower shaft passages.
- 12.4 x 12 mm cheek port at the radial wall and a 12.4 mm-wide floor channel around a 12 mm cheek.
- 0.4 mm split-panel seam.
- 32.4 x 40.4 mm relief around a 32 x 40 mm bearing bracket; 12.4 mm-wide reliefs around 12 mm support members; and an 84.4 x 10.4 mm relief around an 84 x 10 mm cross tie. These larger reliefs depend on the corresponding solid parts occupying them in the assembled mechanism.
- 3.2 mm screw passages and 5.5–5.7 mm head recesses.
- The shifted lower boss is 6.5 mm outside diameter around a 3.2 mm passage (1.65 mm nominal radial wall); nominal separation to the left reaction rail is 0.75 mm. These are placeholders, not selected hardware or manufacturing tolerances.
- The floor top is at z=11.8 mm, with 0.7 mm nominal clearance to the lower stop-pin head.

## Verification

`validate_gripper_study_stop_guard_enclosure_candidate.ps1` was run locally with OpenSCAD 2021.01. Exit code 0. It compiled the complete assembly and guard-only view with `--hardwarnings`; floor intersections against support, bearing, actuator, bridge, and shaft; aggregate floor-versus-structure; and radial-wall-versus-support exports were empty. The assembled enclosure-versus-mechanism intersections were empty at 0, 22, and 44 degrees. Actual OpenSCAD PNGs were rendered for the assembly and guard-only view. QA logs, CSG outputs, empty results, and labeled pre-fix collision meshes are retained under `gripper_study_stop_guard_enclosure_candidate_qa/`.

These checks show sampled static non-interference only. They do not prove continuous clearance, assembly tolerance, strength, material suitability, hardware fit, stop contact, actuator suitability, or vehicle/mission-prop fit.

## MATE guard requirement and limits

Explorer Part 2 §3.2.6 requires gear assemblies to be fully shrouded, gives an opening criterion of less than 12.5 mm or solid covering, and says the guard is inadequate if a finger can touch the gear assembly. The source does not require a calibrated access probe and does not set a numeric functional jaw-mouth limit. See the [official Explorer Part 2 manual](https://20693798.fs1.hubspotusercontent-na1.net/hubfs/20693798/2027%20MATE%20ROV%20Competition/Manual%20Components/EXPLORER%20Part%202%20SPECIFICATIONS.pdf).

The model's 12.4 mm cheek port is only 0.1 mm below the stated width criterion nominally. Larger reliefs are acceptable as solid-covered paths only if the actual mating members continuously fill them with no harmful access path. The collision validator does not inspect finger reach or prove that coverage. Assemble the actual actuator, coupling, retainer, fasteners, supports, and guard; inspect every seam, port, and service reassembly state with the team safety lead/official inspector. Assess the functional jaw pinch zone separately.

## Next dependencies

- The vehicle STEP/STP assembly and actual thruster/guard/camera/service geometry are still required to place and load the tool.
- Official task props or faithful practice props are still required to size jaw opening, pads, contact forces, and task coverage.
- Select and measure the real actuator and all guard hardware; verify tolerances and inspect physically before powered testing.
- The active `gripper_study.scad` remains unchanged and retains its unsuitable printed stop. Do not power that active design or this unqualified packaging candidate.

