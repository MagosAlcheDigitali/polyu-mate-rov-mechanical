# Pad Retention Coupon Export Review

**Reviewer:** Koriel Zeth  
**Date:** 15 November 2026  
**Scope:** Read-only inspection of the pad-retention coupon module and its STL inventory entry.

## Finding

The current `pad_retention_coupon` view combines four categories of geometry into one STL:

1. The rail coupon body with insert pilot bores and head seats cut into it.
2. The replaceable pad solid.
3. The upper/lower keeper strips with fastener clearance holes.
4. Positive proxy solids for the M3 screws and the Tappex insert rings/heads.

The last category is an assembly visualization. The insert and screw proxies are not cut from a print body or treated as separate hardware by the STL format. Printing this combined file as one object will print/fuse those features into the coupon, so it cannot then accept the real threaded inserts and screws for a meaningful installation/retention fit trial. The proxy geometry is present; it is not real or installable hardware.

The existing `pad_retention_coupon.stl` can remain an assembly visualization if clearly labeled as non-printable for hardware fit. The inventory currently calls it an “isolated rail/pad/keeper/insert/screw fit coupon,” which overstates its suitability as a print-and-assemble test artifact.

## Minimum separate exports for a physical fit trial

Provide three hardware-free printable views, each exported independently from the OpenSCAD source:

- **Coupon body only:** rail with pilot bores and head seats; no insert, pad, keeper, or screw solids. This is the part in which the team installs and inspects real threaded inserts.
- **Pad only:** replaceable contact insert, with the chosen channel profile.
- **Keeper strips only:** the assembled upper/lower keeper geometry with real screw clearance holes, exported without screw solids.

Use real candidate inserts and screws for assembly. A fourth optional **visual assembly preview** may show the body, pad, keeper, and hardware proxies together, but its filename and notes should explicitly say preview/visualization and warn not to print it as one object. Include one physical coupon body per pilot-hole variant if the team wants to compare manufacturer-range holes (for example, a low/mid/high fit study); do not infer the correct hole size from a midpoint alone.

## Checks before calling the export printable

- Confirm the body-only file has open bores at the insert locations and no proxy solids closing them.
- Confirm the keeper-only file has clear fastener holes and is not fused to the coupon body.
- Confirm the pad is a separate replacement part and cannot be sliced as fused to the rail.
- Check every exported STL's bounds, facet count, manifold result, and terminator after export; preview the three files in a slicer before physical printing.
- Assemble with actual inserts/screws and inspect hole fit, insertion damage/cracking, screw access, keeper seating, pad capture, and pullout behavior. Geometry fit does not establish load capacity.

The current OpenSCAD helpers already expose `pad_retention_coupon_body()`, `pad_insert()`, and `keeper_strips()` separately as internal modules; public `part_view` selections are needed to export those printable parts without the positive hardware proxies.

## Resolution — 15 November 2026

Added public `part_view` selections for a body-only coupon, pad-only insert, and keeper-only pair. OpenSCAD 2021.01 rendered all three as `Simple: yes`; direct STL counts are 2,588, 1,608, and 4,888 triangles, and all files end with `endsolid OpenSCAD_Model`. The assembled coupon export remains unchanged in function and is now documented as visual-only. The physical fit trial must use the three separate print parts with real selected M3 inserts and screws. The STL exports establish geometry generation, not fit to the team's material or joint strength.
