# Changelog Entry

Required for every completed task. Add to `CHANGELOG.md` at the project root under `## [Unreleased]`. Move entries to a version heading at release time.

## Format

```markdown
## [Unreleased]

### Added
- Cart quantity limit per item (`cart.service.ts`)

### Changed
- Order total now includes tax rounding per line

### Fixed
- Negative totals when a coupon exceeds the cart value

### Security
- Refresh tokens are revoked on password change
```

## Rules

- Categories: Added, Changed, Deprecated, Removed, Fixed, Security.
- One line per user-visible or developer-visible change. Start with a verb.
- Mention the affected area in backticks when useful.
- Breaking changes are prefixed with `BREAKING:`.
- No internal noise (refactors without behavior change go under `Changed` only if they affect developers).
