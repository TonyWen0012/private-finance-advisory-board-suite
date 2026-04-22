# Memory Schema

## Purpose

Store only the minimum durable context needed to make better future financial decisions.

## Memory layers

### 1. Profile

Stable user context.

Fields:
- name or alias
- household shape
- dependents
- country or currency context
- broad risk tolerance
- decision style

### 2. Preferences

How the user wants decisions framed.

Fields:
- preferred tone
- default tradeoff style
- anti-goals
- preferred personas
- high-priority concerns

### 3. Financial state

The current operating snapshot.

Fields:
- income
- recurring expenses
- liquid cash
- debt balances
- debt rates
- investable surplus
- known obligations
- near-term goals

### 4. Decision log

What was decided and why.

Fields:
- date
- question type
- options considered
- final decision
- rationale
- assumptions
- risks
- follow-up date

### 5. Open questions

What is still missing before a confident decision.

Fields:
- missing data
- unresolved tradeoffs
- needed follow-up

## Storage rules

- Keep entries short and factual.
- Store decisions, not long essays.
- Update the current snapshot after major changes.
- Do not overwrite history; append new decisions.
- Keep open questions in `memory/open-questions.md` so the host can resume unresolved work cleanly.
