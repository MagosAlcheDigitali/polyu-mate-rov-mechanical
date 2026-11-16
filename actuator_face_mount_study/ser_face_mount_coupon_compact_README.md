# Compact SER face-pattern coupon

This alternate coupon keeps the drawing-based four-hole pattern but reduces the adapter plate from 78 × 40 mm to 66 × 36 × 3 mm. The rectangle has a 37.59 mm corner radius. If the plate and an Ø84 mm circular guard bore occupy the same plane, the nominal corner clearance is 4.41 mm. The earlier 78 × 40 mm plate has a 43.83 mm corner radius and would fail that same-plane screen by 1.83 mm.

The compact plate keeps 4.0 mm provisional screw-clearance holes on the 35 × 22 mm pattern, a Ø26 mm provisional center opening, and at least 5 mm of plate from the nearest hole edge to the plate edge. Its footprint is smaller than the 70 × 32 mm case in X by 4 mm overall; this is a fastener-pattern plate, not a full-face protective cover.

These values are a geometric screen only. The Ø84 mm feature is the existing stop-enclosure bore; its axial position relative to the SER face plate has not been confirmed, so the same-plane assumption must be checked in the assembly. The coupon has no vehicle/yoke connection and does not establish mount stiffness, screw capacity, hard-stop load path, body clearance, or fabrication readiness. Obtain the vendor STEP and integrate the plate with the separate pivot bearings and stop structure before treating it as a mount candidate.

## OpenSCAD

Open `ser_face_mount_coupon_compact.scad`. Select `assembly`, `plate_only`, or `pattern_check` with `part_view`. The default view shows the case-envelope proxy, output feature, compact plate, and visual screw proxies. The `plate_only` STL is useful for a no-load pattern/guard-bore mock-up. `validate_compact_coupon.ps1` compiles the three selectors with OpenSCAD hard warnings, exports the STL/preview, and checks the STL bounds.

## Drawing assumptions

- SER case: 70 × 32 × 67 mm; top feature Ø24 × 5.1 mm; output D-shaft Ø6 × 8 mm.
- Four top holes: Ø2.9 mm × 16 mm deep, 35 × 22 mm pattern; manufacturer drawing calls for #6/M3.5 self-tapping screws.
- Plate: 66 × 36 × 3 mm; provisional Ø4.0 mm clearance holes and Ø26 mm center opening.

The exact vendor STEP remains required to confirm the face datum, thread and case corner geometry, output-shaft flat, connector, side holes, and cable exit.

