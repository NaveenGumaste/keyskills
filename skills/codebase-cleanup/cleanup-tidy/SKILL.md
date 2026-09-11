---
name: cleanup-tidy
description: Remove leftover in-file noise — unused imports, commented-out blocks, and debug console.log — without deleting files or changing behavior. Use when the user says unused imports, console.log, commented-out code, leftover comments, or tidy this file.
metadata:
  author: Naveen Gumaste
  x: https://x.com/Z0D404
  github: https://github.com/NaveenGumaste
---

# Cleanup Tidy

Inspect first. Edit in place. Do not delete files, uninstall packages, or restyle. Dead files: cleanup-files. Packages: cleanup-deps. Lint: cleanup-lint.

## Action List (mandatory)

Read-only until this is in the user-visible reply:

```
Findings:
- <runner, generated folders>
Safe to tidy (edit, no delete):
- <path> — <edit> — <evidence>
Already keeping:
- <path> — <why, e.g. feature-flag log>
Will not touch:
- <setup, generated, dead files/deps/lint (name the sibling)>
```

Proceed with **Safe to tidy** after that list. A log that might be a feature flag, telemetry, or server diagnostic is **Already keeping** — do not treat "clean this up" as approval to strip it.

## Procedure

1. **Inspect.** Package runner (Bun / pnpm / npm / yarn). Generated folders (`dist`, `.next`, `coverage`, vendor) — do not edit them. Work only in files the user named, or files already in the current task.
2. **Unused imports** in those files. Evidence: the binding is unreferenced after following local re-exports. Dynamic `import()`, string paths, and CSS `@import` keep the import.
3. **Commented-out blocks** that are not documenting a constraint. Leave TODOs and license headers.
4. **`console.log` / debug prints** that are not a feature flag or documented diagnostic. Delete the statement, not the file.

Do not: delete/move files, change behavior, mass-format, swap libraries, touch `.env`, or add a linter. Bun repos: `bun` only.

## Verify

- `git diff` is import/comment/log edits only — no file deletes, no formatter sweep
- Feature-flag / diagnostic logs still present
- Generated folders and setup files unchanged
- App still typechecks if a check script exists

## Done when

The list was shown; only listed in-file noise was removed; every file still exists; the user can see path-by-path edits and sibling handoffs.

Creator: Naveen Gumaste · [X](https://x.com/Z0D404) · [GitHub](https://github.com/NaveenGumaste)
