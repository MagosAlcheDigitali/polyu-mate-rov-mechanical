param(
    [string]$OpenSCAD = 'C:\Program Files\OpenSCAD\openscad.exe'
)

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest
$scad = Join-Path $PSScriptRoot 'gripper_study_stop_guard_enclosure_candidate.scad'
$outputRoot = Join-Path $PSScriptRoot 'gripper_study_stop_guard_enclosure_candidate_qa'
$script:intersections = @()
$script:openScadIssues = @()
if (-not (Test-Path -LiteralPath $OpenSCAD)) { throw "OpenSCAD executable not found: $OpenSCAD" }
if (-not (Test-Path -LiteralPath $scad)) { throw "Guard candidate CAD source not found: $scad" }
New-Item -ItemType Directory -Path $outputRoot -Force | Out-Null

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
    return [pscustomobject]@{ ExitCode=$process.ExitCode; Log=$log; Facets=$facets; OutputExists=(Test-Path -LiteralPath $OutputFile) }
}

function Test-EmptyIntersection([string]$View, [int]$Angle, [string]$Name) {
    $mesh = Join-Path $outputRoot ($Name + '.stl')
    $angleText = $Angle.ToString([Globalization.CultureInfo]::InvariantCulture)
    $args = '-D "part_view=\"' + $View + '\"" -D "jaw_angle_deg=' + $angleText +
        '" -o "' + $mesh + '" "' + $scad + '" --hardwarnings'
    $result = Invoke-OpenSCAD $args $mesh $Name
    if ($result.Facets -ne 0) {
        $script:intersections += [pscustomobject]@{ View=$View; Angle=$Angle; Facets=$result.Facets; Mesh=$mesh }
        Write-Output "FAIL: $View has $($result.Facets) intersection facets at jaw angle $Angle deg; see $mesh"
    } else {
        Write-Output "PASS: $View is empty at jaw angle $Angle deg (no modeled overlap)."
    }
    if ($result.Log -match '(?im)\b(WARNING|ERROR):') {
        $script:openScadIssues += [pscustomobject]@{ Name=$Name; Message='OpenSCAD warning/error; see retained log' }
        Write-Output "WARN: OpenSCAD emitted warning/error for $View at $Angle deg; see $Name.stderr.log"
    }
    if ($result.ExitCode -ne 0 -and $result.Log -notmatch 'Current top level object is empty') {
        $script:openScadIssues += [pscustomobject]@{ Name=$Name; Message="unexpected exit $($result.ExitCode)" }
        Write-Output "WARN: unexpected OpenSCAD exit $($result.ExitCode) for $View at $Angle deg; see $Name logs"
    }
}

foreach ($view in @('assembly','stop_guard_enclosure_only')) {
    $csg = Join-Path $outputRoot ($view + '.csg')
    $viewDefine = if ($view -eq 'assembly') { '' } else { '-D "part_view=\"' + $view + '\"" ' }
    $args = '--hardwarnings ' + $viewDefine + '-o "' + $csg + '" "' + $scad + '"'
    $result = Invoke-OpenSCAD $args $csg ($view + '-compile')
    if ($result.ExitCode -ne 0 -or -not $result.OutputExists -or
        $result.Log -match '(?im)\b(WARNING|ERROR):') {
        throw "$view compile failed or emitted warning/error output. Exit=$($result.ExitCode)`n$($result.Log)"
    }
    Write-Output "PASS: $view CSG compile with --hardwarnings."
}

# Preserve individual static checks to identify any residual collision source.
foreach ($view in @('stop_guard_floor_vs_support','stop_guard_floor_vs_bearing',
                    'stop_guard_floor_vs_actuator','stop_guard_floor_vs_bridge',
                    'stop_guard_floor_vs_shaft')) {
    Test-EmptyIntersection $view 0 ($view + '-0')
}
Test-EmptyIntersection 'stop_guard_floor_structure_clearance' 0 'floor-vs-support-all'
Test-EmptyIntersection 'stop_guard_shell_floor_clearance' 0 'shell-vs-floor'
Test-EmptyIntersection 'stop_guard_wall_vs_support' 0 'wall-vs-support'
# Enclosure including the split floor against all moving/fixed stop mechanisms.
foreach ($angle in @(0,5,10,15,20,22,25,30,35,40,44)) {
    Test-EmptyIntersection 'stop_guard_enclosure_clearance' $angle ("guard-vs-mechanism-{0}" -f $angle)
}

# Export each guard component selector as a nonempty STL. These are geometry
# exports only; self-tapped screw strength and physical assembly remain
# unverified in the companion review.
$printViews = @('stop_guard_shell_print','stop_guard_floor_left_print',
                'stop_guard_floor_right_print','stop_guard_lid_print',
                'stop_guard_hardware_proxy')
foreach ($view in $printViews) {
    $mesh = Join-Path $outputRoot ($view + '.stl')
    $args = '-D "part_view=\"' + $view + '\"" -o "' + $mesh +
        '" "' + $scad + '" --hardwarnings'
    $result = Invoke-OpenSCAD $args $mesh $view
    if ($result.ExitCode -ne 0 -or -not $result.OutputExists -or
        $result.Facets -le 0 -or $result.Log -match '(?im)\b(WARNING|ERROR):') {
        throw "$view STL export failed or was empty. Exit=$($result.ExitCode); facets=$($result.Facets)`n$($result.Log)"
    }
    Write-Output "PASS: $view exported to STL ($($result.Facets) facets)."
}

# Export OpenSCAD's actual preview for the complete assembly and isolated guard.
foreach ($view in @('assembly','stop_guard_enclosure_only')) {
    $png = Join-Path $outputRoot ($view + '-openscad-preview.png')
    $viewDefine = if ($view -eq 'assembly') { '' } else { '-D "part_view=\"' + $view + '\"" ' }
    $args = '--hardwarnings --autocenter --viewall --imgsize=1280,900 ' + $viewDefine +
        '-o "' + $png + '" "' + $scad + '"'
    $result = Invoke-OpenSCAD $args $png ($view + '-png')
    if ($result.ExitCode -ne 0 -or -not $result.OutputExists -or
        $result.Log -match '(?im)\b(WARNING|ERROR):') {
        throw "$view OpenSCAD PNG export failed. Exit=$($result.ExitCode)`n$($result.Log)"
    }
    Write-Output "PASS: wrote OpenSCAD preview $png"
}

Write-Output "Raw CSG, STL intersection checks, PNG previews, and logs retained in: $outputRoot"
Write-Output 'Scope: nominal static geometry checks only; no tolerance robustness, load, material, IP-20 inspection, or fabrication pass.'

if ($script:intersections.Count -gt 0 -or $script:openScadIssues.Count -gt 0) {
    $hits = ($script:intersections | ForEach-Object { "$($_.View)@$($_.Angle)=$($_.Facets) facets" }) -join '; '
    $issues = ($script:openScadIssues | ForEach-Object { "$($_.Name): $($_.Message)" }) -join '; '
    throw "Validation has overlaps/issues. Intersections: $hits. OpenSCAD issues: $issues. Raw outputs retained in $outputRoot"
}
