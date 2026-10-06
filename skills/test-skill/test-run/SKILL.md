---
name: test-run
description: Run the project's test command, fix failures that are wrong test setup, and report product failures without changing application code or weakening assertions. Use when the user says run the tests, or after test-write adds tests.
metadata:
  author: Naveen Gumaste
  x: https://x.com/Z0D404
  github: https://github.com/NaveenGumaste
---

# Test Run

Run the tests. Fix test files when the failure is the test. Report the failure when the application did something else. Do not change production code, and do not weaken an assertion to get a pass.

## Action List (mandatory)

```
Findings:
- <app, command, runner>
Will do:
- run: <exact command>
- fix test setup if the failure is an import, config, or a fixture the practice card already requires
Needs your OK:
- <production change, deleting a test, live credentials>
Will not touch:
- <production code, passing tests, the existing runner>
```

Proceed and run after that list. Command: the practice card's `command` when this run wrote a card; otherwise the test script test-inspect found. No command anywhere: stop and load test-harness. Do not invent a binary.

## Procedure

1. **Run** the command in that app's directory, with the package manager from the stack card. One run per app.
2. **Test-setup failure.** Missing import, wrong config, wrong path, or a fixture `setup` on the practice card already requires: fix the test or the harness file and re-run. Keep the assertion.
3. **Product failure.** The assertion describes behavior the application does not have: stop on that test. Quote the assertion and the actual result. Leave production code unchanged. Leave the assertion unchanged. That production edit is **Needs your OK**.
4. **Existing red tests.** Failures in tests this suite did not add: report them. Do not rewrite them and do not "fix" the application.
5. **Re-run** after test-setup fixes only. Stop when new tests pass, or when the remaining failures are product failures and pre-existing red tests.

A flaky failure stays a failure. Do not delete the test or loop until it happens to pass.

## Verify

- The command that ran is the one on the Action List
- New tests pass, or each remaining failure is quoted as a product failure or a pre-existing red test
- The production diff is empty
- The runner is the one inspect recorded, unless a router **Needs your OK** replaced it

## Done when

The user can see the command, the pass or the quoted failures, and the test files that changed during setup fixes.

Creator: Naveen Gumaste · [X](https://x.com/Z0D404) · [GitHub](https://github.com/NaveenGumaste)
