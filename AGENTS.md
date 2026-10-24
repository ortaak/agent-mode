# Agent Instructions

Model-neutral instructions for any AI coding agent (Claude, Codex, local models).
Read this file first. Then use `.agent-mode/INDEX.md` to pick only the extra files the task needs.

## 1. Session start (keep it cheap)

1. Read `docs/project-state.md`. If it does not exist, create it from `.agent-mode/templates/project-state.md`.
2. If `docs/handoff.md` exists and describes the current task, read it. Then continue from its "Next steps".
3. Find code with search (glob/grep) before opening files. Read only the lines you need.
4. Do not scan the whole repository unless the task requires it.

## 2. Working rules

- One task at a time. For changes touching more than 3 files, write a short plan first.
- Make the smallest change that solves the task. Prefer editing existing code over adding abstractions (YAGNI).
- Verify APIs, names and config by reading the code. Do not invent them.
- Ask the human only when blocked. Otherwise choose the most reasonable option and state the assumption.
- Report results faithfully. If a test or check fails, say so and show the relevant output.

## 3. Safety rules (non-negotiable)

- Never print, log, or commit secrets: `.env`, private keys, tokens, credentials.
- Never run destructive commands without explicit approval: `rm -rf`, `git push --force`, `git reset --hard`, dropping tables, running migrations against production, deleting branches.
- Validate all external input. Never build SQL, shell commands or HTML from raw input.
- Add new dependencies only when needed. Check that they are maintained and have no known critical vulnerabilities.
- Details: `.agent-mode/core/security.md`.

## 4. Token economy

- Search before reading. Read specific line ranges, not whole large files.
- Do not re-read a file that has not changed in this session.
- Summarize command output. Use `head`, `tail`, or grep on logs. Never paste full logs into the conversation.
- Run independent commands in one batch.
- Refer to code as `path:line`, not by copying it.
- Split large tasks into small, independently verifiable steps.

## 5. Definition of Done

A task is done only when `.agent-mode/workflow/definition-of-done.md` is satisfied. In short:

1. Relevant checks pass (`.agent-mode/scripts/check.ps1` or the project's own commands).
2. A changelog entry is added (`.agent-mode/docs-required/changelog-entry.md`).
3. `docs/project-state.md` is updated.
4. A verification note is written (`.agent-mode/docs-required/test-report.md`).
5. If a technical decision was made, an ADR is written (`.agent-mode/docs-required/adr.md`).

## 6. Ending a session

If the task is unfinished, or the context is getting long, write `docs/handoff.md` using `.agent-mode/docs-required/handoff.md` before stopping. A new session (or a different model) must be able to continue from that file alone.
