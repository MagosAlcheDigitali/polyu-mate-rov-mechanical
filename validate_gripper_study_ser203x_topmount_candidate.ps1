param(
    [string]$OpenSCAD = 'C:\Program Files\OpenSCAD\openscad.exe'
)

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest
$scad = Join-Path $PSScriptRoot 'gripper_study_ser203x_topmount_candidate.scad'
$outputRoot = Join-Path $PSScriptRoot 'gripper_study_ser203x_topmount_candidate_qa'
New-Item -ItemType Directory -Path $outputRoot -Force | Out-Null
if (-not (Test-Path -LiteralPath $OpenSCAD)) { throw "OpenSCAD executable not found: $OpenSCAD" }
if (-not (Test-Path -LiteralPath $scad)) { throw "Integrated candidate CAD source not found: $scad" }

function Invoke-OpenSCAD([string]$Arguments, [string]$OutputFile, [string]$Name) {
    $stdout = Join-Path $outputRoot ($Name + '.stdout.log')
    $stderr = Join-Path $outputRoot ($Name + '.stderr.log')
    Remove-Item -LiteralPath $OutputFile -Force -ErrorAction SilentlyContinue
    Remove-Item -LiteralPath $stdout,$stderr -Force -ErrorAction SilentlyContinue
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
    $empty = $log -match 'Current top level object is empty'
    if ($empty) { $facets = 0 }
    return [pscustomobject]@{
        ExitCode=$process.ExitCode; Log=$log; Facets=$facets
        OutputExists=(Test-Path -LiteralPath $OutputFile); Empty=$empty
    }
}

function Invoke-Compile([string]$View, [string]$Name) {
    $out = Join-Path $outputRoot ($Name + '.csg')
    $viewArg = if ($View -eq 'assembly') { '' } else { '-D "part_view=\"' + $View + '\"" ' }
    $args = '--hardwarnings ' + $viewArg + '-o "' + $out + '" "' + $scad + '"'
    $r = Invoke-OpenSCAD $args $out $Name
    if ($r.ExitCode -ne 0 -or -not $r.OutputExists -or $r.Log -match '(?im)\b(WARNING|ERROR):') {
        throw "$View hard-warning compile failed. Exit=$($r.ExitCode)`n$($r.Log)"
    }
    Write-Output "PASS: $View CSG compile with --hardwarnings."
}

function Invoke-EmptyIntersection([string]$View, [int]$Angle, [string]$Name) {
    $out = Join-Path $outputRoot ($Name + '.stl')
    $args = '-D "part_view=\"' + $View + '\"" -D "jaw_angle_deg=' + $Angle +
        '" --hardwarnings -o "' + $out + '" "' + $scad + '"'
    $r = Invoke-OpenSCAD $args $out $Name
    if ($r.Log -match '(?im)\b(WARNING|ERROR):') {
        throw "$View emitted warning/error at $Angle deg.`n$($r.Log)"
    }
    if ($r.Facets -ne 0) {
        throw "$View has $($r.Facets) intersection facets at $Angle deg; see $out"
    }
    if ($r.ExitCode -ne 0 -and -not $r.Empty) {
        throw "$View failed unexpectedly at $Angle deg. Exit=$($r.ExitCode)`n$($r.Log)"
    }
    Write-Output "PASS: $View is empty at $Angle deg (no modeled volume overlap)."
}

function Invoke-SharedInterfaceReview([int]$Angle, [string]$Name) {
    $out = Join-Path $outputRoot ($Name + '.stl')
    $view = 'ser_mount_stop_yoke_interference'
    $args = '-D "part_view=\"' + $view + '\"" -D "jaw_angle_deg=' + $Angle +
        '" --hardwarnings -o "' + $out + '" "' + $scad + '"'
    $r = Invoke-OpenSCAD $args $out $Name
    if ($r.Log -match '(?im)\b(WARNING|ERROR):') {
        throw "$view emitted warning/error at $Angle deg.`n$($r.Log)"
    }
    if ($r.ExitCode -ne 0 -and -not $r.Empty) {
        throw "$view failed unexpectedly at $Angle deg. Exit=$($r.ExitCode)`n$($r.Log)"
    }
    if ($r.Facets -gt 0) {
        Write-Output "REVIEW: $view has $($r.Facets) facets at $Angle deg; inspect the shared bridge/yoke attachment before accepting."
    } else {
        Write-Output "PASS: $view has no modeled shared volume at $Angle deg."
    }
}

function Invoke-EmptyMeshIntersectionAllowNoVolumeWarning([string]$View, [int]$Angle, [string]$Name) {
    $out = Join-Path $outputRoot ($Name + '.stl')
    $args = '-D "part_view=\"' + $View + '\"" -D "jaw_angle_deg=' + $Angle +
        '" --hardwarnings -o "' + $out + '" "' + $scad + '"'
    $r = Invoke-OpenSCAD $args $out $Name
    if ($r.Facets -ne 0) {
        throw "$View has $($r.Facets) intersection facets at $Angle deg; see $out"
    }
    $unexpectedLog = $r.Log -replace '(?im)^WARNING: Object may not be a valid 2-manifold and may need repair!\r?\n?', ''
    $unexpectedLog = $unexpectedLog -replace '(?im)^EXPORT-WARNING: Exported object may not be a valid 2-manifold and may need repair!?\r?\n?', ''
    if ($unexpectedLog -match '(?im)\b(WARNING|ERROR):') {
        throw "$View emitted an unexpected warning/error at $Angle deg.`n$($r.Log)"
    }
    if ($r.ExitCode -ne 0) {
        throw "$View failed at $Angle deg. Exit=$($r.ExitCode)`n$($r.Log)"
    }
    Write-Output "PASS: $View has no modeled shared volume at $Angle deg (empty intersection export)."
}

Invoke-Compile 'assembly' 'assembly'
Invoke-Compile 'actuator_package' 'actuator-package'

foreach ($angle in @(0,22,44)) {
    Invoke-EmptyIntersection 'ser_case_moving_jaw_interference' $angle ('case-jaw-' + $angle)
    Invoke-SharedInterfaceReview $angle ('mount-stop-yoke-review-' + $angle)
    Invoke-EmptyIntersection 'stop_guard_enclosure_clearance' $angle ('guard-vs-mechanism-' + $angle)
}
Invoke-EmptyIntersection 'ser_case_fixed_structure_interference' 0 'case-fixed-structure-0'
Invoke-EmptyIntersection 'bearing_bracket_frame_interference' 0 'upper-bearing-seat-0'
Invoke-EmptyIntersection 'ser_coupler_guard_interference' 0 'coupler-mount-shield-0'
Invoke-EmptyIntersection 'stop_guard_floor_vs_actuator' 22 'floor-vs-ser-package-22'
Invoke-EmptyMeshIntersectionAllowNoVolumeWarning 'stop_guard_wall_vs_support' 0 'cheek-port-wall-support-0'

Write-Output 'LIMIT: faceted static checks only; they do not verify connector/cable fit, real vendor STEP, structural strength, MECH-008 physical access, tolerances, or vehicle/prop fit.'

