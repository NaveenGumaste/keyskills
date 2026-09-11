---
name: cleanup-deps
description: Find packages unused in code, scripts, CI, and config; list evidence; then uninstall or keep. Default is keep. Use when the user says unused dependencies, unused packages, prune deps, remove unused libraries, or uninstall dead packages.
metadata:
  author: Naveen Gumaste
  x: https://x.com/Z0D404
  github: https://github.com/NaveenGumaste
---

# Cleanup Deps

Talk first. Default for anything uncertain: **keep**. Do not swap the package manager. Dead files: cleanup-files. Lint toolchain: cleanup-lint.

## Action List (mandatory)

Read-only until this is in the user-visible reply. Do not uninstall until the user answers.

```
Findings:
- <runner, lockfile, lint/test/build scripts>
Ask you (one choice per package):
- <package>
  Why it looks unused: <search: code, scripts, CI, config>
  Risk if wrong: <PostCSS/ESLint/Tailwind/plugin load>
  Choose: uninstall  |  keep
Will not touch:
- <lockfile itself, packages used in config/CI, second lockfile>
Already keeping:
- <package> — <why>
```

Stop after that list. "Clean this up" is not an answer. Unanswered packages: **keep**.

## Procedure

1. **Inspect.** Runner from the lockfile: Bun (`bun.lock` / `bun.lockb`) → `bun`; else pnpm, npm, yarn. Use that runner only. Do not add a second lockfile. Do not upgrade majors.
2. **Used if referenced in any of:** source, `package.json` scripts, CI, PostCSS, ESLint, Tailwind, framework config, binaries invoked by scripts. Thin evidence (string package name, optional peer, plugin loaded by convention): **Already keeping**.
3. **Uninstall** only packages they marked uninstall, with the repo's runner (`bun remove`, `pnpm remove`, `npm uninstall`, `yarn remove`). Then search again for leftover imports of that package.
4. Do not: add a linter or formatter to justify a removal, edit generated output, or change `package.json` scripts other than dropping the chosen dependency.

## Verify

- Only chosen packages left the manifest and lockfile
- Remaining scripts, CI, and config still resolve
- No leftover imports of uninstalled packages
- Unanswered packages still installed
- One lockfile; same package manager as before

## Done when

The list was shown; every uninstall had an explicit choice (everything else kept); the app still installs and the existing check scripts still run.

Creator: Naveen Gumaste · [X](https://x.com/Z0D404) · [GitHub](https://github.com/NaveenGumaste)
