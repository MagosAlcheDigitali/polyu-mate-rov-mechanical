param(
    [string]$OpenSCAD = 'C:\Program Files\OpenSCAD\openscad.exe'
)

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest

$scad = Join-Path $PSScriptRoot 'powered_stop_integrated_candidate.scad'
if (-not (Test-Path -LiteralPath $OpenSCAD)) { throw "OpenSCAD executable not found: $OpenSCAD" }
if (-not (Test-Path -LiteralPath $scad)) { throw "Candidate CAD source not found: $scad" }

$temp = Join-Path ([IO.Path]::GetTempPath()) ('mate-stop-check-' + [guid]::NewGuid().ToString('N'))
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
    Remove-Item -LiteralPath $stdout,$stderr -ErrorAction SilentlyContinue
    return [pscustomobject]@{ ExitCode = $process.ExitCode; Log = $log; Facets = $facets }
}

try {
    $csg = Join-Path $temp 'powered_stop_integrated_candidate.csg'
    $compileArgs = '--hardwarnings -o "' + $csg + '" "' + $scad + '"'
    $compile = Invoke-OpenSCAD $compileArgs $csg
    if ($compile.ExitCode -ne 0 -or -not (Test-Path -LiteralPath $csg) -or
        $compile.Log -match '(?im)\b(WARNING|ERROR):') {
        throw "Candidate compile failed or emitted a warning/error. Exit=$($compile.ExitCode)`n$($compile.Log)"
    }
    Write-Output 'PASS: integrated stop candidate compiles with --hardwarnings and no warning/error output.'

    foreach ($view in @('sector_plate_fork_overlap','sector_fork_overlap','bridge_fork_overlap','fork_shaft_overlap')) {
        $angles = if ($view -eq 'fork_shaft_overlap') { @(0,44) } else { @(0,22,44) }
        foreach ($angle in $angles) {
            $mesh = Join-Path $temp ($view + '-' + $angle + '.stl')
            $angleText = $angle.ToString([Globalization.CultureInfo]::InvariantCulture)
            $viewArgs = '-D "part_view=\"' + $view + '\"" -D "jaw_angle_deg=' + $angleText +
                '" -o "' + $mesh + '" "' + $scad + '" --hardwarnings'
            $result = Invoke-OpenSCAD $viewArgs $mesh
            if ($result.Facets -ne 0) {
                throw "$view is non-empty at jaw angle $angle degrees ($($result.Facets) facets)."
            }
            if ($result.Log -match '(?im)\b(WARNING|ERROR):') {
                throw "OpenSCAD warning/error for $view at $angle degrees:`n$($result.Log)"
            }
            if ($result.ExitCode -ne 0 -and $result.Log -notmatch 'Current top level object is empty') {
                throw "Unexpected OpenSCAD failure for $view at $angle degrees: exit $($result.ExitCode)`n$($result.Log)"
            }
        }
    }
    Write-Output 'PASS: sector plate/fork, fixed-stop/fork, and bridge/fork intersections are empty at 0, 22 and 44 degrees; fork/shaft is empty at 0 and 44 degrees.'
    Write-Output 'Scope: sampled static geometry only. Analytic block placement targets tangency at commanded endpoints; contact repeatability, continuous motion, shaft loads, material strength, guard inspection and vehicle fit remain unverified.'
} finally {
    Remove-Item -LiteralPath $temp -Recurse -Force -ErrorAction SilentlyContinue
}

