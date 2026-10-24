# Handoff

Write `docs/handoff.md` (overwrite the previous one) when:
- the task is not finished and the session is ending,
- the context is getting long,
- the work moves to another model, tool, or person.

The file must let a new agent continue without reading the whole conversation or repository.

## Template

```markdown
# Handoff

- **Date**: YYYY-MM-DD HH:MM
- **Model/tool**: (for example Claude, Codex, local model name)
- **Branch**: feat/xyz
- **Task**: one-sentence goal

## Status
- Done:
  - ...
- In progress:
  - file `path/to/file.ts` - what is half-done and where
- Not started:
  - ...

## Files changed
- `path/to/file.ts` - what changed and why

## Verification
- Command run: `npm test` - result: 42 passed, 1 failed (`cart.test.ts:88`)
- Not yet verified: ...

## Decisions made this session
- Short bullet list; link ADRs if any were created

## Known issues and risks
- ...

## Next steps (ordered)
1. Exact first action, with file and line if known
2. ...

## Context the next agent must know
- Non-obvious constraints, gotchas, or things already tried that failed
```

## Rules

- Be specific: file paths and line numbers, not general statements.
- Do not paste code longer than 10 lines. Reference the file instead.
- Delete the handoff file once the task is complete and the state is recorded in `docs/project-state.md`.
