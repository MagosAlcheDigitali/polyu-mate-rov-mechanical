param([string]$OpenSCAD = 'C:\Program Files\OpenSCAD\openscad.exe')

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest
$scad = Join-Path $PSScriptRoot 'ser203x_topmount_architecture_study.scad'
$qa = Join-Path $PSScriptRoot 'ser203x_topmount_qa'
if (-not (Test-Path -LiteralPath $OpenSCAD)) { throw "OpenSCAD executable not found: $OpenSCAD" }
New-Item -ItemType Directory -Force -Path $qa | Out-Null

function Invoke-OpenSCAD([string]$Name, [string]$Arguments, [string]$OutputFile, [bool]$ExpectEmpty=$false) {
    $stdout = Join-Path $qa ($Name + '.stdout.log')
    $stderr = Join-Path $qa ($Name + '.stderr.log')
    Remove-Item -LiteralPath $OutputFile,$stdout,$stderr -Force -ErrorAction SilentlyContinue
    $process = Start-Process -FilePath $OpenSCAD -ArgumentList $Arguments -Wait -PassThru `
        -WindowStyle Hidden -RedirectStandardOutput $stdout -RedirectStandardError $stderr
    $log = ''
    $readLogs = $false
    for ($i = 0; $i -lt 20; $i++) {
        try {
            if (Test-Path -LiteralPath $stdout) { $log += [IO.File]::ReadAllText($stdout) }
            if (Test-Path -LiteralPath $stderr) { $log += [IO.File]::ReadAllText($stderr) }
            $readLogs = $true
            break
        } catch {
            Start-Sleep -Milliseconds 200
        }
    }
    $expectedEmpty = $ExpectEmpty -and ($process.ExitCode -eq 1) `
        -and ($log -match 'Current top level object is empty\.')
    if ($expectedEmpty) {
        Write-Host "PASS: $Name empty intersection (OpenSCAD reports empty top-level mesh)"
        return 'EMPTY_INTERSECTION'
    }
    $failed = -not $readLogs -or ($process.ExitCode -ne 0) -or `
        -not (Test-Path -LiteralPath $OutputFile) -or ($log -match '(?im)\b(WARNING|ERROR):')
    if ($failed) { throw "$Name failed (exit $($process.ExitCode))`n$log" }
    Write-Host "PASS: $Name (OpenSCAD --hardwarnings)"
    return $log
}

foreach ($view in @('assembly','face_plate','bearing_bridge','bearing_stack','support_posts','coupler_guard')) {
    $output = Join-Path $qa ($view + '.csg')
    $arguments = '-D "part_view=\"' + $view + '\"" -o "' + $output + '" "' + $scad + '" --hardwarnings'
    [void](Invoke-OpenSCAD $view $arguments $output)
}

foreach ($view in @('case_post_interference','post_guard_interference',
                    'coupler_guard_interference','plate_case_interference')) {
    $output = Join-Path $qa ($view + '.stl')
    $arguments = '-D "part_view=\"' + $view + '\"" -o "' + $output + '" "' + $scad + '" --hardwarnings'
    $result = Invoke-OpenSCAD $view $arguments $output $true
    if ($result -ne 'EMPTY_INTERSECTION') { throw "$view unexpectedly produced a non-empty intersection mesh." }
}

$plate = Join-Path $qa 'face-plate.stl'
$arguments = '-D "part_view=\"face_plate\"" -o "' + $plate + '" "' + $scad + '" --hardwarnings'
[void](Invoke-OpenSCAD 'face-plate-stl' $arguments $plate)
$plateText = [Text.Encoding]::ASCII.GetString([IO.File]::ReadAllBytes($plate))
$vertices = [regex]::Matches($plateText,'(?m)^\s*vertex\s+([-+0-9.eE]+)\s+([-+0-9.eE]+)\s+([-+0-9.eE]+)')
if ($vertices.Count -eq 0) { throw 'Face-plate STL has no parseable vertices.' }
$values = @(@(),@(),@())
$culture = [Globalization.CultureInfo]::InvariantCulture
foreach ($vertex in $vertices) {
    for ($axis=0; $axis -lt 3; $axis++) {
        $values[$axis] += [double]::Parse($vertex.Groups[$axis+1].Value,$culture)
    }
}
$bounds = @()
foreach ($axis in 0..2) {
    $bounds += ($values[$axis] | Measure-Object -Minimum).Minimum
    $bounds += ($values[$axis] | Measure-Object -Maximum).Maximum
}
$extents = @(($bounds[1]-$bounds[0]),($bounds[3]-$bounds[2]),($bounds[5]-$bounds[4]))
$expected = @(48.0,66.0,3.0)
for ($axis=0; $axis -lt 3; $axis++) {
    if ([Math]::Abs($extents[$axis]-$expected[$axis]) -gt 0.01) {
        throw "Face-plate extent $axis is $($extents[$axis]) mm; expected $($expected[$axis]) mm."
    }
}
Write-Host "PASS: face-plate STL bounds $($extents -join ' x ') mm; $($vertices.Count) parsed vertices."

foreach ($part in @(@('bearing_bridge',@(48.0,40.0,4.0)),
                    @('support_posts',@(44.0,14.0,12.1)),
                    @('coupler_guard',@(34.0,34.0,12.1)))) {
    $name = $part[0]
    $wanted = $part[1]
    $output = Join-Path $qa ($name + '-print-study.stl')
    $arguments = '-D "part_view=\"' + $name + '\"" -o "' + $output + '" "' + $scad + '" --hardwarnings'
    [void](Invoke-OpenSCAD ($name + '-stl') $arguments $output)
    $mesh = [Text.Encoding]::ASCII.GetString([IO.File]::ReadAllBytes($output))
    $points = [regex]::Matches($mesh,'(?m)^\s*vertex\s+([-+0-9.eE]+)\s+([-+0-9.eE]+)\s+([-+0-9.eE]+)')
    if ($points.Count -eq 0) { throw "$name STL has no parseable vertices." }
    $axes = @(@(),@(),@())
    foreach ($point in $points) {
        for ($axis=0; $axis -lt 3; $axis++) {
            $axes[$axis] += [double]::Parse($point.Groups[$axis+1].Value,$culture)
        }
    }
    $size = @()
    for ($axis=0; $axis -lt 3; $axis++) {
        $lo=($axes[$axis] | Measure-Object -Minimum).Minimum
        $hi=($axes[$axis] | Measure-Object -Maximum).Maximum
        $size += ($hi-$lo)
        if ([Math]::Abs(($hi-$lo)-$wanted[$axis]) -gt 0.02) {
            throw "$name STL extent $axis is $($hi-$lo) mm; expected $($wanted[$axis]) mm."
        }
    }
    Write-Host "PASS: $name STL bounds $($size -join ' x ') mm."
}

$png = Join-Path $qa 'ser203x-topmount-architecture-preview.png'
$arguments = '--imgsize=1280,900 --viewall --autocenter -o "' + $png + '" "' + $scad + '" --hardwarnings'
[void](Invoke-OpenSCAD 'assembly-preview' $arguments $png)
Write-Host "Source SHA-256: $((Get-FileHash -LiteralPath $scad -Algorithm SHA256).Hash)"

