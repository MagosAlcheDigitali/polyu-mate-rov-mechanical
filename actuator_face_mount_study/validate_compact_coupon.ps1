param([string]$OpenSCAD = 'C:\Program Files\OpenSCAD\openscad.exe')

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest
$scad = Join-Path $PSScriptRoot 'ser_face_mount_coupon_compact.scad'
$qa = Join-Path $PSScriptRoot 'compact_qa'
if (-not (Test-Path -LiteralPath $OpenSCAD)) { throw "OpenSCAD executable not found: $OpenSCAD" }
New-Item -ItemType Directory -Force -Path $qa | Out-Null

function Invoke-OpenSCAD([string]$Name, [string]$Arguments, [string]$OutputFile) {
    $stdout = Join-Path $qa ($Name + '.stdout.log')
    $stderr = Join-Path $qa ($Name + '.stderr.log')
    Remove-Item -LiteralPath $OutputFile,$stdout,$stderr -Force -ErrorAction SilentlyContinue
    $process = Start-Process -FilePath $OpenSCAD -ArgumentList $Arguments -Wait -PassThru `
        -WindowStyle Hidden -RedirectStandardOutput $stdout -RedirectStandardError $stderr
    $log = ''
    for ($i = 0; $i -lt 20; $i++) {
        try {
            if (Test-Path -LiteralPath $stdout) { $log += [IO.File]::ReadAllText($stdout) }
            if (Test-Path -LiteralPath $stderr) { $log += [IO.File]::ReadAllText($stderr) }
            break
        } catch {
            Start-Sleep -Milliseconds 200
        }
    }
    $failed = ($process.ExitCode -ne 0) -or -not (Test-Path -LiteralPath $OutputFile) -or ($log -match '(?im)\b(WARNING|ERROR):')
    if ($failed) {
        throw "$Name failed (exit $($process.ExitCode))`n$log"
    }
    Write-Host "PASS: $Name (OpenSCAD --hardwarnings)"
    return $log
}

foreach ($view in @('assembly','plate_only','pattern_check')) {
    $output = Join-Path $qa ($view + '.csg')
    $arguments = '-D "part_view=\"' + $view + '\"" -o "' + $output + '" "' + $scad + '" --hardwarnings'
    [void](Invoke-OpenSCAD $view $arguments $output)
}

$stl = Join-Path $qa 'plate-only.stl'
$arguments = '-D "part_view=\"plate_only\"" -o "' + $stl + '" "' + $scad + '" --hardwarnings'
[void](Invoke-OpenSCAD 'plate-only-stl' $arguments $stl)

$png = Join-Path $qa 'ser-face-mount-coupon-compact-preview.png'
$arguments = '--imgsize=1280,900 --viewall --autocenter -o "' + $png + '" "' + $scad + '" --hardwarnings'
[void](Invoke-OpenSCAD 'assembly-preview' $arguments $png)

$text = [Text.Encoding]::ASCII.GetString([IO.File]::ReadAllBytes($stl))
$vertices = [regex]::Matches($text, '(?m)^\s*vertex\s+([-+0-9.eE]+)\s+([-+0-9.eE]+)\s+([-+0-9.eE]+)')
if ($vertices.Count -eq 0) { throw 'No ASCII STL vertices found in plate-only export.' }
$xs = [Collections.Generic.List[double]]::new()
$ys = [Collections.Generic.List[double]]::new()
$zs = [Collections.Generic.List[double]]::new()
$culture = [Globalization.CultureInfo]::InvariantCulture
foreach ($vertex in $vertices) {
    $xs.Add([double]::Parse($vertex.Groups[1].Value,$culture))
    $ys.Add([double]::Parse($vertex.Groups[2].Value,$culture))
    $zs.Add([double]::Parse($vertex.Groups[3].Value,$culture))
}
$bounds = @(
    ($xs | Measure-Object -Minimum).Minimum, ($xs | Measure-Object -Maximum).Maximum,
    ($ys | Measure-Object -Minimum).Minimum, ($ys | Measure-Object -Maximum).Maximum,
    ($zs | Measure-Object -Minimum).Minimum, ($zs | Measure-Object -Maximum).Maximum
)
$extents = @(($bounds[1] - $bounds[0]),($bounds[3] - $bounds[2]),($bounds[5] - $bounds[4]))
$expected = @(66.0,36.0,3.0)
for ($i = 0; $i -lt 3; $i++) {
    if ([Math]::Abs($extents[$i]-$expected[$i]) -gt 0.01) {
        throw "STL extent $i is $($extents[$i]) mm; expected $($expected[$i]) mm."
    }
}
Write-Output "PASS: plate-only STL bounds $($extents -join ' x ') mm; $($vertices.Count) parsed vertices."
Write-Output "Source SHA-256: $((Get-FileHash -LiteralPath $scad -Algorithm SHA256).Hash)"

