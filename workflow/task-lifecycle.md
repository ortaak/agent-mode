# Task Lifecycle

Every task follows these steps. Skip a step only when it clearly does not apply, and say so.

## 1. Understand (cheap)

- Restate the goal in one or two sentences.
- Identify the affected area with search. Do not read the whole project.
- List open questions. Ask only if the answer changes the implementation.

## 2. Plan (short)

- For changes touching more than 3 files, or changing a public interface, write a plan of at most 10 bullet points.
- Fill in `templates/task.md` if the task is significant.
- Identify what will be verified and how.

## 3. Implement (small steps)

- Make one change, verify it, then make the next. Do not batch unrelated edits.
- Keep the existing style and structure.
- Add or update tests with the change.

## 4. Verify

- Run the relevant checks (`scripts/check.ps1` or project commands).
- Manually check the behavior when tests cannot cover it, and note what you checked.
- If something fails, fix the cause. Do not weaken or delete tests to make them pass unless the test itself is wrong, and say why.

## 5. Document

- Write the required documents from `workflow/definition-of-done.md`.
- Update `docs/project-state.md`.

## 6. Report

Finish with a short report:
- What changed (file list with short descriptions)
- What was verified and the result
- What is not done, and known risks
- Next steps

## Stop conditions

Stop and ask the human when:
- A destructive or irreversible action is needed
- Requirements conflict
- A secret or credential is required
- The change would affect production data or public contracts in a way not described in the task
