# Verification Note

Required for every completed task. Keep it short. Save it in `docs/verification/YYYY-MM-DD-short-title.md`, or add it to the changelog entry for very small changes.

## Template

```markdown
# Verification: short title

- **Date**: YYYY-MM-DD
- **Scope**: what was changed

## Checks run
| Check | Command | Result |
|---|---|---|
| Lint | `npm run lint` | Pass |
| Types | `npx tsc --noEmit` | Pass |
| Tests | `npm test` | 42 passed |
| Build | `npm run build` | Pass |

## Manual verification
- Steps performed and the observed result

## Not verified
- Anything not checked, and why

## Risks
- Known risks or limits of the verification
```

## Rules

- Record the exact command and the result. "Works" is not a result.
- If a check fails, record the failure and the fix, or state that the task is not done.
- Do not claim a check passed if it was not run.
