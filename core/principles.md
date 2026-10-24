# Engineering Principles

## Core principles

- **KISS**: choose the simplest design that meets the current requirement.
- **YAGNI**: do not build features or abstractions for hypothetical future needs.
- **DRY, with judgment**: remove duplication only when the same knowledge must change together. Two similar lines are cheaper than a wrong abstraction.
- **Single responsibility**: each module, function and component does one thing and has one reason to change.
- **Explicit over implicit**: clear names, explicit types where the language supports them, no hidden side effects.
- **Composition over inheritance**: prefer small functions and injected dependencies.

## Design

- Separate layers: input handling, business logic, data access, presentation. Business logic must not depend on the UI or transport layer.
- Depend on interfaces at boundaries (database, network, third-party services) so they can be replaced and tested.
- Keep public APIs small. Hide internals.
- Make illegal states unrepresentable (types, enums, validation at boundaries).

## Errors and logging

- Fail early and loudly on programmer errors. Handle expected failures explicitly.
- Never swallow errors silently. Empty `catch` blocks are not allowed.
- Return consistent error shapes across an API.
- Log events with context (what, where, identifiers) but never secrets or personal data.
- Use stable error codes that clients can act on.

## Testing

- Every behavior change has a test. Every bug fix has a regression test.
- Test behavior, not implementation details.
- Keep tests fast and deterministic. No dependence on wall-clock time, network or random order without control.
- Prefer a small number of meaningful tests over high coverage numbers.

## Performance

- Measure before optimizing.
- Avoid N+1 queries; paginate lists; set timeouts on every external call.
- Keep bundles and dependencies small.

## Code quality

- Follow the existing style of the project. Consistency beats personal preference.
- Comments explain why, not what. Remove commented-out code.
- No dead code, no unused dependencies, no TODOs without an owner or a linked task.
- Keep functions short enough to read without scrolling.
