# Private Finance Advisory Board Guide

## What this is

A portable five-person private finance skill suite for spending, debt, investing, cash flow, insurance, asset allocation, and income decisions.

## What is included

- One orchestrator skill
- Five persona bundles
- Shared memory templates
- Decision and routing references
- Validation and packaging scripts

## How to use it

1. Open the suite root in Codex or your compatible host.
2. Let the host choose the best available general reasoning model for orchestration.
3. Use the host's lightweight model for extraction, summaries, and subagent work.
4. Ask one financial question at a time when possible.
5. Let the board classify the request, consult memory, route to the smallest useful set of personas, and write the decision back.

## Recommended first prompt

Use a prompt like:

`Review my financial decision with the five-person board and give me a recommendation with risks, assumptions, and a memory writeback.`

## How the board works

- Market Mr. Xu handles quantified tradeoffs, valuation, cash flow, and scenarios.
- Dave Ramsey handles debt, budget discipline, and downside protection.
- Ramit Sethi handles income growth, systems, and high-leverage improvements.
- Morgan Housel handles behavior risk, long-term survivability, and margin of safety.
- The chief of staff persona integrates the views and writes the final conclusion to memory.

## Model policy

- Keep provider-specific model names outside the skill.
- Let the host map each role to the best available model from OpenAI, Claude, Google, or future providers.
- Prefer a strong coordinator model for routing and final judgment.
- Prefer a lightweight model for extraction, summaries, and narrow subagent work.

## Memory policy

- Profile and preferences should stay stable.
- Financial state, open questions, and decision logs should be updated after each meaningful decision.
- If key inputs are missing, the board should ask for them instead of guessing.

## Package notes

- Use `scripts/validate-suite.ps1` before publishing changes.
- Use `scripts/package-suite.ps1` to build the distributable zip.
