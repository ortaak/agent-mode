# agent-mode

A portable, model-neutral kit of rules, workflows, and templates for AI-assisted software development. It is designed to be copied into any project, so every agent (Claude, Codex, or a local model) follows the same engineering, security, and documentation standards with a small token footprint.

## Contents

| Path | Purpose |
|---|---|
| `AGENTS.md` | Main instructions. Read first by any agent. |
| `CLAUDE.md` | Claude-specific notes; points to `AGENTS.md`. |
| `INDEX.md` | Router: which file to read for which task. |
| `core/` | Engineering principles, security baseline, git workflow. |
| `workflow/` | Task lifecycle and definition of done. |
| `docs-required/` | Templates for changelog, ADR, verification note, handoff. |
| `templates/` | Project state and task templates. |
| `prompts/short-prompt.md` | One-page version for small or local models. |
| `scripts/install.ps1` / `install.sh` | Copies the kit into a project. |
| `scripts/check.ps1` | Detects project type and runs its checks with a short summary. |
| `VERSION` | Kit version. |

## Install into a project

Windows (PowerShell):
```powershell
C:\Users\User\Documents\PROJELER\agent-mode\scripts\install.ps1 -Target "C:\Users\User\Documents\PROJELER\my-project"
```

macOS / Linux / Git Bash:
```bash
/path/to/agent-mode/scripts/install.sh /path/to/my-project
```

This creates:
- `<project>/.agent-mode/` containing the full kit
- `<project>/AGENTS.md` and `<project>/CLAUDE.md` (only if missing)
- `<project>/docs/project-state.md`, `<project>/docs/decisions/`, `<project>/CHANGELOG.md` (only if missing)

Existing project files are never overwritten.

## Update an installed project

```powershell
.\install.ps1 -Target "C:\...\my-project" -Update
```

This refreshes `.agent-mode/` only. Your `AGENTS.md`, `CHANGELOG.md` and `docs/` are untouched. Check `.agent-mode/VERSION` before and after to confirm the change. Review the kit diff before committing an update.

## Use with an AI agent

1. Start the agent in the project root. Claude reads `CLAUDE.md`; other agents read `AGENTS.md`.
2. Ask for a task. The agent reads `docs/project-state.md`, then the files it needs from `INDEX.md`.
3. At the end, the agent completes the required documents from `workflow/definition-of-done.md`.
4. If credits run out or you switch models, ask for a `docs/handoff.md`. A different agent can continue from that file.

For small or local models, paste `prompts/short-prompt.md` as the system prompt.

## Design goals

- **Model-neutral**: plain Markdown, no tool-specific syntax required.
- **Token-efficient**: router file, state file, and handoff file replace re-reading the repo.
- **Safe by default**: secrets, destructive actions, and input validation are covered in `AGENTS.md` and `core/security.md`.
- **Portable**: no dependency on any stack. Stack-specific checks are detected by `check.ps1`.
- **Traceable**: every change leaves a changelog entry, a state update, and a verification note.

## Maintenance

- Edit the kit in this folder only. Projects receive changes through `-Update`.
- Bump `VERSION` (SemVer) for every change to rules or templates. Add a short note to this README's history below.

## History

- 1.0.0: Initial kit.
