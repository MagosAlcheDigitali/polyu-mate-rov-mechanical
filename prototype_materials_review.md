# Replaceable Contact-Pad Materials and Retention Review

**Scope:** Contact-pad material and retention module only. This review does not select a final grip force, actuator, or mission-qualified material.  
**Status:** Candidate screening for prototypes; wet performance and sample-safe squeeze remain unmeasured.

## Design basis from the current files

The coupon notes define unpowered profile samples and pair gaps for fit/contact comparisons. They explicitly leave polymer, hardness, print orientation, infill, durability, and wet friction unvalidated. The OpenSCAD source uses a nominal `9 × 24 × 14 mm` insert with round-channel, V-channel, or flat contact; keeper strips cover the top and bottom pad edges and short end fences capture the long pad's ends. Four M3-proxy fasteners attach each set of keepers. The coupon STL files omit the jaw backing and retainers, so they cannot establish retention strength.

Published 2027 task actions include carrying/handling a seagrass sample, gripping or transporting objects such as a trap, dropped tool, panel, and antenna, and controlled connector work. The briefing does not publish a safe plant contact zone or permitted squeeze, object interfaces, underwater pull loads, or connector forces. The supplied Floats Preview concerns the separate profiling-float task and provides no ROV-gripper pad specification. Treat the actual practice props and allowed contact zones as prerequisites for final selection.

## Candidate shortlist

| Candidate | Suggested stage | Why it is useful | Limits / decision gate |
|---|---|---|---|
| Existing easy-print rigid coupons (e.g. the team's ordinary prototype filament) | **Unpowered fit coupons only** | Fast way to compare round, V, flat, and asymmetric profiles; isolates geometry before material softness complicates observations. | Not a compliant or wet-grip proxy. Keep force low; do not install as a powered contact insert or infer friction from dry handling. |
| FDM TPU 95A from a documented filament lot | **Unpowered fit coupons; then passive wet screening only if it fits the keeper pocket without damage** | Reproducible, directly printable insert candidate for a quick shape/material comparison. Bambu Lab's product guide lists TPU 95A HF as a filament option, but the guide's comparative values do not establish wet friction, grip safety, or performance of a particular print. [Manufacturer filament guide](https://cdn1.bambulab.com/filament/filament-guide/wksdyyzd8n9/filament-guide-en.pdf) | Treat hardness and properties as specific to the selected product/lot and print process; record orientation, walls, infill, and moisture/storage state. Its 95A designation should not be assumed gentle enough for plant contact. No powered use until measured compression, tear/retention, and loaded wet tests. |
| Cast addition-cure silicone, initially Shore A 20 class | **Passive wet contact/damage trials; a later powered candidate only after retention and load tests** | A soft elastomer comparison for broad pressure distribution and cushioning. Smooth-On's Dragon Skin 20 NV bulletin reports Shore A 20, 672% elongation at break, and Die B tear strength 138 pli under its stated test conditions; these are bulk-material data, not pad grip or mission-performance data. [Manufacturer technical bulletin](https://www.smooth-on.com/tb/files/DRAGON_SKIN_20_NV_TB.pdf) | Requires careful mixing/cure and a mold; cured silicone must be checked for keeper fit, surface defects, tearing, and water conditioning. These properties do not prove high wet friction, plant safety, or load capacity. Consult the current bulletin/SDS and follow its preparation and handling directions. |
| Commercial EPDM sheet or molded rubber insert, with supplier grade/hardness documented | **Passive wet screening after fitting to the insert shape** | Practical comparison against cast silicone and TPU when the team can source a known grade and mechanically capture it. Supplier data should identify the exact formulation; generic “EPDM” is not a material specification. | The manufacturer source cited here describes EPDM sheeting use, not gripper friction or allowable contact pressure. Do not claim seawater compatibility or performance for an unverified grade based on the polymer name alone. No powered use without wet load/retention and contact-damage checks. [Trelleborg EPDM product information](https://www.trelleborg.com/en/fluidhandling/products-and-solutions/rubber-sheeting-and-matting/sheeting/epdm) |

**Practical first comparison:** retain the current profile geometry and make one coupon pair per profile from rigid prototype material to select shape. Then make otherwise identical passive trial pairs in the available documented TPU and one documented soft elastomer (cast silicone or sourced EPDM sheet). This avoids a costly mold/sourcing commitment before the team knows which contact geometry fits the props. Do not claim that any listed material is selected until the tests below are complete.

## Retention and load-path recommendations

1. Keep the insert a replaceable wear/contact element. The jaw body and its backing must carry actuator force and object loads; do not use the elastomer itself as the structural jaw, hinge, or fastener substrate.
2. Retain pads mechanically with the existing keeper strips, end fences, and fasteners. Adhesive may be considered only as a secondary anti-rattle aid after compatibility checks; it is not the primary retention method.
3. Check the actual printed/machined tolerance stack: insert seats fully, keepers sit flat, fasteners do not protrude into the contact zone, and neither keeper nor insert can be pulled out toward the jaw opening. Add drain/flush paths where the keeper geometry could trap sediment or water.
4. Reinspect keeper and insert after each wet cycle. Check edge extrusion, permanent set, cuts, debonding, screw loosening, and hard edges exposed by wear. A pad failure must not release a hazardous fastener or leave a sharp jaw surface.
5. For delicate biological samples, only test at an officially allowed grasp zone and use a non-living surrogate first. Softness alone does not establish harmlessness.

## Staged test plan

### A. Unpowered fit coupons

- Use the coupon notes' round, V, flat, and asymmetric flat/V profiles against measured, dimensionally faithful practice props.
- Record prop feature dimensions, profile, material, insertion/release effort, alignment tolerance, snagging, slip direction, and visible marking at a fixed low hand-applied force. Keep this as qualitative geometry screening, not a force rating.
- Reject profiles that trap the prop, obstruct release, present sharp edges, or require contact outside the allowed zone. Update the CAD dimensions only from measured interfaces.

### B. Passive wet trials (no actuator / no powered clamp)

- Compare the shortlisted candidate materials with matched profile and dimensions. Soak/rinse in the intended test water, then repeat controlled pull directions with a spring scale or force gauge and the same surrogate. Record water condition, soak time, force at first slip, pad compression, and surface damage.
- Repeat enough cycles to reveal pad migration, tearing, swelling, permanent set, residue, and keeper wear; document sample count rather than treating one trial as qualification.
- For plant interaction, use a compliant surrogate until the organizer/team has confirmed the permissible sample grasp zone. Do not use live foliage in early trials.

### C. Load-bearing powered-part gate

- Only after the team establishes expected submerged object load, approach/pull directions, control/force limit, and allowed sample compression, install a candidate in the complete mechanically retained jaw.
- Instrument or otherwise measure jaw force and displacement. Verify pad retention and jaw structure under the planned maximum operating load and a team-defined proof margin; include repeated wet cycles and recovery/release. Inspect screw/keeper loosening and pad extrusion.
- Set a conservative force/closing limit from measured safe-contact evidence. If safe squeeze or required holding load is unknown, remain at passive wet trials; do not represent the powered assembly as qualified for mission use.

## Manufacturer references

- Smooth-On, [Dragon Skin 20 NV Technical Bulletin](https://www.smooth-on.com/tb/files/DRAGON_SKIN_20_NV_TB.pdf) — material test values and the manufacturer's processing/safety instructions.
- Bambu Lab, [Filament Guide](https://cdn1.bambulab.com/filament/filament-guide/wksdyyzd8n9/filament-guide-en.pdf) — TPU 95A HF product family reference; consult the exact filament product page/TDS for the team's selected product.
- Trelleborg, [EPDM sheeting product information](https://www.trelleborg.com/en/fluidhandling/products-and-solutions/rubber-sheeting-and-matting/sheeting/epdm) — product-family overview; obtain the supplier's grade-specific technical sheet before assigning material properties.

**Conclusion:** Keep the current insert and keeper concept as a replaceable, mechanically captured pad system. Use rigid coupons for unpowered geometric fit, then compare documented TPU and a soft cast/sourced elastomer in passive wet trials. No material, profile, retention strength, safe squeeze, or powered jaw is mission-qualified by this review.
