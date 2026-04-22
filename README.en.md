[中文](./README.md)

# Private Finance Advisory Board Suite

`private-finance-advisory-board-suite` is a portable, vendor-neutral private finance decision skill.

It is not just a bundle of finance personas. It turns orchestration, memory, persona routing, decision formatting, validation, and packaging into one reusable workflow for spending, debt, investing, cash flow, insurance, asset allocation, and income-strategy decisions.

If these problems sound familiar:

- you know a financial decision has multiple dimensions, but it is hard to reconcile different advice styles into one answer
- you want downside protection, quantitative tradeoff analysis, income growth thinking, and long-term behavior awareness in the same workflow
- every AI conversation feels disposable, so your key context and prior decisions never accumulate
- you want to publish a reusable private-finance framework on GitHub instead of sharing a loose pile of prompts

this suite is built for that use case.

It does not promise higher returns.

What it does is make financial decisions more structured, traceable, and reusable by separating roles clearly and writing conclusions back to memory.

## Release Status

`v1.0.0` is the first public stable release of this suite.

- The core architecture stays the same: orchestrator, memory layer, persona bundles, and scripts
- Future updates should stay compatible with the current workflow whenever possible
- If you are new to the project, start with `GUIDE.md`

## What This Suite Helps You Do

### 1. Classify the question before pulling in specialists

The orchestrator does not call every voice every time.

It first determines whether the request is mainly about:

- debt and cash-flow stress
- investing, valuation, or asset allocation
- income growth and system design
- uncertainty and long-horizon behavior risk
- routine finance questions

Then it routes the task to the smallest persona set that can answer well.

### 2. Let different finance philosophies collaborate inside one decision

The five-person board is made up of:

- Market Mr. Xu: quantified tradeoffs, cash flow, valuation, scenario math
- Dave Ramsey: debt, budget discipline, downside protection
- Ramit Sethi: income growth, automation, executable wealth systems
- Morgan Housel: survivability, behavior risk, room for error
- Chief of Staff: synthesis, arbitration, and memory writeback

The first four are bundled persona skills inside the repo. `Chief of Staff` is performed by the main orchestrator. In practice, the architecture is:

- one orchestrator
- four bundled persona skills
- one five-person decision board experience

### 3. Persist important context instead of repeating yourself

The suite ships with a durable memory layer:

- `memory/profile.md`
- `memory/preferences.md`
- `memory/financial-state.md`
- `memory/open-questions.md`
- `memory/decision-log.md`

That means the system is designed to improve future decisions using stable profile context, preferences, current financial state, unresolved questions, and past decisions.

### 4. Keep outputs structured and easy to review

The standard answer shape includes:

- Decision type
- Personas used
- Current state summary
- Recommendation
- Risks and tradeoffs
- Next action
- Memory writeback

That structure makes each answer easier to review, reuse, and store as a durable decision record.

### 5. Stay portable across model providers

One of the strongest design choices in this suite is model portability:

- `SKILL.md` does not hardcode provider-specific model names
- the suite describes roles instead of locking itself to one vendor
- the host runtime decides which model should act as coordinator and which should act as lightweight subagent

So when a provider upgrades its best model, the host mapping can change without rewriting the skill.

## Build Logic

This repo is intentionally split into five layers:

| Layer | Purpose | Key files |
|---|---|---|
| Orchestrator | Classify the request, read memory, route personas, synthesize the final answer | `SKILL.md`, `agents/openai.yaml` |
| References | Define routing rules, model policy, output format, and memory schema | `references/*.md` |
| Memory | Store stable context, current state, unresolved questions, and prior decisions | `memory/*.md` |
| Personas | Provide the original distilled thinking and voice of each specialist | `personas/*/SKILL.md` |
| Scripts | Initialize memory, log decisions, validate structure, package releases | `scripts/*.ps1` |

High-level flow:

```text
User question
  -> Orchestrator classifies the decision
  -> Read memory and current financial state
  -> Route to the smallest useful persona set
  -> Synthesize conflicts into one recommendation
  -> Write the conclusion back to memory
```

If you are presenting this project publicly, the most important story is not just which experts are included. The real value is how the pieces are arranged:

- personas provide distinct thinking styles
- the orchestrator chooses, arbitrates, and finalizes
- memory lets the system learn the user's context over time
- references make the rules explicit and reduce drift
- scripts make the suite rebuildable, verifiable, and publishable

## Recommended Usage

### First run

1. Read `GUIDE.md` first, then `SKILL.md`.
2. Put this folder into your skill or workspace directory.
3. Confirm that the five files in `memory/` exist.
4. If you want to rebuild the memory scaffold, run:

```powershell
.\scripts\initialize-memory.ps1
```

5. Start with a concrete financial question, for example:

```text
Use $private-finance-advisory-board to analyze this financial decision with the five-person team and write the conclusion back to memory.
```

### Typical prompts

You will usually get the best results when you ask one decision at a time, such as:

- Should I pay off my credit-card debt first or keep more cash as an emergency fund?
- Is my current cash flow strong enough to start recurring ETF investing?
- Should I switch jobs for higher income if it comes with instability and relocation?
- I want to improve my household insurance coverage. What should I prioritize first?

### After the answer

Review three things:

- whether the selected personas matched the question type
- whether the key assumptions are missing any crucial data
- whether the proposed memory writeback is worth storing for future decisions

If important facts are missing, the suite should ask for the minimum necessary inputs instead of giving a high-confidence answer too early.

## Recommended Workflows

### Workflow A: one-off financial decision

1. Ask a specific question.
2. Let the system read `profile`, `preferences`, and `financial-state`.
3. Let the orchestrator route to the smallest useful specialist set.
4. Save the result into `decision-log`.

### Workflow B: update the financial snapshot before deciding

1. Update `memory/financial-state.md`.
2. Ask the current decision question.
3. Re-evaluate using the latest cash flow, debt, goals, and time constraints.

### Workflow C: carry unresolved questions forward

1. Hit a decision that lacks important data.
2. Let the suite return `needs_more_data`.
3. Store the missing facts and follow-up in `memory/open-questions.md`.
4. Resume once the missing data is available.

## Built-In Scripts

### Initialization and logging

- `scripts/initialize-memory.ps1`
  - creates or restores the five memory files
- `scripts/log-decision.ps1`
  - appends a decision entry to `memory/decision-log.md`
  - also writes to `memory/open-questions.md` when the recommendation is `needs_more_data`

### Validation

- `scripts/validate-package.ps1`
  - validates the core skill package
- `scripts/validate-suite.ps1`
  - validates the full suite, including orchestrator, memory, references, and the four persona bundles

### Packaging

- `scripts/package-skill.ps1`
  - packages the core orchestrator skill without persona bundles
- `scripts/package-suite.ps1`
  - packages the full suite to `dist/private-finance-advisory-board-suite.zip`

## Installation

### Option 1: use the repo directly

```bash
git clone <your-repo-url>
```

Then place `private-finance-advisory-board-suite` inside your skill or workspace directory so your host can read `SKILL.md` and `agents/openai.yaml`.

### Option 2: share the packaged release

Validate first:

```powershell
.\scripts\validate-suite.ps1
```

Then package:

```powershell
.\scripts\package-suite.ps1
```

If you want to distribute only the core orchestrator skill instead of the full persona bundle, use:

```powershell
.\scripts\validate-package.ps1
.\scripts\package-skill.ps1
```

### Versioning

- `v1.0.0` is the first public stable release
- Future releases may add content, but the current workflow should stay compatible
- New users should read `GUIDE.md` before running the suite

## Directory Structure

```text
private-finance-advisory-board-suite/
|- SKILL.md
|- GUIDE.md
|- README.md
|- README.en.md
|- agents/
|  |- openai.yaml
|- memory/
|  |- profile.md
|  |- preferences.md
|  |- financial-state.md
|  |- open-questions.md
|  |- decision-log.md
|- references/
|  |- decision-format.md
|  |- memory-schema.md
|  |- model-policy.md
|  |- orchestration.md
|  |- personas.md
|  |- suite-index.md
|- personas/
|  |- market-mr-xu-jiyuan/
|  |- dave-ramsey/
|  |- ramit-sethi/
|  |- morgan-housel/
|- scripts/
|  |- initialize-memory.ps1
|  |- log-decision.ps1
|  |- package-skill.ps1
|  |- package-suite.ps1
|  |- validate-package.ps1
|  |- validate-suite.ps1
|- dist/
```

## Who This Is For

This suite is especially useful for:

- people who want to turn finance chats into a long-lived decision system
- people who want multiple finance philosophies but still need one final recommendation
- builders who want to publish a reusable finance decision-board architecture on GitHub
- anyone organizing persona logic, memory, routing, and packaging into one distributable repo

It can still answer simple questions.

But the real value shows up when you use it repeatedly, keep memory current, and let decisions get progressively more tailored to the user's actual financial context.

## Related Docs

- `GUIDE.md`
- `references/memory-schema.md`
- `references/orchestration.md`
- `references/model-policy.md`
- `references/personas.md`
- `references/decision-format.md`
- `references/suite-index.md`

## Disclaimer

This is a private-finance decision support skill, not licensed investment, tax, or legal advice. For high-stakes, regulated, or large-money decisions, pair it with qualified professional review.
