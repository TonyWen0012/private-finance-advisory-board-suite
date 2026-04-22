param(
    [string]$RootPath = $PSScriptRoot
)

$skillRoot = Resolve-Path (Join-Path $RootPath '..')
$memoryDir = Join-Path $skillRoot 'memory'

New-Item -ItemType Directory -Force -Path $memoryDir | Out-Null

$files = @{
    'profile.md' = @"
# Profile

- alias:
- household:
- dependents:
- country:
- currency:
- decision style:
- risk tolerance:
- long-term goals:
"@
    'preferences.md' = @"
# Preferences

- preferred tone:
- preferred detail level:
- preferred default tradeoff:
- preferred personas:
- anti-goals:
- recurring concerns:
"@
    'financial-state.md' = @"
# Financial State

- monthly income:
- fixed expenses:
- variable expenses:
- liquid cash:
- investable surplus:
- debts:
- recurring obligations:
- insurance coverage:
- near-term goals:
"@
    'open-questions.md' = @"
# Open Questions

- date:
  question:
  missing_data:
  unresolved_tradeoffs:
  needed_follow_up:
"@
    'decision-log.md' = @"
# Decision Log

## Entries

- date:
  question:
  personas_used:
  recommendation:
  rationale:
  assumptions:
  risks:
  follow_up:
"@
}

foreach ($entry in $files.GetEnumerator()) {
    $target = Join-Path $memoryDir $entry.Key
    if (-not (Test-Path $target)) {
        Set-Content -LiteralPath $target -Value $entry.Value -Encoding UTF8
    }
}

Write-Host "Memory scaffold is ready at $memoryDir"
