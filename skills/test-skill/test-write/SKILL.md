---
name: test-write
description: Write behavior tests for uncovered public seams using the practice card's layout, assertions, and mocking rules. Use when the user wants tests added for existing code. Leave production code and existing tests as they are.
metadata:
  author: Naveen Gumaste
  x: https://x.com/Z0D404
  github: https://github.com/NaveenGumaste
---

# Test Write

Write tests for uncovered seams on the stack card. The practice card from test-sources is the only rulebook for layout, names, assertions, fixtures, and mocks. Production files stay as they are. Existing tests stay as they are.

## Action List (mandatory)

```
Findings:
- <app, uncovered seams, practice-card URLs and fetch date>
Will do:
- <new test file> — <seam> — <behavior>
Needs your OK:
- <live service, secret, or a seam that cannot be tested without production edits>
Will not touch:
- <covered seams, existing tests, production files>
```

Proceed with **Will do** after that list. No practice card: stop and load test-sources. Do not write from memory of a framework.

## Procedure

1. **Which seams.** Uncovered seams from test-inspect only. Covered seams are already tested from the outside. The user named a file or feature: that scope only.
2. **How they read.** Follow `files`, `test this`, `avoid`, and `setup` on that app's practice card. Use the runner in `keep existing runner`, or `runner when none is installed` after test-harness.
3. **How many.** One test per uncovered seam for the behavior a caller can observe. Split a seam into several tests only when the card says each behavior is its own test. Do not add a case the card's `avoid` line rejects (private helpers, implementation mocks, whole-tree snapshots), unless that same card says the framework requires it.
4. **Fixtures.** Build data the way `setup` describes. A test that needs network, a paid API, a live database, or a secret is **Needs your OK**. Skip it until they approve. Do not point tests at production services in the meantime.
5. **Style.** Match the repo's imports, formatter, and the card's naming. New files only. Do not edit production code to expose internals. If a seam cannot be reached without a production change, list that change under **Needs your OK** and skip the seam.

## Verify

- Every new file maps to an uncovered seam on the Action List
- Assertions match `test this`; mocks and snapshots match `avoid`
- Existing test files and production files have no edits
- The practice-card URL is still the source named in the Action List

## Done when

The Action List was shown, each approved uncovered seam has the test the card describes, and skipped seams are listed with the reason.

Creator: Naveen Gumaste · [X](https://x.com/Z0D404) · [GitHub](https://github.com/NaveenGumaste)
