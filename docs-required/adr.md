# Architecture Decision Record (ADR)

**Required when a technical decision is made**: choosing a library, framework, database, architecture pattern, auth method, or anything that is hard to reverse. Not required for routine implementation.

Save as `docs/decisions/NNNN-short-title.md`, where NNNN is the next number (0001, 0002, ...). Never edit an accepted ADR's decision. Supersede it with a new ADR instead.

## Template

```markdown
# NNNN: Short title in imperative form

- **Status**: Proposed | Accepted | Superseded by NNNN
- **Date**: YYYY-MM-DD

## Context
What problem or constraint led to this decision? Include relevant requirements.

## Options considered
1. Option A: one-line description. Pros / cons.
2. Option B: one-line description. Pros / cons.

## Decision
What was chosen, and the main reason.

## Consequences
- Positive:
- Negative / trade-offs:
- Follow-up tasks:
```

## Rules

- Keep it under one page.
- Record the options that were rejected and why. This prevents the same debate later.
- Link the ADR from `docs/project-state.md`.
