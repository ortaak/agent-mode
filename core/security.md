# Security Baseline

Based on the OWASP Top 10 and common secure-development practice. Apply to every project.

## Secrets

- Never commit secrets. Store them in environment variables or a secrets manager.
- Keep `.env` and key files in `.gitignore`. Commit only `.env.example` with placeholder values.
- Never print secrets in logs, error messages, test output or documentation.
- If a secret is exposed, rotate it immediately. Removing it from the latest commit is not enough.
- Use separate secrets for development, staging and production.

## Input and output

- Validate all input at the boundary with a schema (for example Zod, Pydantic, or JSON Schema). Reject unknown fields where practical.
- Use parameterized queries or an ORM. Never concatenate user input into SQL, shell commands, file paths or HTML.
- Encode output for its context. Avoid `dangerouslySetInnerHTML`, `eval`, and similar APIs.
- Limit request body size and rate-limit public endpoints.

## Authentication and authorization

- Hash passwords with a modern algorithm (argon2, bcrypt, scrypt). Never store plain or reversible passwords.
- Check authorization on the server for every request. Client-side checks are for UX only.
- Check object ownership, not just login state (prevents IDOR).
- Use short-lived access tokens and revocable refresh tokens. Store tokens in secure storage on mobile, not in plain AsyncStorage when avoidable.
- Use HTTPS everywhere. Set secure cookie flags when cookies are used.

## Web and API

- Set CORS to an explicit allow-list. Never use `*` with credentials.
- Send security headers (HSTS, CSP, X-Content-Type-Options) on web apps.
- Return generic error messages to clients. Keep stack traces in server logs only.
- Set timeouts and size limits on outbound HTTP requests.

## Dependencies

- Pin versions with a lock file and commit it.
- Run `npm audit`, `pip-audit` or the equivalent before release.
- Remove unused dependencies.

## Data

- Collect only the personal data the feature needs.
- Encrypt sensitive data at rest where required.
- Make deletion (including soft delete) and data export paths explicit in the design.

## Mobile-specific

- Do not embed private API keys in the app bundle. Any value in the bundle is public.
- Use certificate pinning only if the threat model requires it, and document the rotation plan.

## Review checklist (run before release)

- [ ] No secrets in code, config committed, or history
- [ ] All inputs validated at boundaries
- [ ] Authorization checked server-side for each protected action
- [ ] Error responses do not leak internals
- [ ] Dependencies audited, no known critical issues
- [ ] Logs contain no personal data or secrets
