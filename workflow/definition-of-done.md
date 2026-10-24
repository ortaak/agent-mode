# Definition of Done

A task is done only when every applicable item is checked.

## Code

- [ ] Change does what the task asked, nothing more
- [ ] Checks pass: lint, type check, tests, build
- [ ] New behavior has tests; bug fixes have regression tests
- [ ] No secrets, debug output, commented-out code or unused dependencies added
- [ ] Input validation and authorization handled for new endpoints or actions
- [ ] Error handling does not swallow failures

## Documents (required)

- [ ] **Changelog entry** added: `docs-required/changelog-entry.md`
- [ ] **Project state** updated: `docs/project-state.md`
- [ ] **Verification note** written: `docs-required/test-report.md`
- [ ] **ADR** written if a technical or architectural decision was made: `docs-required/adr.md`
- [ ] **Handoff** written if the task is not finished: `docs-required/handoff.md`

## Other (when applicable)

- [ ] API change documented (endpoint, request, response, error codes)
- [ ] Configuration or environment variables added to `.env.example`
- [ ] Migration written and tested on a copy of the data
- [ ] Security checklist reviewed (`core/security.md`) for auth, data or dependency changes

## Reporting

- [ ] Final report lists changed files, verification results and open risks
- [ ] Any check that was not run is stated explicitly
