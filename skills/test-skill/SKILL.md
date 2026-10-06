---
name: test-skill
description: Testing suite — detect the project's framework, fetch that framework's current official and expert testing guidance, add the matching harness, write behavior tests, and run them. Selecting this skill installs test-inspect, test-sources, test-harness, test-write, and test-run. Use when the user says test this, add tests, write tests, set up testing, or run the tests.
metadata:
  author: Naveen Gumaste
  x: https://x.com/Z0D404
  github: https://github.com/NaveenGumaste
---

# Test

This file is the router. Selecting **test-skill** installs every sub-skill in this folder. Do not inspect, fetch, install, write tests, or run them from here. Read the listed `SKILL.md`.

One request ("test this", "add tests") runs the full order below. The user does not pick the runner, the folder layout, or the assertion style. Those come from the repo and from the practice card.

## Mandatory order

```
1. test-inspect    always. Stack card. Read-only.
2. test-sources    practice card from the internet, one per framework on the stack card.
3. test-harness    only where the card's runner or test script is missing.
4. test-write      uncovered seams on the stack card, using the practice card.
5. test-run        run the card's command. End on a real pass or a reported product failure.
```

Show each skill's Action List, then do its **Will do**. Do not wait between skills. Stop only for **Needs your OK** or when test-sources cannot fetch.

A named slice still starts at test-inspect. "Run the tests" skips sources, harness, and write when a test script already exists. "Just the harness" stops after test-harness.

## When to trigger each skill

| Skill | Read | Trigger | Skip |
| --- | --- | --- | --- |
| [test-inspect](test-inspect/SKILL.md) | always | any test request | — |
| [test-sources](test-sources/SKILL.md) | after inspect | harness, new tests, or no test command in the repo | "run the tests" and a test script already exists |
| [test-harness](test-harness/SKILL.md) | after sources | no runner, or no test script | runner and script already match the card |
| [test-write](test-write/SKILL.md) | after harness | an uncovered seam | they only asked to run, or every listed seam is covered |
| [test-run](test-run/SKILL.md) | last | "test this", "add tests", or "run the tests" | inspect found no application code |

There is no supported-framework list. An unrecognized stack is still inspected and looked up.

## Needs your OK

Stop before any of these. "Test this" is not approval.

- Replace or remove the repo's existing test runner
- Add a second test framework beside one that is already installed
- Delete, rewrite, or weaken an existing test
- Change production code so a test turns green
- A test that needs network, a paid API, a live database, or a secret

Git, DevOps, SEO, design, and cleanup are other suites. Do not commit, add CI, rewrite UI, or mass-format the tree. `devops-ci` runs a test script that already exists; this suite is what creates that script.

## Direct paths

- `test-inspect/SKILL.md`
- `test-sources/SKILL.md`
- `test-harness/SKILL.md`
- `test-write/SKILL.md`
- `test-run/SKILL.md`

Creator: Naveen Gumaste · [X](https://x.com/Z0D404) · [GitHub](https://github.com/NaveenGumaste)
