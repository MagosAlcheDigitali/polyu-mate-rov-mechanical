# Mesh recovery bundle

The GitHub upload integration silently truncated three oversized STL blobs. Their complete original files are stored here in a ZIP split into 180,000-byte chunks. All other STL files are directly downloadable from the repository.

Bundle SHA-256: a9cbb6855c4a573a608743be6ba367e64f7c3f97a2f2a793bba56e49e9a2c473

From the repository root, concatenate and extract the bundle:

```powershell
$parts = Get-ChildItem mesh_bundle/mesh_bundle.zip.part* | Sort-Object Name
$out = [IO.File]::Create((Join-Path $env:TEMP 'mate_mesh_bundle.zip'))
try { foreach ($part in $parts) { $stream = $part.OpenRead(); try { $stream.CopyTo($out) } finally { $stream.Dispose() } } } finally { $out.Dispose() }
Get-FileHash (Join-Path $env:TEMP 'mate_mesh_bundle.zip') -Algorithm SHA256
Expand-Archive (Join-Path $env:TEMP 'mate_mesh_bundle.zip') -DestinationPath .\restored_meshes
```

The archive restores these original relative paths:
- `gripper_assembly_preview.stl`
- `gripper_toolonly_preview.stl`
- `prototype_meshes/moving_jaw_body.stl`