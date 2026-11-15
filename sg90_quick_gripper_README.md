# SG90 Quick Gripper

A deliberately simple two-finger concept: one fixed finger and one finger directly driven by an SG90 servo horn. Units are millimetres.

## Files

- `sg90_quick_gripper_base.stl` — print once; includes the base, fixed finger, and SG90 cradle.
- `sg90_quick_gripper_moving_jaw.stl` — print once; attach to the SG90 single-arm horn using its center screw and two small horn screws.
- `sg90_quick_gripper_open_assembly.stl` / `sg90_quick_gripper_closed_assembly.stl` — visual assembled poses; do not print these as one part.
- `sg90_quick_gripper.scad` — editable source; set `part` to `base` or `moving_jaw` to export an individual part.

## Basic assembly

1. Seat an SG90 in the cradle with its output spline facing up and horn axis at the forward end of the cradle.
2. Fasten the servo ears to the cradle tabs with M2 screws; attach the base to your robot with four M4 screws.
3. Before fitting the moving jaw, command the servo to its midpoint. Put the horn and jaw on the spline in the desired neutral pose, then secure them with the horn's center screw and the two M2 holes. The 8 mm screw spacing is a nominal pattern; check your supplied horn before printing or enlarge/reposition the two small holes in the SCAD file.
4. Use a servo tester or controller to set travel. The model's illustrative open and closed poses differ by 20 degrees; do not drive the servo into its end stops.
5. Add soft grip pads to the two finger faces if needed. Print the base and jaw flat, with the jaw's hub on the bed; use 3+ walls and 30% infill as a reasonable first prototype.

The opening depends on the jaw angle and is asymmetric because one finger is fixed. The SG90 should grip light objects only. Confirm fit against your actual servo, horn, object, and print tolerances before relying on it.

