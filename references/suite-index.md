# Suite Index

## Included components

### Orchestrator

- `SKILL.md`
- `agents/openai.yaml`
- `references/orchestration.md`
- `references/model-policy.md`
- `references/memory-schema.md`
- `references/personas.md`
- `references/decision-format.md`

### Memory layer

- `memory/profile.md`
- `memory/preferences.md`
- `memory/financial-state.md`
- `memory/open-questions.md`
- `memory/decision-log.md`

### Persona bundles

- `personas/market-mr-xu-jiyuan/`
- `personas/dave-ramsey/`
- `personas/ramit-sethi/`
- `personas/morgan-housel/`

### Tooling

- `scripts/initialize-memory.ps1`
- `scripts/log-decision.ps1`
- `scripts/validate-package.ps1`
- `scripts/package-skill.ps1`
- `scripts/validate-suite.ps1`
- `scripts/package-suite.ps1`

## Usage rule

- Read `GUIDE.md` first if you are onboarding or publishing this suite on GitHub.
- Use the orchestrator for final routing and memory writeback.
- Use persona bundles when you need the original distilled persona logic or voice.
- Keep the suite portable by leaving provider-specific model mapping outside the skill.
