param(
    [Parameter(Mandatory = $true)][string]$QuestionType,
    [Parameter(Mandatory = $true)][string]$Recommendation,
    [string[]]$PersonasUsed = @(),
    [string]$CurrentStateSummary = "",
    [string]$Rationale = "",
    [string[]]$Assumptions = @(),
    [string[]]$Risks = @(),
    [string]$FollowUp = ""
)

$skillRoot = Resolve-Path (Join-Path $PSScriptRoot '..')
$memoryDir = Join-Path $skillRoot 'memory'
$logPath = Join-Path $memoryDir 'decision-log.md'
$openQuestionsPath = Join-Path $memoryDir 'open-questions.md'
$date = Get-Date -Format 'yyyy-MM-dd'

$personasText = if ($PersonasUsed.Count -gt 0) { $PersonasUsed -join ', ' } else { '' }
$assumptionsText = if ($Assumptions.Count -gt 0) { $Assumptions -join '; ' } else { '' }
$risksText = if ($Risks.Count -gt 0) { $Risks -join '; ' } else { '' }

$entry = @"

- date: $date
  question: $QuestionType
  personas_used: $personasText
  recommendation: $Recommendation
  rationale: $Rationale
  assumptions: $assumptionsText
  risks: $risksText
  follow_up: $FollowUp
"@

Add-Content -LiteralPath $logPath -Value $entry -Encoding UTF8

if ($Recommendation -eq 'needs_more_data' -and $FollowUp) {
    $openEntry = @"

- date: $date
  question: $QuestionType
  missing_data: $CurrentStateSummary
  unresolved_tradeoffs: $Rationale
  needed_follow_up: $FollowUp
"@
    Add-Content -LiteralPath $openQuestionsPath -Value $openEntry -Encoding UTF8
}

Write-Host "Decision logged to $logPath"
