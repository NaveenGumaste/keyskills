---
name: cleanup-lint
description: Fix real issues with the repo's existing lint, format, and typecheck scripts. Do not add a toolchain or mass-format the tree. Use when the user says fix lint, format, eslint, prettier, typecheck errors, or lint noise.
metadata:
  author: Naveen Gumaste
  x: https://x.com/Z0D404
  github: https://github.com/NaveenGumaste
---

# Cleanup Lint

Inspect first. Use the checker that already exists. Do not add ESLint/Prettier/Biome. In-file debug noise: cleanup-tidy. Dead files: cleanup-files.

## Action List (mandatory)

Read-only until this is in the user-visible reply:

```
Findings:
- <lint/format/typecheck commands, or none>
Will do:
- <file> — <rule or error> — <fix>
Needs your OK:
- <fix that would change runtime behavior>
Will not touch:
- <files without findings, generated folders, a missing toolchain>
```

Proceed with **Will do** after that list. Stop on **Needs your OK**. "fix lint" is not approval to disable rules, change behavior, or format the whole tree.

**Needs your OK**

- A fix that changes runtime behavior to satisfy a rule
- Mass-format of files with no lint error
- Disable or add a lint rule
- Add a linter, formatter, or typecheck script that is not already there

## Procedure

1. **Inspect.** `package.json` scripts and config (ESLint, Prettier, Biome, oxlint, `tsc`). Runner: Bun if `bun.lock`/`bun.lockb`, else the repo's. No checker: say so and stop — do not add one.
2. Run the existing lint, then format (if a format script exists), then typecheck. Do not invent scripts.
3. Fix real findings in files that already have errors. Smallest change. Match existing code style.
4. Do not: mass-format the tree, mass-disable rules, edit `dist` / `.next` / `coverage` / vendor, swap the package manager, or "clean" files that only need cleanup-tidy / cleanup-files.

## Verify

- Existing lint / format / typecheck scripts pass on the files you touched
- `git diff` is the listed fixes only — no repo-wide format sweep
- Behavior-changing fixes were approved or skipped
- No new toolchain or second lockfile

## Done when

The Action List was shown; listed errors are fixed or skipped with OK; no checker was added; the user can see file-by-file fixes.

Creator: Naveen Gumaste · [X](https://x.com/Z0D404) · [GitHub](https://github.com/NaveenGumaste)
