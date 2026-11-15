param(
    [string]$OpenSCAD = 'C:\Program Files\OpenSCAD\openscad.exe'
)

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest

$scad = Join-Path $PSScriptRoot 'actuator_dshaft_coupler_module.scad'
if (-not (Test-Path -LiteralPath $OpenSCAD)) { throw "OpenSCAD executable not found: $OpenSCAD" }
if (-not (Test-Path -LiteralPath $scad)) { throw "Coupler study source not found: $scad" }

$temp = Join-Path ([IO.Path]::GetTempPath()) ('mate-dshaft-coupler-' + [guid]::NewGuid().ToString('N'))
New-Item -ItemType Directory -Path $temp | Out-Null

try {
    foreach ($profile in @('D','round')) {
        $csg = Join-Path $temp ($profile + '.csg')
        $stdout = Join-Path $temp ($profile + '.stdout')
        $stderr = Join-Path $temp ($profile + '.stderr')
        $define = if ($profile -eq 'D') { '' } else { '-D "motor_shaft_profile=\"round\"" ' }
        $arguments = '--hardwarnings ' + $define + '-o "' + $csg + '" "' + $scad + '"'
        $process = Start-Process -FilePath $OpenSCAD -ArgumentList $arguments -Wait -PassThru `
            -WindowStyle Hidden -RedirectStandardOutput $stdout -RedirectStandardError $stderr
        $log = ''
        if (Test-Path -LiteralPath $stdout) { $log += [IO.File]::ReadAllText($stdout) }
        if (Test-Path -LiteralPath $stderr) { $log += [IO.File]::ReadAllText($stderr) }
        if ($process.ExitCode -ne 0 -or -not (Test-Path -LiteralPath $csg) -or
            $log -match '(?im)\b(WARNING|ERROR):') {
            throw "Coupler $profile profile failed --hardwarnings compile. Exit=$($process.ExitCode)`n$log"
        }
        Write-Output "PASS: $profile motor-shaft profile compiles with --hardwarnings and no warning/error output."
    }
    Write-Output 'Scope: CSG compilation only. No vendor STEP fit, tolerance, retention, material, or torque capacity is validated.'
} finally {
    Remove-Item -LiteralPath $temp -Recurse -Force -ErrorAction SilentlyContinue
}

