param(
    [string]$OpenSCAD = 'C:\Program Files\OpenSCAD\openscad.exe'
)

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest

$scad = Join-Path $PSScriptRoot 'gripper_study_stop_jointed_candidate.scad'
if (-not (Test-Path -LiteralPath $OpenSCAD)) { throw "OpenSCAD executable not found: $OpenSCAD" }
if (-not (Test-Path -LiteralPath $scad)) { throw "Jointed candidate CAD source not found: $scad" }

$temp = Join-Path ([IO.Path]::GetTempPath()) ('mate-jointed-stop-check-' + [guid]::NewGuid().ToString('N'))
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
        }
    }
    return [pscustomobject]@{ ExitCode = $process.ExitCode; Log = $log; Facets = $facets }
}

try {
    foreach ($view in @('assembly','actuator_dshaft_coupler')) {
        $csg = Join-Path $temp ($view + '.csg')
        $viewDefine = if ($view -eq 'assembly') { '' } else { '-D "part_view=\"' + $view + '\"" ' }
        $args = '--hardwarnings ' + $viewDefine + '-o "' + $csg + '" "' + $scad + '"'
        $result = Invoke-OpenSCAD $args $csg
        if ($result.ExitCode -ne 0 -or -not (Test-Path -LiteralPath $csg) -or
            $result.Log -match '(?im)\b(WARNING|ERROR):') {
            throw "$view compile failed or emitted warning/error output. Exit=$($result.ExitCode)`n$($result.Log)"
        }
    }
    Write-Output 'PASS: full assembly and optional D-shaft coupler compile with --hardwarnings and no warning/error output.'

    $views = @(
        'stop_sector_fork_overlap',
        'stop_bridge_fork_overlap',
        'stop_bridge_plate_fork_overlap',
        'stop_guard_overlap',
        'rotating_stop_bridge_fasteners_overlap',
        'rotating_stop_post_fasteners_overlap',
        'rotating_stop_block_fasteners_overlap'
    )
    foreach ($view in $views) {
        foreach ($angle in @(0,22,44)) {
            $mesh = Join-Path $temp ($view + '-' + $angle + '.stl')
            $angleText = $angle.ToString([Globalization.CultureInfo]::InvariantCulture)
            $args = '-D "part_view=\"' + $view + '\"" -D "jaw_angle_deg=' + $angleText +
                '" -o "' + $mesh + '" "' + $scad + '" --hardwarnings'
            $result = Invoke-OpenSCAD $args $mesh
            if ($result.Facets -ne 0) {
                throw "$view intersects at jaw angle $angle degrees ($($result.Facets) facets)."
            }
            if ($result.Log -match '(?im)\b(WARNING|ERROR):') {
                throw "OpenSCAD warning/error for $view at $angle degrees:`n$($result.Log)"
            }
            if ($result.ExitCode -ne 0 -and $result.Log -notmatch 'Current top level object is empty') {
                throw "Unexpected OpenSCAD failure for $view at $angle degrees: exit $($result.ExitCode)`n$($result.Log)"
            }
        }
    }
    Write-Output 'PASS: all seven sampled stop/fork/bridge/guard and rotating-stop/fastener intersections are empty at 0, 22 and 44 degrees.'
    Write-Output 'Scope: static geometry only. This does not prove stop contact, tolerance robustness, joint strength, guard access, actuator suitability, or vehicle fit.'
} finally {
    Remove-Item -LiteralPath $temp -Recurse -Force -ErrorAction SilentlyContinue
}

