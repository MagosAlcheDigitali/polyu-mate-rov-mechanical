param([string]$OpenSCAD = 'C:\Program Files\OpenSCAD\openscad.exe')

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest
$scad = Join-Path $PSScriptRoot 'bte_ser203x_package_proxy.scad'
$qa = Join-Path $PSScriptRoot 'bte_ser203x_package_proxy_qa'
if (-not (Test-Path -LiteralPath $OpenSCAD)) { throw "OpenSCAD executable not found: $OpenSCAD" }
New-Item -ItemType Directory -Force -Path $qa | Out-Null

foreach ($view in @('package','housing_only','top_feature_and_shaft','top_mount_pattern')) {
    $out = Join-Path $qa ($view + '.csg')
    $stdout = Join-Path $qa ($view + '.stdout.log')
    $stderr = Join-Path $qa ($view + '.stderr.log')
    $args = '-D "part_view=\"' + $view + '\"" -o "' + $out + '" "' + $scad + '" --hardwarnings'
    $p = Start-Process -FilePath $OpenSCAD -ArgumentList $args -Wait -PassThru `
        -WindowStyle Hidden -RedirectStandardOutput $stdout -RedirectStandardError $stderr
    $log = ''
    if (Test-Path $stdout) { $log += [IO.File]::ReadAllText($stdout) }
    if (Test-Path $stderr) { $log += [IO.File]::ReadAllText($stderr) }
    if ($p.ExitCode -ne 0 -or -not (Test-Path $out) -or $log -match '(?im)\b(WARNING|ERROR):') {
        throw "$view compile failed (exit $($p.ExitCode))`n$log"
    }
    Write-Output "PASS: $view CSG compile with --hardwarnings"
}

$stl = Join-Path $qa 'package-review-only.stl'
$stdout = Join-Path $qa 'package-stl.stdout.log'
$stderr = Join-Path $qa 'package-stl.stderr.log'
$args = '-D "part_view=\"package\"" -o "' + $stl + '" "' + $scad + '" --hardwarnings'
$p = Start-Process -FilePath $OpenSCAD -ArgumentList $args -Wait -PassThru `
    -WindowStyle Hidden -RedirectStandardOutput $stdout -RedirectStandardError $stderr
$log = ''
if (Test-Path $stdout) { $log += [IO.File]::ReadAllText($stdout) }
if (Test-Path $stderr) { $log += [IO.File]::ReadAllText($stderr) }
if ($p.ExitCode -ne 0 -or -not (Test-Path $stl) -or $log -match '(?im)\b(WARNING|ERROR):') {
    throw "Package STL export failed (exit $($p.ExitCode))`n$log"
}

$bytes = [IO.File]::ReadAllBytes($stl)
$points = [Collections.Generic.List[double[]]]::new()
if ($bytes.Length -ge 84) {
    $triangles = [BitConverter]::ToUInt32($bytes,80)
    if ($bytes.Length -eq (84 + [int64]$triangles * 50)) {
        for ($i=0; $i -lt $triangles; $i++) {
            $base = 84 + $i*50 + 12
            for ($v=0; $v -lt 3; $v++) {
                $off=$base+$v*12
                $points.Add([double[]]@([BitConverter]::ToSingle($bytes,$off),
                    [BitConverter]::ToSingle($bytes,$off+4),[BitConverter]::ToSingle($bytes,$off+8)))
            }
        }
    } else {
        $ascii=[Text.Encoding]::ASCII.GetString($bytes)
        foreach ($m in [regex]::Matches($ascii,'(?m)^\s*vertex\s+([-+0-9.eE]+)\s+([-+0-9.eE]+)\s+([-+0-9.eE]+)')) {
            $points.Add([double[]]@([double]::Parse($m.Groups[1].Value,[Globalization.CultureInfo]::InvariantCulture),
                [double]::Parse($m.Groups[2].Value,[Globalization.CultureInfo]::InvariantCulture),
                [double]::Parse($m.Groups[3].Value,[Globalization.CultureInfo]::InvariantCulture)))
        }
    }
}
if ($points.Count -eq 0) { throw 'Exported STL has no readable triangles.' }
$mins=@(); $maxs=@(); $dims=@()
for ($axis=0; $axis -lt 3; $axis++) {
    $coordinates = @($points | ForEach-Object { $_[$axis] })
    $mins += ($coordinates | Measure-Object -Minimum).Minimum
    $maxs += ($coordinates | Measure-Object -Maximum).Maximum
    $dims += $maxs[$axis]-$mins[$axis]
}
$expected=@(70.0,32.0,80.1)
for ($i=0; $i -lt 3; $i++) {
    if ([Math]::Abs($dims[$i]-$expected[$i]) -gt 0.05) {
        throw "Unexpected package STL dimension on axis ${i}: $($dims[$i]) mm, expected $($expected[$i]) mm."
    }
}
Write-Output ("PASS: review mesh bounds X/Y/Z = {0:N2} x {1:N2} x {2:N2} mm." -f $dims[0],$dims[1],$dims[2])
Write-Output 'PASS: dimensional checks cover the housing/shaft envelope only; connector and side mounting features remain excluded or approximate.'