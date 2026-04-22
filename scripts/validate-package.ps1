param(
    [string]$RootPath = $PSScriptRoot
)

$skillRoot = Resolve-Path (Join-Path $RootPath '..')
$required = @(
    'SKILL.md',
    'agents/openai.yaml',
    'references/memory-schema.md',
    'references/orchestration.md',
    'references/model-policy.md',
    'references/personas.md',
    'references/decision-format.md',
    'memory/profile.md',
    'memory/preferences.md',
    'memory/financial-state.md',
    'memory/open-questions.md',
    'memory/decision-log.md'
)

$missing = @()
foreach ($item in $required) {
    if (-not (Test-Path (Join-Path $skillRoot $item))) {
        $missing += $item
    }
}

if ($missing.Count -gt 0) {
    Write-Host "Missing files:"
    $missing | ForEach-Object { Write-Host " - $_" }
    exit 1
}

if (Test-Path (Join-Path $skillRoot 'references/monthly-statements')) {
    Write-Host "Legacy monthly-statements folder still exists."
    exit 1
}

Write-Host "Package validation passed."
