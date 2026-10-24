# Installs or updates the agent-mode kit in a project.
#
# Usage:
#   .\install.ps1 -Target "C:\path\to\project"            # first install
#   .\install.ps1 -Target "C:\path\to\project" -Update    # refresh kit files
#
# Kit files go to <project>\.agent-mode\ and are overwritten on update.
# Project files (AGENTS.md, CLAUDE.md, CHANGELOG.md, docs\) are created only
# when missing and are never overwritten.

param(
    [Parameter(Mandatory = $true)]
    [string]$Target,

    [switch]$Update
)

$ErrorActionPreference = 'Stop'

$kitRoot = Split-Path -Parent $PSScriptRoot
$kitDest = Join-Path $Target '.agent-mode'

if (-not (Test-Path $Target -PathType Container)) {
    throw "Target directory does not exist: $Target"
}

if ((Test-Path $kitDest) -and -not $Update) {
    throw ".agent-mode already exists in $Target. Use -Update to refresh it."
}

New-Item -ItemType Directory -Path $kitDest -Force | Out-Null

# Copy kit contents (skip VCS metadata)
Get-ChildItem -Path $kitRoot -Force |
    Where-Object { $_.Name -ne '.git' } |
    ForEach-Object {
        Copy-Item -Path $_.FullName -Destination $kitDest -Recurse -Force
    }

# Project-level files: create only when missing
function Copy-IfMissing {
    param([string]$Source, [string]$Destination)
    if (-not (Test-Path $Destination)) {
        $parent = Split-Path -Parent $Destination
        New-Item -ItemType Directory -Path $parent -Force | Out-Null
        Copy-Item -Path $Source -Destination $Destination
        Write-Host "  created  $Destination"
    } else {
        Write-Host "  kept     $Destination (already exists)"
    }
}

Copy-IfMissing -Source (Join-Path $kitRoot 'AGENTS.md') -Destination (Join-Path $Target 'AGENTS.md')
Copy-IfMissing -Source (Join-Path $kitRoot 'CLAUDE.md') -Destination (Join-Path $Target 'CLAUDE.md')
Copy-IfMissing -Source (Join-Path $kitRoot 'templates\project-state.md') -Destination (Join-Path $Target 'docs\project-state.md')

$changelog = Join-Path $Target 'CHANGELOG.md'
if (-not (Test-Path $changelog)) {
    Set-Content -Path $changelog -Encoding utf8 -Value "# Changelog`n`nAll notable changes are documented here. Format: Keep a Changelog. Versioning: SemVer.`n`n## [Unreleased]`n"
    Write-Host "  created  $changelog"
} else {
    Write-Host "  kept     $changelog (already exists)"
}

New-Item -ItemType Directory -Path (Join-Path $Target 'docs\decisions') -Force | Out-Null

$version = (Get-Content (Join-Path $kitRoot 'VERSION') -Raw).Trim()
Write-Host ""
Write-Host "agent-mode v$version installed in $Target"
Write-Host "Next: fill in docs\project-state.md, then run .agent-mode\scripts\check.ps1"
