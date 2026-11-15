# Replaceable Pad and Keeper Mechanical Review

**Reviewer:** Melgator  
**Scope:** Fixed and moving pad inserts, keeper strips, their fastener proxies, and the existing pad coupon workflow.  
**Status:** Design review for an unpowered mockup. No pad, fastener, material, or complete gripper is qualified for powered or submerged loading.

## What the current CAD represents

The OpenSCAD defaults use nominal 9 x 24 x 14 mm replaceable inserts. The fixed and moving pads can independently use a round channel, V channel, or flat face; the default is a round channel with a 4 mm radius. Two keeper strips cover the pad's upper and lower sides and end fences capture its ends. The source models two nominal M3 fasteners per keeper strip, with 3 mm shanks, 5 mm head proxies, 1.5 mm keeper thickness, and blind 8.5 mm pilot bores in the jaw/anvil body. The screw stations scale from a 24 mm reference pad length.

The new isolated views are useful for previewing the insert, jaw body, keeper strips, and fastener arrangement separately. OpenSCAD reported `Simple: yes` for these views, but that is a mesh-generation result, not a printability, strength, fit, or retention rating. Fastener meshes are geometric proxies and have no thread form. The standalone coupon STL pairs omit the jaw backing, keeper strips, and fasteners; their nominal 24 mm gap is between blank faces, not a verified prop fit or local gap through the channel.

## Findings and design risks

1. **The retainer hardware definition is incomplete.** The CAD shows 3.3 mm blind pilot holes in the bodies and 3.4 mm clearance holes in the keepers, but does not define a thread, insert, captive nut, through-bolt, screw length, or engagement. A plain 3 mm proxy in a 3.3 mm bore does not establish a reliable joint. Select and model a real retention method, then verify actual engagement, head seating, service access, and resistance to loosening before loading the pads.
2. **The pad geometry has no measured mission interface.** A 4 mm radius channel may suit some cylindrical features, but no prop diameter, allowed contact zone, surface material, approach tolerance, or required pull direction is established. A V or flat insert is likewise only a shape option. A concave groove can improve geometric capture for a matching feature, but may concentrate contact at edges or make release harder; validate against a faithful, non-living practice prop.
3. **Contact material and compliant behavior are undecided.** The CAD gives shape only. It does not define polymer, hardness, print orientation, layer direction, walls/infill, casting process, water conditioning, wet friction, compression, tear resistance, or acceptable sample marking. Do not infer safe plant contact or grip capacity from softness or a coupon hand test.
4. **Keeper fit and clearance need an assembled physical check.** The keepers and their end fences must capture the insert while leaving the intended contact face exposed. Real print/machining tolerances, pad compression, burrs, debris, and water/silt paths are absent from the model. Verify that the insert cannot migrate toward the jaw opening and that worn material cannot expose a sharp structural edge.
5. **Fastener spacing check is only a warn-only screen.** At the default 24 mm pad length, the two pairs are spaced 7 mm and 17 mm center-to-center on opposite outer faces. The SCAD warns when the smaller spacing falls below the 5.5 mm head-diameter-plus-clearance threshold (about 18.9 mm pad length with the current scaling). This does not check edge distance, keeper strength, screw pullout, torque, tolerances, thread engagement, collision through the jaw sweep, or tool access. Keep the warning and add manual checks after changing pad length or screw size.
6. **The proxy fasteners and keeper edges can become failure hazards.** Exposed heads, protruding thread, loosened screws, cracked retainers, or a displaced insert can snag a prop or leave a hard edge at the contact face. Consider sediment flushing and retention inspection in the real geometry. Adhesive should not be treated as the primary retention method.
7. **The isolated views are assembly-coordinate meshes, not print setup files.** The README correctly records world-axis bounds. They do not choose an orientation, establish support strategy, compensate for material shrinkage, or prove that individual solids print and assemble as intended. Reorient and slice according to the selected process, then inspect the physical samples.

## Dimensions and hardware to obtain before choosing a final profile

- Actual prop or faithful replica: grasp-feature width/diameter, usable contact length, edge radii, surface/material, permitted grasp zone, approach axis, and release path.
- Mission interaction: direction and magnitude of expected pull/push, safe squeeze/contact limit, submerged mass/buoyancy, alignment tolerance, required hold duration, and acceptable marking/damage.
- Insert and keeper stack: measured jaw-seat dimensions, clearance/interference, keeper overlap, end-fence engagement, allowable pad compression, and wear allowance.
- Fasteners: selected screw standard and length, actual thread/captive feature, engagement depth, head and tool-clearance envelope, edge distances, tightening method, and underwater corrosion compatibility.
- Candidate pad material/process: exact product and lot, dimensions after manufacture, conditioning, print/cast orientation and settings, and observed wet slip, marking, compression set, and tearing.

Do not tune the coupon to a remembered or illustrative prop size. Record measured inputs in the team's interface worksheet and change the SCAD from those measurements.

## Recommended prototype and inspection sequence

1. **Freeze the question, not the material:** obtain the practice prop and record the permitted contact zone, target feature dimensions, pull direction, and sample-safe test limit. If these are unknown, use a robust inert replica and only gentle, unpowered handling.
2. **Run a shape-only comparison:** print round, V, flat, and any asymmetric fixed/moving coupon pair from one documented batch and same nominal blank dimensions. Check capture, approach, release, snagging, and contact location by hand. The paired coupon is for screening only; its faces do not include the jaw, screws, or retainers.
3. **Resolve retainer hardware on a passive assembly:** select and model the real fastener/thread arrangement. Print or machine the jaw/anvil plus both keeper strips, fit the insert, and assemble with the chosen hardware. Confirm the screws seat without contacting the prop or crushing/extruding the insert; confirm the keeper is flush and the insert cannot slide out through the open jaw side.
4. **Inspect a complete passive mockup:** exercise the full manual open/close sweep without an actuator. Check pad/keeper/anvil interference, screw access, exposed edges, keeper cracking, pad movement, and whether water or sediment is trapped. Photograph and record dimensions and any adjustments. No load rating follows from this check.
5. **Compare candidate materials passively:** after team approval of the contact zone, repeat consistent dry and wet trials using a secured fixture and force gauge/spring scale. Keep the actuator disconnected. Log conditioning, pull direction, force at first slip, visible prop marking, release effort, pad extrusion/tear, screw movement, and cycle count. Stop at the known safe-contact limit; if it is unknown, remain at gentle qualitative screening.
6. **Powered-use gate:** do not power the jaw until the prop interface and safe contact limit are known, actual hardware and pad materials are selected, pad retention is checked against the team's measured maximum load with an approved safety margin, actuator current/force is bounded, and the stop/guard system and full vehicle mount are reviewed. Include repeated wet cycles and post-test inspection. Any unknown safe squeeze or load keeps the design at passive testing.

## Conclusion

Keep the mechanically retained, replaceable pad concept for controlled prototype trials. The present geometry is useful for comparing shape and assembly access, but its blind pilot holes, proxy fasteners, unselected material, and unverified prop interface prevent a powered-use decision. Select the profile and retention hardware from measured prop geometry and documented passive wet trials, then reopen the powered gate only with measured force and retention evidence.

## Follow-up CAD and hardware candidate — 15 November 2026

The pad rail was increased to 12 mm and its modeled M3 pilot was aligned for a Tappex Trisert-3 reduced-head M3 316 stainless insert candidate (insert OD 4.73 mm, length 5.25 mm, head Ø4.70 x 0.38 mm; nominal boss Ø7.70 mm). The CAD uses a 4.25 mm pilot, the midpoint of Tappex's approximate 4.10–4.40 mm plastic-hole range, and a 5.80 mm depth. Tappex says application dimensions are approximate and should be verified with its application engineering; these dimensions are not a qualification for the team's print process or polymer. The plate and rear tie are both now 84 mm, and the inner keeper screw pair is spaced 10 mm.

The separate `prototype_meshes/pad_retention_coupon_body.stl`, `pad_retention_coupon_pad.stl`, and `pad_retention_coupon_keepers.stl` are now the printable pieces for an unpowered fit trial; use real inserts and screws during assembly. The combined `pad_retention_coupon.stl` contains proxy hardware solids and is visual-only. Inspect the insert installation, boss cracking, edge distance, screw seating/tool access, keeper flushness, and pad capture. Then measure pullout/retention in representative coupons before any load-bearing trial. No pullout capacity or working load is inferred from the manufacturer fit dimensions. The actual mission contact zones, loads, safe squeeze, pad material, and powered-use gate remain unresolved.
