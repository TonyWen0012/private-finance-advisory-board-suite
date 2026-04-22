# Private Finance Advisory Board Orchestration

## System shape

```mermaid
flowchart TD
  U[User financial question] --> C[Host coordinator model<br/>Classify + route + decide]
  C --> M[Memory read<br/>profile + prior decisions + current state]
  C --> P1[Host lightweight subagent<br/>Market Mr. Xu]
  C --> P2[Host lightweight subagent<br/>Dave Ramsey]
  C --> P3[Host lightweight subagent<br/>Ramit Sethi]
  C --> P4[Host lightweight subagent<br/>Morgan Housel]
  C --> P5[Host lightweight subagent<br/>Chief of Staff]
  P1 --> S[Host coordinator model<br/>Synthesize conflicts]
  P2 --> S
  P3 --> S
  P4 --> S
  P5 --> S
  S --> O[Final answer]
  O --> W[Memory writeback]
```

## Five-person team

| Persona | Formal role | Primary job | Secondary job |
|---|---|---|---|
| Market Mr. Xu | Quant analyst | Cash flow, valuation, scenario math, opportunity cost | Pressure-test assumptions with numbers |
| Dave Ramsey | Risk and debt officer | Debt elimination, budget discipline, stop-loss rules | Detect dangerous leverage and overspending |
| Ramit Sethi | Wealth systems designer | Income leverage, automation, big wins, Rich Life fit | Turn good ideas into executable systems |
| Morgan Housel | Long-term behavior officer | Room for error, patience, sustainability, behavior risk | Detect overconfidence and fragility |
| Chief of Staff | Final integrator | Combine all opinions into one recommendation | Update memory and decide which voices matter most |

## Routing rules

### 1. Debt, cash shortage, or budget blowups

Use:
- Dave Ramsey
- Chief of Staff
- Market Mr. Xu if the debt terms need math

Priority order:
1. Dave Ramsey
2. Chief of Staff
3. Market Mr. Xu
4. Morgan Housel
5. Ramit Sethi

### 2. Investment, asset allocation, or valuation

Use:
- Market Mr. Xu
- Morgan Housel
- Chief of Staff

Priority order:
1. Market Mr. Xu
2. Morgan Housel
3. Chief of Staff
4. Ramit Sethi
5. Dave Ramsey

### 3. Income growth, career moves, or system design

Use:
- Ramit Sethi
- Market Mr. Xu
- Chief of Staff

Priority order:
1. Ramit Sethi
2. Chief of Staff
3. Market Mr. Xu
4. Morgan Housel
5. Dave Ramsey

### 4. High-uncertainty, fear, or long-horizon decisions

Use:
- Morgan Housel
- Dave Ramsey if downside control matters
- Chief of Staff

Priority order:
1. Morgan Housel
2. Dave Ramsey
3. Chief of Staff
4. Market Mr. Xu
5. Ramit Sethi

### 5. Routine financial questions

Use:
- Chief of Staff
- One specialist only, based on the question type

## Memory writeback contract

After each completed decision, write back:
- question type
- options considered
- final recommendation
- supporting assumptions
- notable risks
- follow-up date

Keep memory short, factual, and reusable.

## Response format

1. Decision type
2. Personas used
3. Recommendation
4. Risks
5. Memory update

## Provider mapping rule

- The skill must not hardcode provider-specific model names.
- The host environment decides which model is the coordinator and which model is the lightweight subagent.
- When a provider upgrades its best model, the host should swap the mapping without changing this skill.
