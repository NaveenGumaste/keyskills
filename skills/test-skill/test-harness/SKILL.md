---
name: test-harness
description: Add the test runner, config, and test script from the practice card when the repo does not already have them. Use when tests cannot run because the harness is missing. Keep an existing runner.
metadata:
  author: Naveen Gumaste
  x: https://x.com/Z0D404
  github: https://github.com/NaveenGumaste
---

# Test Harness

Install only what the practice card from test-sources names, and only where the stack card says the runner or the test script is missing. No tests in this step. No production edits.

## Action List (mandatory)

```
Findings:
- <app, existing runner, existing test script, package manager>
Will do:
- <file or package> — <from the practice card>
Needs your OK:
- <replace a runner, add a second framework>
Will not touch:
- <existing runner, existing tests, production code>
```

Proceed with **Will do** after that list. Missing practice card: stop and load test-sources. Do not pick a tool from memory.

## Procedure

1. **Keep what runs.** `keep existing runner` is set: leave that dependency and its config. Add a `test` script only when the manifest has none, using `command` on the card. A missing script is not permission to replace the runner.
2. **Install when nothing is there.** No runner on the stack card: add `runner when none is installed` and the config files the card's `setup` and `files` lines name. Dev dependency unless the card says the tool is required at runtime.
3. **Package manager.** The lockfile test-inspect named. One lockfile. Update that lockfile only. Bun repos stay on Bun. Do not introduce a second installer.
4. **Scope.** One harness per app on the stack card. A browser or end-to-end tool is installed only when the card names it as the runner for this app.
5. **Stop list.** Replacing the installed runner, or adding another framework next to it, is **Needs your OK** on the router. Do not do it in **Will do**.

Match the repo's module style and formatter. Do not add CI, git hooks, or coverage gates. Those are other suites, and only when the card's `setup` says the framework's own starter includes that file.

## Verify

- The test script matches `command` for each app that had none
- A repo that already had a runner still has that same runner
- New packages are the card's runner, recorded in the existing lockfile
- No test bodies and no production edits in this step

## Done when

The Action List was shown, missing harness pieces from the card are installed, and an existing runner is unchanged.

Creator: Naveen Gumaste · [X](https://x.com/Z0D404) · [GitHub](https://github.com/NaveenGumaste)
