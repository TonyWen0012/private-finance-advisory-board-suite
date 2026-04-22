# Model Policy

## Goal

Keep this skill portable across OpenAI, Claude, Google, and future providers.

## Rule

- Do not hardcode vendor model names in `SKILL.md`.
- Describe models by role, not by brand.
- The host runtime chooses the best available model for each role.

## Role mapping

- Coordinator model: the strongest general reasoning model available in the host
- Lightweight subagent model: the cheapest reliable model that can still follow instructions and format outputs well
- Final writeback model: usually the coordinator model

## Selection heuristic

Use the strongest model when the task needs:
- routing
- synthesis
- conflict resolution
- final judgment
- memory policy updates

Use the lightweight model when the task needs:
- extraction
- classification
- formatting
- short summaries
- repetitive subtask execution

## Maintenance rule

When a provider releases a better default model, update the host mapping only.
Do not rewrite the skill unless the workflow itself changes.
