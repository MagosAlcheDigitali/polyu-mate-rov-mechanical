param(
    [string]$OpenSCAD = 'C:\Program Files\OpenSCAD\openscad.exe',
    [string]$StyleList = 'captive_nut,heat_set_insert',
    [string]$AngleList = '0,5,10,15,20,22,25,30,35,40,44',
    [string]$CheckList = 'floor,shell,guard',
    [switch]$ExportComponents
)

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest
$Styles = @($StyleList -split ',' | ForEach-Object { $_.Trim() } | Where-Object { $_ })
$Angles = @($AngleList -split ',' | ForEach-Object { [int]$_.Trim() })
$Checks = @($CheckList -split ',' | ForEach-Object { $_.Trim().ToLowerInvariant() } | Where-Object { $_ })
$scad = Join-Path $PSScriptRoot 'gripper_study_stop_guard_enclosure_candidate.scad'
$outputRoot = Join-Path $PSScriptRoot 'guard_fastener_variant_qa'
if (-not (Test-Path -LiteralPath $OpenSCAD)) { throw "OpenSCAD executable not found: $OpenSCAD" }
if (-not (Test-Path -LiteralPath $scad)) { throw "Guard candidate CAD not found: $scad" }
New-Item -ItemType Directory -Force -Path $outputRoot | Out-Null

function Invoke-CAD([string]$Arguments, [string]$OutputFile, [string]$Name) {
    $stdout = Join-Path $outputRoot ($Name + '.stdout.log')
    $stderr = Join-Path $outputRoot ($Name + '.stderr.log')
    Remove-Item -LiteralPath $OutputFile,$stdout,$stderr -Force -ErrorAction SilentlyContinue
    $proc = Start-Process -FilePath $OpenSCAD -ArgumentList $Arguments -Wait -PassThru `
        -WindowStyle Hidden -RedirectStandardOutput $stdout -RedirectStandardError $stderr
    $log = ''
    if (Test-Path -LiteralPath $stdout) { $log += [IO.File]::ReadAllText($stdout) }
    if (Test-Path -LiteralPath $stderr) { $log += [IO.File]::ReadAllText($stderr) }
    $facets = 0
    if (Test-Path -LiteralPath $OutputFile) {
        $bytes = [IO.File]::ReadAllBytes($OutputFile)
        if ($bytes.Length -ge 84) {
            $n = [BitConverter]::ToUInt32($bytes,80)
            if ($bytes.Length -eq (84 + [int64]$n * 50)) { $facets = [int]$n }
            else { $facets = [regex]::Matches([Text.Encoding]::ASCII.GetString($bytes),'(?m)^\s*facet\s+normal\b').Count }
        }
    }
    [pscustomobject]@{ ExitCode=$proc.ExitCode; Log=$log; Facets=$facets; Exists=(Test-Path -LiteralPath $OutputFile) }
}

function Test-View([string]$Style,[string]$View,[int]$Angle,[bool]$ExpectEmpty,[string]$Name) {
    $styleDir = Join-Path $outputRoot $Style
    New-Item -ItemType Directory -Force -Path $styleDir | Out-Null
    $out = Join-Path $styleDir ($Name + '.stl')
    $angleText = $Angle.ToString([Globalization.CultureInfo]::InvariantCulture)
    $args = '-D "part_view=\"' + $View + '\"" -D "stop_guard_floor_fastener_style=\"' + $Style + '\"" -D "jaw_angle_deg=' + $angleText + '" -o "' + $out + '" "' + $scad + '" --hardwarnings'
    $r = Invoke-CAD $args $out ($Style + '-' + $Name)
    if ($r.Log -match '(?im)\b(WARNING|ERROR):') { throw "$Style/$View emitted warning/error:`n$($r.Log)" }
    $emptyObject = $r.Log -match 'Current top level object is empty'
    if ((-not $r.Exists -and -not ($ExpectEmpty -and $emptyObject)) -or
        ($r.ExitCode -ne 0 -and -not $emptyObject)) {
        throw "$Style/$View did not export cleanly (exit $($r.ExitCode))`n$($r.Log)"
    }
    if ($ExpectEmpty -and $r.Facets -ne 0) { throw "$Style/$View has $($r.Facets) intersection facets; see $out" }
    if (-not $ExpectEmpty -and $r.Facets -le 0) { throw "$Style/$View unexpectedly exported no geometry; see $out" }
    $state = if ($ExpectEmpty) { 'empty intersection' } else { "$($r.Facets) facets" }
    Write-Output "PASS $Style / $View / $Angle deg: $state"
}

foreach ($style in $Styles) {
    $styleDir = Join-Path $outputRoot $style
    New-Item -ItemType Directory -Force -Path $styleDir | Out-Null
    $assembly = Join-Path $styleDir 'assembly.csg'
    $args = '--hardwarnings -D "stop_guard_floor_fastener_style=\"' + $style + '\"" -o "' + $assembly + '" "' + $scad + '"'
    $compiled = Invoke-CAD $args $assembly ($style + '-assembly')
    if ($compiled.ExitCode -ne 0 -or -not $compiled.Exists -or $compiled.Log -match '(?im)\b(WARNING|ERROR):') {
        throw "$style assembly CSG compile failed:`n$($compiled.Log)"
    }
    Write-Output "PASS $style assembly CSG compile"
    if ($Checks -contains 'floor') {
        Test-View $style 'stop_guard_floor_structure_clearance' 0 $true 'floor-vs-structure'
    }
    if ($Checks -contains 'shell') {
        Test-View $style 'stop_guard_shell_floor_clearance' 0 $true 'shell-vs-floor'
    }
    if ($Checks -contains 'guard') {
        foreach ($angle in $Angles) {
            Test-View $style 'stop_guard_enclosure_clearance' $angle $true ("guard-vs-mechanism-{0}" -f $angle)
        }
    }
    if ($ExportComponents) {
        foreach ($view in @('stop_guard_floor_left_print','stop_guard_floor_right_print')) {
            Test-View $style $view 0 $false $view
        }
    }
}

Write-Output ("PASS: fastener variant checks complete for styles {0}; checks={1}; guard sample angles={2}. Physical hardware fit, tolerance robustness, strength, access protection and safety compliance remain unverified." -f ($Styles -join ','),($Checks -join ','),($Angles -join ','))