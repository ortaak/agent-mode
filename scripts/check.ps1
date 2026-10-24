# Detects the project type in the current directory, runs its standard checks,
# and prints a short summary. Full output is shown only for failing checks,
# and only the last 20 lines, to keep agent context small.
#
# Usage (from project root):
#   .\.agent-mode\scripts\check.ps1

$ErrorActionPreference = 'Continue'
$results = @()

function Invoke-Check {
    param([string]$Name, [string]$Command)

    $output = cmd /c "$Command 2>&1"
    $code = $LASTEXITCODE
    $status = if ($code -eq 0) { 'PASS' } else { 'FAIL' }
    $script:results += [pscustomobject]@{ Check = $Name; Command = $Command; Status = $status }

    if ($code -ne 0) {
        Write-Host ""
        Write-Host "--- $Name output (last 20 lines) ---"
        $output | Select-Object -Last 20 | ForEach-Object { Write-Host $_ }
    }
}

$found = $false

if (Test-Path 'package.json') {
    $found = $true
    $pkg = Get-Content 'package.json' -Raw | ConvertFrom-Json
    $scripts = @{}
    if ($pkg.scripts) {
        $pkg.scripts.PSObject.Properties | ForEach-Object { $scripts[$_.Name] = $_.Value }
    }
    foreach ($name in @('lint', 'typecheck', 'test', 'build')) {
        if ($scripts.ContainsKey($name)) {
            Invoke-Check -Name "npm:$name" -Command "npm run $name --silent"
        }
    }
    if ($scripts.ContainsKey('typecheck') -eq $false -and (Test-Path 'tsconfig.json')) {
        Invoke-Check -Name 'tsc' -Command 'npx tsc --noEmit'
    }
}

if ((Test-Path 'pyproject.toml') -or (Test-Path 'requirements.txt')) {
    $found = $true
    Invoke-Check -Name 'pytest' -Command 'python -m pytest -q'
}

if (Test-Path 'go.mod') {
    $found = $true
    Invoke-Check -Name 'go vet' -Command 'go vet ./...'
    Invoke-Check -Name 'go test' -Command 'go test ./...'
}

if (Test-Path 'Cargo.toml') {
    $found = $true
    Invoke-Check -Name 'cargo test' -Command 'cargo test --quiet'
}

if (-not $found) {
    Write-Host "No known project type found (package.json, pyproject.toml, requirements.txt, go.mod, Cargo.toml)."
    Write-Host "Run the project's check commands manually and record them in docs\project-state.md."
    exit 2
}

Write-Host ""
Write-Host "=== Summary ==="
$results | Format-Table -AutoSize | Out-String | Write-Host

if ($results.Status -contains 'FAIL') { exit 1 } else { exit 0 }
