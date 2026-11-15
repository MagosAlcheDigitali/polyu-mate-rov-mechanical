# Supplied clamp STL geometry inspection

Source: `Michelangelo Dealberti FInal Clamp Design.stl` in this repository. The STL was inspected on GitHub Actions using Python's standard library.

## Mesh facts

- Binary STL: 39,086 triangles, 1,954,384 bytes.
- 29 disconnected triangle components when vertices are joined after rounding coordinates to 0.001 mm.
- Whole-mesh bounds: X -96.265…49.270 mm, Y -38.000…14.445 mm, Z -14.192…175.678 mm.

The complete component bounds and centers are in the [component inventory](reference_mesh_components.md).

Two long, thin components (1,192 triangles each) have matching X/Z bounds and sit on opposite Y sides:

| Plate | X bounds (mm) | Y bounds (mm) | Z bounds (mm) |
|---|---:|---:|---:|
| A | -50.604…7.995 | 0.000…2.600 | -7.998…121.599 |
| B | -50.604…7.995 | -23.000…-20.400 | -7.998…121.599 |

Their X center is -21.3045 mm. Their Y centerlines are +1.300 and -21.700 mm, with a midpoint at -10.200 mm. The parametric cradle uses the two plates for clip geometry, and uses their midpoint as a **candidate** rod axis.

The full 29-component inventory does not identify a distinct long, slender component on that candidate axis. Several components' bounding boxes overlap it, but their bounds are broad and do not establish a rod or its diameter. Thus the rack sleeve is an editable interface placeholder for the moving center member; its 8 mm bore target is an assumption.

A second pair of broad, thin components lies at:
- X -38.397…43.311, Y 0…5, Z 36.847…92.245 mm.
- X -38.042…43.666, Y -22…-17, Z 36.644…92.043 mm.

A 20 × 52.445 × 20 mm component occupies X -36.397…-16.397, Y -38…14.445, Z 51.751…71.751 mm. The STL does not identify which components are fixed, moving, or jaw parts.

## Remaining fit questions

The STL has no feature names or motion constraints. The two long plates are treated as fixed guide rails for the prototype clips, but that must be confirmed. The sliding member's geometry and exposed end are not identifiable in this mesh inventory. Confirm its axis, diameter, direction of travel, and available engagement length. Also confirm the clip stations and pitch-axis clearance over the full jaw and tilt motion. Treat the model as a connected concept layout, not a fabrication release.
