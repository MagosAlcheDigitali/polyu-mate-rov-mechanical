#!/usr/bin/env python3
"""Inventory connected components in the supplied simple-gripper STL.

Uses only Python's standard library. This reports geometry, not part identity or
motion semantics.
"""
from collections import defaultdict
from pathlib import Path
import struct

ROOT = Path(__file__).resolve().parents[1]
STL = ROOT / "Michelangelo Dealberti FInal Clamp Design.stl"
OUT = Path(__file__).with_name("reference_mesh_components.md")
ROD_X, ROD_Y = -21.3045, -10.2

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
    dx = max(mins[0] - ROD_X, 0, ROD_X - maxs[0])
    dy = max(mins[1] - ROD_Y, 0, ROD_Y - maxs[1])
    radial_gap = (dx * dx + dy * dy) ** 0.5
    items.append((len(tids), mins, maxs, center, radial_gap))
items.sort(key=lambda v: (-v[0], v[1][2], v[1][1], v[1][0]))

lines = [
    "# Supplied clamp STL: connected-component inventory",
    "",
    f"Source: `{STL.name}` ({len(raw):,} bytes, {count:,} triangles).",
    "Components are joined by shared vertices rounded to 0.001 mm.",
    "The candidate rod axis used for the proximity column is X=-21.3045, Y=-10.200 mm.",
    "This table describes geometry only; it does not identify moving/fixed parts or prove a rod.",
    "",
    "| ID | Triangles | X bounds (mm) | Y bounds (mm) | Z bounds (mm) | Center (mm) | XY gap to candidate axis (mm) |",
    "|---:|---:|---:|---:|---:|---:|---:|",
]
for idx, (n, lo, hi, center, gap) in enumerate(items, 1):
    fmt = lambda v: f"{v:.3f}"
    lines.append(
        f"| {idx} | {n:,} | {fmt(lo[0])}…{fmt(hi[0])} | "
        f"{fmt(lo[1])}…{fmt(hi[1])} | {fmt(lo[2])}…{fmt(hi[2])} | "
        f"({fmt(center[0])}, {fmt(center[1])}, {fmt(center[2])}) | {fmt(gap)} |"
    )
lines.append("")
OUT.write_text("\n".join(lines), encoding="utf-8")
print(f"Wrote {OUT.relative_to(ROOT)} with {len(items)} components.")
