#!/usr/bin/env python3
"""Inventory the supplied gripper STL and inspect sections near the candidate rod axis."""
from collections import defaultdict
from pathlib import Path
import struct
import math

ROOT = Path(__file__).resolve().parents[1]
STL = ROOT / "Michelangelo Dealberti FInal Clamp Design.stl"
OUT = Path(__file__).with_name("reference_mesh_components.md")
SECTIONS_OUT = Path(__file__).with_name("reference_mesh_axis_sections.md")
AXIS_X, AXIS_Y = -21.3045, -10.2

raw = STL.read_bytes()
if len(raw) < 84:
    raise SystemExit("STL is too short")
count = struct.unpack_from("<I", raw, 80)[0]
if len(raw) != 84 + count * 50:
    raise SystemExit(f"Expected binary STL size {84 + count * 50}, got {len(raw)}")

triangles = []
offset = 84
for _ in range(count):
    values = struct.unpack_from("<12fH", raw, offset)
    triangles.append((values[3:6], values[6:9], values[9:12]))
    offset += 50

parent = list(range(count))
rank = [0] * count
def find(a):
    while parent[a] != a:
        parent[a] = parent[parent[a]]
        a = parent[a]
    return a

def union(a, b):
    a, b = find(a), find(b)
    if a == b:
        return
    if rank[a] < rank[b]:
        a, b = b, a
    parent[b] = a
    if rank[a] == rank[b]:
        rank[a] += 1

vertex_owner = {}
for ti, tri in enumerate(triangles):
    for v in tri:
        key = tuple(round(c * 1000) for c in v)
        previous = vertex_owner.setdefault(key, ti)
        union(ti, previous)

groups = defaultdict(list)
for ti in range(count):
    groups[find(ti)].append(ti)

items = []
for tids in groups.values():
    pts = [p for ti in tids for p in triangles[ti]]
    mins = [min(p[i] for p in pts) for i in range(3)]
    maxs = [max(p[i] for p in pts) for i in range(3)]
    center = [(mins[i] + maxs[i]) / 2 for i in range(3)]
    dx = max(mins[0] - AXIS_X, 0, AXIS_X - maxs[0])
    dy = max(mins[1] - AXIS_Y, 0, AXIS_Y - maxs[1])
    gap = math.hypot(dx, dy)
    items.append({"tris": len(tids), "mins": mins, "maxs": maxs,
                  "center": center, "gap": gap, "tids": tids})
items.sort(key=lambda v: (-v["tris"], v["mins"][2], v["mins"][1], v["mins"][0]))
for cid, item in enumerate(items, 1):
    item["id"] = cid

fmt = lambda v: f"{v:.3f}"
lines = [
    "# Supplied clamp STL: connected-component inventory",
    "",
    f"Source: `{STL.name}` ({len(raw):,} bytes, {count:,} triangles).",
    "Components are joined by shared vertices rounded to 0.001 mm.",
    f"The candidate rod axis used for the proximity column is X={AXIS_X:.4f}, Y={AXIS_Y:.3f} mm.",
    "This table describes geometry only; it does not identify moving/fixed parts or prove a rod.",
    "",
    "| ID | Triangles | X bounds (mm) | Y bounds (mm) | Z bounds (mm) | Center (mm) | XY gap to candidate axis (mm) |",
    "|---:|---:|---:|---:|---:|---:|---:|",
]
for item in items:
    lo, hi, center = item["mins"], item["maxs"], item["center"]
    lines.append(
        f"| {item['id']} | {item['tris']:,} | {fmt(lo[0])}…{fmt(hi[0])} | "
        f"{fmt(lo[1])}…{fmt(hi[1])} | {fmt(lo[2])}…{fmt(hi[2])} | "
        f"({fmt(center[0])}, {fmt(center[1])}, {fmt(center[2])}) | {fmt(item['gap'])} |"
    )
OUT.write_text("\n".join(lines) + "\n", encoding="utf-8")

def slice_radii(tri, z):
    points = []
    for i in range(3):
        a, b = tri[i], tri[(i + 1) % 3]
        za, zb = a[2], b[2]
        if (za <= z < zb) or (zb <= z < za):
            t = (z - za) / (zb - za)
            points.append((a[0] + t * (b[0] - a[0]),
                           a[1] + t * (b[1] - a[1])))
    return [math.hypot(x - AXIS_X, y - AXIS_Y) for x, y in points]

section_zs = list(range(0, 121, 10))
section_lines = [
    "# STL cross-sections near the candidate centerline",
    "",
    "Each cell shows the radial range from X=-21.3045, Y=-10.200 mm to STL triangle intersections with a horizontal Z plane.",
    "A centered rod would produce a small, nearly constant range over consecutive Z slices. These are surface intersections, not feature recognition.",
    "Components are identified by the IDs in [the component inventory](reference_mesh_components.md).",
    "",
    "| Z slice (mm) | Nearby component surfaces and radial ranges (mm) |",
    "|---:|---|",
]
for z in section_zs:
    entries = []
    for item in items:
        if item["mins"][2] > z or item["maxs"][2] < z:
            continue
        if item["gap"] > 15:
            continue
        radii = [r for ti in item["tids"] for r in slice_radii(triangles[ti], z)]
        if not radii:
            continue
        rmin, rmax = min(radii), max(radii)
        if rmin <= 15:
            entries.append(f"ID {item['id']}: {fmt(rmin)}–{fmt(rmax)}")
    section_lines.append(f"| {z} | " + ("; ".join(entries) if entries else "No intersections within 15 mm"))
SECTIONS_OUT.write_text("\n".join(section_lines) + "\n", encoding="utf-8")
print(f"Wrote component inventory and {len(section_zs)} centerline-near sections.")
