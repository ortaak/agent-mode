# Git Workflow

## Branches

- `main` is always deployable. Never commit directly to it when a remote or a team exists.
- Create a short-lived branch per task: `feat/<short-name>`, `fix/<short-name>`, `chore/<short-name>`, `docs/<short-name>`.
- Keep branches small and merge them within a few days.

## Commits

- One logical change per commit. Keep commits that build and pass tests.
- Use Conventional Commits:
  - `feat: add cart quantity validation`
  - `fix: prevent negative order totals`
  - `docs: update changelog for v1.2.0`
  - `refactor:`, `test:`, `chore:`, `perf:`, `security:`
- Subject line: imperative mood, 72 characters or fewer. Body: explain why, when it is not obvious.

## Before committing

1. Check `git status` and `git diff`. Do not commit unrelated changes.
2. Confirm that no secrets or generated files are staged.
3. Run the checks from `scripts/check.ps1` or the project's own commands.

## Pull requests

- Title follows the commit convention.
- Description: what changed, why, how it was tested, and any risk or rollback plan.
- Link the changelog entry and the ADR if one exists.

## Forbidden without explicit approval

- `git push --force` to shared branches
- `git reset --hard` on work that is not backed up
- Rewriting published history
- Skipping hooks (`--no-verify`) or signing

## Tags and releases

- Use semantic versioning: MAJOR.MINOR.PATCH.
- Tag releases as `vX.Y.Z` and update the changelog in the same change.
