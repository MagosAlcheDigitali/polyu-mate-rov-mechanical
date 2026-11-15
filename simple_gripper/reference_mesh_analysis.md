# Supplied clamp STL geometry inspection

Source: `Michelangelo Dealberti FInal Clamp Design.stl` in this repository. The STL was read on a GitHub Actions runner with Python's standard library; no local machine files were accessed.

## Mesh facts

- Binary STL: 39,086 triangles, 1,954,384 bytes.
- 29 disconnected triangle components when vertices are joined after rounding coordinates to 0.001 mm.
- Whole-mesh bounds: X -96.265…49.270 mm, Y -38.000…14.445 mm, Z -14.192…175.678 mm.

Two long, thin components (1,192 triangles each) have matching X/Z bounds and sit on opposite Y sides:

| Plate | X bounds (mm) | Y bounds (mm) | Z bounds (mm) |
|---|---:|---:|---:|
| A | -50.604…7.995 | 0.000…2.600 | -7.998…121.599 |
| B | -50.604…7.995 | -23.000…-20.400 | -7.998…121.599 |

Their X center is -21.3045 mm. Their Y centerlines are +1.300 and -21.700 mm, with a midpoint at -10.200 mm. The CAD's rack axis defaults now use X=-21.305 and Y=-10.2 as a **candidate centerline** between these plates. This is a geometry-derived alignment reference, not proof of the moving rod's exact axis or diameter.

A second pair of broad, thin components lies at:
- X -38.397…43.311, Y 0…5, Z 36.847…92.245 mm.
- X -38.042…43.666, Y -22…-17, Z 36.644…92.043 mm.

A 20 × 52.445 × 20 mm component occupies X -36.397…-16.397, Y -38…14.445, Z 51.751…71.751 mm. Its center is approximately (-26.397, -11.778, 61.751) mm. The STL does not identify whether this is fixed or moving.

## What remains unresolved

The STL has no feature names or motion constraints. Component bounds cannot tell which plates are stationary, where the center rod protrudes, or which Z stations remain clear throughout jaw travel. Therefore the rod sleeve's fit, body saddle positions, and pitch-carriage attachment still require the editable model or direct dimensions. Do not treat the current saddle bands as fitted hardware.
