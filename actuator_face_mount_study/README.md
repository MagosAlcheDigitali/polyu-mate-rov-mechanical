# SER front-face mounting pattern coupon

This isolated OpenSCAD study lays out a removable 3 mm plate over the drawing-defined output face of a Blue Trail Engineering SER-203x/SER-213x dimensional proxy. It is only a way to inspect the hole pattern, center opening, plate margins, and relative package shape. It does not provide a connection to the gripper yoke, vehicle frame, or hard-stop load path.

## Drawing dimensions represented

- Case: 70 x 32 x 67 mm
- Raised output feature: Ø24 x 5.1 mm
- Output shaft: Ø6 x 8 mm
- Four top holes: Ø2.9 x 16 mm deep, 35 x 22 mm pattern

The complete vendor STEP remains required to confirm the face datum, hole/thread specification, shaft/hub interface, connector, side holes, and cable exit.

## Coupon choices to verify

- Plate: 78 x 40 x 3 mm
- Central clearance: Ø26 mm around the nominal Ø24 mm raised feature
- Four through holes: Ø4.0 mm, provisional for a #6/M3.5 fastener
- Screw proxy: Ø3.0 mm shank and Ø6.5 x 2 mm head, purely visual

All plate/screw choices are provisional and must be checked against the actual actuator, fasteners, printer/material, and required service cycles. No load rating, thread engagement approval, actuator selection, or fabrication release is claimed.

## OpenSCAD use

Open ser_face_mount_coupon.scad. The part_view selector can be assembly, plate_only, or pattern_check. The plate-only STL is a single plate geometry suitable for an unpowered pattern/fit trial after the team obtains the actual servo. The combined assembly view intentionally contains separate bodies and is for visual comparison only.

## Verification

OpenSCAD 2021.01 compiled the assembly, plate_only STL, and pattern_check views with --hardwarnings and zero warnings. The plate_only STL contains 3,936 parsed ASCII STL vertices and has measured bounds of 78 x 40 x 3 mm. The assembly preview was rendered at 1280 x 900 and visually checked. These checks confirm only the drawing-pattern study geometry; they do not confirm vendor STEP fit, fastener specification, structural attachment, or load capacity.