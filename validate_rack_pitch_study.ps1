param(
    [string]$OpenSCAD = 'C:\Program Files\OpenSCAD\openscad.exe'
)

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest
$scad = Join-Path $PSScriptRoot 'simple_gripper/rack_and_pinion_pitch_layout.scad'
if (-not (Test-Path -LiteralPath $OpenSCAD)) { throw "OpenSCAD executable not found: $OpenSCAD" }
if (-not (Test-Path -LiteralPath $scad)) { throw "CAD source not found: $scad" }
$temp = Join-Path ([IO.Path]::GetTempPath()) ('mate-rack-check-' + [guid]::NewGuid().ToString('N'))
New-Item -ItemType Directory -Path $temp | Out-Null

function Invoke-OpenSCAD([string]$Arguments, [string]$OutputFile) {
    $stdout = Join-Path $temp 'openscad.stdout'
    $stderr = Join-Path $temp 'openscad.stderr'
    $process = Start-Process -FilePath $OpenSCAD -ArgumentList $Arguments -Wait -PassThru `
        -WindowStyle Hidden -RedirectStandardOutput $stdout -RedirectStandardError $stderr
    $log = ''
    if (Test-Path -LiteralPath $stdout) { $log += [IO.File]::ReadAllText($stdout) }
    if (Test-Path -LiteralPath $stderr) { $log += [IO.File]::ReadAllText($stderr) }
    $facets = 0
    if (Test-Path -LiteralPath $OutputFile) {
        $bytes = [IO.File]::ReadAllBytes($OutputFile)
        if ($bytes.Length -ge 84) {
            $binaryCount = [BitConverter]::ToUInt32($bytes,80)
            if ($bytes.Length -eq (84 + [int64]$binaryCount * 50)) {
                $facets = [int]$binaryCount
            } else {
                $text = [Text.Encoding]::ASCII.GetString($bytes)
                $facets = [regex]::Matches($text, '(?m)^\s*facet\s+normal\b').Count
            }
        }
    }
    Remove-Item -LiteralPath $stdout,$stderr -ErrorAction SilentlyContinue
    return [pscustomobject]@{ ExitCode=$process.ExitCode; Log=$log; Facets=$facets }
}

try {
    $csg = Join-Path $temp 'rack_pitch.csg'
    $compileArgs = '-o "' + $csg + '" --hardwarnings "' + $scad + '"'
    $compile = Invoke-OpenSCAD $compileArgs $csg
    if ($compile.ExitCode -ne 0 -or -not (Test-Path -LiteralPath $csg) -or
        $compile.Log -match '(?im)\b(WARNING|ERROR):') {
        throw "Rack/pitch CAD compile failed or emitted warnings/errors. Exit=$($compile.ExitCode)`n$($compile.Log)"
    }
    Write-Output 'PASS: rack/pitch CAD compiles with --hardwarnings and no warning/error output.'

    $views = @('rack_guide_overlap','rack_pinion_overlap')
    $travels = @(-20,0,20)
    $total = 0
    foreach ($view in $views) {
        foreach ($travel in $travels) {
            $total++
            $stl = Join-Path $temp 'intersection.stl'
            $args = '-D "part_view=\"' + $view + '\"" -D "rack_travel_mm=' + $travel + '"' +
                    ' -o "' + $stl + '" --hardwarnings "' + $scad + '"'
            $result = Invoke-OpenSCAD $args $stl
            if ($result.Facets -ne 0) { throw "$view intersects at rack travel $travel mm ($($result.Facets) facets)." }
            if ($result.Log -match '(?im)\b(WARNING|ERROR):') { throw "OpenSCAD warning/error for $view at $travel mm:`n$($result.Log)" }
            if ($result.ExitCode -ne 0 -and $result.Log -notmatch 'Current top level object is empty') {
                throw "Unexpected OpenSCAD failure for $view at $travel mm: exit $($result.ExitCode)`n$($result.Log)"
            }
            Remove-Item -LiteralPath $stl -ErrorAction SilentlyContinue
            Write-Output "PASS: $view is empty at rack travel $travel mm."
        }
    }
    Write-Output "PASS: $total guide/pinion and guide/rack intersection checks passed."
    Write-Output 'Scope: no clamp-rod, clamp motion, pitch linkage, servo interface, strength, or vehicle fit is validated.'
} finally {
    Remove-Item -LiteralPath $temp -Recurse -Force -ErrorAction SilentlyContinue
}
