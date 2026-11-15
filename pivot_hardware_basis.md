# Pivot Shaft and Axial-Retention Hardware Basis

**Reviewer:** Kelbor-Hal  
**Date checked:** 15 November 2026  
**Scope:** Pivot shaft, sleeve/bearing, thrust washers, retaining rings, and axial endplay in `gripper_study.scad`. This is a hardware-interface review only; no CAD was changed and no load rating is approved.

## Current modeled stack

The study uses an 8 mm nominal pivot shaft, two 4 mm bearing ears, a 12 mm OD replaceable sleeve with an 8.2 mm bore and 3.8 mm modeled length, 0.5 mm thrust washers, and two split-ring proxies. The shaft has D-flat/key geometry for the jaw and a drive flat below the lower bearing. The axial stack sets 0.2 mm nominal endplay and leaves nominal clearances near the stop plate and coupling.

At the time of this review, the retention dimensions were placeholders: ring thickness 0.8 mm, ring OD 11 mm, shaft-groove diameter 7.2 mm, groove width 1.0 mm, washer ID 8.2 mm, and washer OD 12 mm. A follow-on source update sets the groove to the DSH-8 reference Ø7.6 x 0.9 mm; the ring module remains a simple split annulus and does not model a manufacturer's outline, lug holes, install tool, tolerances, or rated shoulder.

## Comparison with a catalog 8 mm DIN 471 ring

Rotor Clip's DSH-8 catalog row gives an 8 mm shaft application with 7.6 mm groove diameter (−0.06 mm tolerance), 0.90 mm minimum groove width, 0.20 mm groove depth, 0.80 mm ring thickness (−0.05 mm tolerance), and 7.4 mm free diameter. American Ring's DIN471-008 listing independently gives 7.59 mm groove diameter, 0.89 mm groove width, 0.18 mm depth, and 0.79 mm ring thickness. These are matching manufacturer implementations; use the chosen ring supplier's own print and tolerance limits for a machined shaft.

| Feature | SCAD at review → updated reference | DIN 471 size 8 reference | Design consequence |
|---|---:|---:|---|
| Shaft diameter | 8.0 mm | 8.0 mm application size | Nominal shaft diameter is compatible as a starting point. Check shaft tolerance and bearing fit. |
| Groove root diameter | 7.2 → 7.6 mm | 7.6 mm nominal (Rotor Clip −0.06 mm) | Source updated to the DSH-8 reference; use the selected ring drawing and shaft material/strength requirements before machining. |
| Groove width | 1.0 → 0.9 mm | 0.90 mm minimum | Source updated to the DSH-8 reference; use the selected supplier's tolerance and recalculate axial play from real hardware. |
| Ring thickness | 0.8 mm | 0.80 mm nominal (−0.05 mm in Rotor Clip table) | Nominal thickness matches, but the CAD ring's simple annular profile does not reproduce the real circlip or its retaining shoulder. |
| Ring profile/clearance | 11 mm simple split annulus | Manufacturer lists 7.4 mm free diameter and 3.2 mm maximum lug height; PGB lists a 14.7 mm clearance/outer envelope for its DIN 471-8 item | Do not set a final ring OD from the 11 mm proxy. Import or measure the selected ring profile and check the washer overlap, stop-guard clearance, and installation-tool access. |
| Axial endplay | 0.2 mm modeled | Not established by ring size alone | Recalculate from the actual two bearing faces, jaw hub, both washer thicknesses, groove positions, ring thicknesses, and manufacturing tolerances. |

Rotor Clip's catalog lists 3.00 kN ring thrust capacity and 0.8 kN groove thrust capacity for its DSH-8 row (with a 0.6 mm minimum edge margin); it also lists a separate maximum-with-chamfer value. These catalog values are conditional on its specified ring, groove geometry, material and edge conditions. They are reference data only, not a capacity claim for this modeled shaft, the printed/unknown yoke, or this gripper's impact and cycle loads. The groove can be the lower-capacity part of the pair.

## Candidate prototype stack

For a geometry/passive-load prototype, retain the 8 mm pivot concept and evaluate one matched external-retaining-ring system as a complete set:

1. Select an actual 8 mm shaft ring from a supplier with an engineering drawing and axial-load data. Ask for a stainless spring version suitable for the team's water and cleaning exposure; Beneri lists A4 / AISI 316L DIN 471 rings in this diameter range. A generic plain spring-steel ring can be susceptible to corrosion, and stainless grade alone does not qualify the groove or the wet assembly.
2. Machine or purchase the shaft to the selected ring's stated diameter, groove diameter, groove width, corner radius, and tolerances. Preserve enough shaft shoulder/edge distance and material hardness for the manufacturer's stated capacities. Keep the ring grooves outside the bearing sleeves and away from the keyed jaw hub, drive flat, and coupling engagement.
3. Fit thrust washers between each bearing face and retaining ring. Choose washer ID, OD, material, and thickness from the real shaft/ring drawing and the available guard envelope. Confirm the circlip shoulder positively overlaps the washer under the intended axial load; use the actual ring outline rather than the present 11 mm annulus proxy.
4. Set the assembled endplay only after measuring the bearing-ear spacing, jaw hub width, sleeve length, washer thickness, groove spacing, and actual ring thickness. Ensure jaw rotation is free without meaningful axial rattle, binding, or preload that drags the sleeves.
5. Make the rings inspectable and removable with the correct retaining-ring pliers. The shaft and rings must remain captive if the washer wears or the assembly is handled during service. Keep all ring edges and tool access behind the guard in the powered configuration.

An M8 shoulder-bolt pivot with a nut/washer stack is a fallback for a hand-operated mockup if the team lacks shaft-groove machining. It requires an accurately selected shoulder length, a smooth bearing land through the sleeves and jaw hub, thread entirely outside those bearing surfaces, a positively locked nut, and enough end access for service. It does not remove the need to establish the axial stack or prove the shaft/joint load path.

## Checks still required

- Measure radial, axial, and shock loads at the jaw pivot from faithful props and the team's intended ROV accelerations. Separate normal operation from stop impacts.
- Select actual shaft and ring materials/treatments as a compatible wet pair; confirm corrosion, wear, galvanic compatibility, shaft hardness, groove corner radius, and cleaning/inspection practice with the vendor.
- Verify the catalog ring/groove capacities against the selected shaft and supporting washer/bearing/yoke materials, with the team's approved design factor and loading direction. Check shaft net-section strength at both grooves and at the drive flat/key.
- Check sleeve bearing pressure, projected area, fit/tolerance, lubrication or water-lubricated suitability, debris ingress, wear, and replacement method. The modeled 12 x 3.8 mm sleeve is only a geometric proxy.
- Rebuild the axial stack in CAD from the exact vendor part drawings. Sweep the jaw at both hard stops; confirm ring/washer/stop-sector/coupler/guard clearance and that retaining-ring ears do not create an unsafe opening or snag point.
- Test the matched passive pivot for binding, measurable endplay, ring seating, axial pull retention, wear, and corrosion after wet cycles. Keep the actuator disconnected. Powered testing requires the separate actuator, stop, guard, and vehicle-load-path gates to pass.

## Sources

- Rotor Clip, DSH Shaft Rings (DIN 471) catalog, DSH-8 dimensional and thrust-load row: [manufacturer catalog PDF](https://www.rotorclip.com/wp-content/uploads/2023/03/rotor_clip_catalog-2017.pdf)
- American Ring, DIN 471 metric ring-series dimensions, DIN471-008: [manufacturer dimensional table](https://www.americanring.com/products/ringseries.aspx?AspxAutoDetectCookieSupport=1&series=DIN471&units=metric)
- Beneri, DIN 471 product page and material range, including A4 / AISI 316L for 3–27 mm sizes: [manufacturer product information](https://www.beneri.com/en/prodotto/din-471)
- PGB Fasteners, DIN 471 Ø8 product data and plain spring-steel environment note: [supplier dimensional page](https://www.pgb-europe.com/en-gb/262145/retaining-ring-for-shafts-din-471-8)

## Follow-on CAD update — 15 November 2026

The parent design update changed `shaft_retainer_groove_d` from 7.2 to 7.6 mm and `shaft_retainer_groove_w` from 1.0 to 0.9 mm using the Rotor Clip DSH-8 catalog reference. The pivot-shaft, axial-retention, and tool-only assembly STL review meshes were regenerated from that source. The 11 mm split-annulus ring proxy, 12 mm washer, 0.2 mm endplay, shaft material, guard clearance, and load capacity remain unverified. No powered, wet, or structural test was performed.

## Follow-on actuator-guard clearance update — 15 November 2026

The lower groove center is at z = −13.1 mm. With the 0.8 mm study ring, its axial envelope is z = −13.5 to −12.7 mm. The actuator guard end wall previously occupied z = −14 to −13 mm, causing a 0.5 mm axial overlap (the ring's likely lug envelope is larger than the 11 mm proxy). The source now derives `actuator_guard_bearing_clearance` from the lower washer/endplay/ring stack plus a 0.2 mm study gap, placing the guard top at z = −13.7 mm. The unchanged Ø11.8 mm shaft opening remains below the MATE nominal Ø12.5 mm access limit. This is an analytical packaging correction only: the actual installed ring CAD, ring-to-yoke/cap access, service-tool access, and IP-20 guarding still need review before powered use. The Rotor Clip product page lists a nominal-installed-state CAD option and DSH-8 groove/ring dimensions, but the CAD file has not been imported.
