param(
    [string]$RootPath = $PSScriptRoot
)

$skillRoot = Resolve-Path (Join-Path $RootPath '..')
$distDir = Join-Path $skillRoot 'dist'
$zipPath = Join-Path $distDir 'private-finance-advisory-board-suite.zip'

New-Item -ItemType Directory -Force -Path $distDir | Out-Null
if (Test-Path $zipPath) {
    Remove-Item -LiteralPath $zipPath -Force
}

Compress-Archive -Path (Join-Path $skillRoot 'SKILL.md'), (Join-Path $skillRoot 'GUIDE.md'), (Join-Path $skillRoot 'agents'), (Join-Path $skillRoot 'memory'), (Join-Path $skillRoot 'references'), (Join-Path $skillRoot 'scripts'), (Join-Path $skillRoot 'personas') -DestinationPath $zipPath

Write-Host "Packaged full suite to $zipPath"
