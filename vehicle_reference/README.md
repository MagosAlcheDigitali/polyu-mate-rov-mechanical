# Vehicle body concept mesh

`vehicle_body_concept.stl` is the team's supplied concept mesh with stand-ins for the electronics box and thrusters. It is stored for preliminary envelope and collision review only.

## Mesh inspection

- Binary STL from Autodesk Fusion; 3,860 triangles; 193,084 bytes.
- Coordinate bounds: X = -124.409 to 348.409, Y = -171 to 85, Z = -266 to 442. Coordinate extents are 472.819 x 256 x 708.
- STL does not encode units. The dimensions above are in model coordinate units; treat them as millimetres only if the team confirms the export scale.
- Connectivity check: one connected triangle component, 0 boundary edges, 0 edges shared by more than two facets, and 0 degenerate triangles (using vertex coordinates rounded to 0.00001 model units). This supports use as a closed collision-surface reference, but does not prove physical fit or structural soundness. The mesh has no body names, mates, mounting datums, or separately addressable solids. The geometry does not yet identify the true electronics-bay service envelope, thruster axes/guard clearance, camera view, tether route, or structural attachment faces.
- SHA-256: 7a839ab582170d2cf49d9f052b27c256e1e63e956e3950be18685f2e79b3d1d6

## Use in gripper integration

Import this mesh as a non-editable reference body, align the chosen vehicle front and gripper approach axis, then check the gripper's full open/closed sweep, reach, cable route, camera line of sight, and guard clearance. Do not define mount holes or claim structural fit from a triangulated stand-in. Replace this reference with the complete `.step`/`.stp` assembly when available, including actual frame members, thrusters and guards, camera, sealed electronics housing, service path, foam, and cables.

The current gripper plate pattern and body envelope remain unverified. The source STL is a concept supplied by the team and is not an official MATE mission model.