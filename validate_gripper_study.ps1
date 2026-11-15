param(
    [string]$OpenSCAD = 'C:\Program Files\OpenSCAD\openscad.exe'
)

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest

$scad = Join-Path $PSScriptRoot 'gripper_study.scad'
if (-not (Test-Path -LiteralPath $OpenSCAD)) { throw "OpenSCAD executable not found: $OpenSCAD" }
if (-not (Test-Path -LiteralPath $scad)) { throw "CAD source not found: $scad" }

$temp = Join-Path ([IO.Path]::GetTempPath()) ('mate-gripper-check-' + [guid]::NewGuid().ToString('N'))
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
            $binaryCount = [BitConverter]::ToUInt32($bytes, 80)
            if ($bytes.Length -eq (84 + [int64]$binaryCount * 50)) {
                $facets = [int]$binaryCount
            } else {
                $text = [Text.Encoding]::ASCII.GetString($bytes)
                $facets = [regex]::Matches($text, '(?m)^\s*facet\s+normal\b').Count
            }
        } else {
            $facets = 0
        }
    }
    Remove-Item -LiteralPath $stdout,$stderr -ErrorAction SilentlyContinue
    return [pscustomobject]@{ ExitCode = $process.ExitCode; Log = $log; Facets = $facets }
}

try {
    $csg = Join-Path $temp 'gripper_study.csg'
    $compileArgs = '-o "' + $csg + '" --hardwarnings "' + $scad + '"'
    $compile = Invoke-OpenSCAD $compileArgs $csg
    if ($compile.ExitCode -ne 0 -or -not (Test-Path -LiteralPath $csg) -or
        $compile.Log -match '(?im)\b(WARNING|ERROR):') {
        throw "Main CAD compile failed or emitted a warning/error. Exit=$($compile.ExitCode)`n$($compile.Log)"
    }
    Write-Output 'PASS: main CAD compiles with --hardwarnings and no warning/error output.'

    $angles = @(0..44 | ForEach-Object { [double]$_ }) + @(45.456)
    $index = 0
    foreach ($angle in $angles) {
        $index++
        $mesh = Join-Path $temp 'jaw_frame_overlap.stl'
        $angleText = $angle.ToString([Globalization.CultureInfo]::InvariantCulture)
        $args = '-D "part_view=\"jaw_frame_overlap\"" -D "jaw_angle_deg=' + $angleText + '"' +
                ' -o "' + $mesh + '" --hardwarnings "' + $scad + '"'
        $result = Invoke-OpenSCAD $args $mesh
        if ($result.Facets -ne 0) {
            throw "Jaw body intersects support frame at $angle degrees ($($result.Facets) facets)."
        }
        if ($result.Log -match '(?im)\b(WARNING|ERROR):') {
            throw "OpenSCAD warning/error at $angle degrees:`n$($result.Log)"
        }
        if ($result.ExitCode -ne 0 -and $result.Log -notmatch 'Current top level object is empty') {
            throw "Unexpected OpenSCAD failure at $angle degrees: exit $($result.ExitCode)`n$($result.Log)"
        }
        Remove-Item -LiteralPath $mesh -ErrorAction SilentlyContinue
        if (($index % 10) -eq 0 -or $index -eq $angles.Count) {
            Write-Output "Checked $index/$($angles.Count) poses."
        }
    }
    Write-Output 'PASS: jaw-body/support-frame intersection is empty at 46 sampled poses (0–44 degrees and 45.456-degree hard stop).'
    Write-Output 'Scope: this does not validate the pads, stops, actuator, guard, vehicle, tolerances, or continuous motion.'
} finally {
    Remove-Item -LiteralPath $temp -Recurse -Force -ErrorAction SilentlyContinue
}
