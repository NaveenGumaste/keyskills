---
name: cleanup-files
description: Find unused files, stubs, duplicates, dead CSS, and unused internal exports; list evidence; then delete, archive, or keep. Default is keep. Use when the user says clean this repo, remove unused code, dead files, unused components, unused exports, or leftover templates.
metadata:
  author: Naveen Gumaste
  x: https://x.com/Z0D404
  github: https://github.com/NaveenGumaste
---

# Cleanup Files

Talk first. Keep the app working. Default for anything uncertain: **keep**. In-file noise: cleanup-tidy. Packages: cleanup-deps. Secrets/junk: cleanup-secrets.

## Action List (mandatory)

Inspect is read-only. Do not edit, move, or delete until the user has seen the list and answered.

```
Findings:
- <runner, framework, public routes, setup files>
Ask you (one choice per item):
- <path>
  Why it looks unused: <search you ran>
  Risk if wrong: <what logic or setup could break>
  Choose: delete  |  archive (say where)  |  keep
Will not touch:
- <setup, public API, generated, design, SEO, git history, deps/lint/a11y>
Already keeping:
- <path> — <why>
```

Stop after that list. "Clean this up" is not an answer. If they name one file, apply their choice to that file only. Unanswered items: **keep**.

## Choices

- **Keep** (default) — leave the file or export exactly as it is.
- **Archive** — `git mv` to a path the user names. Do not invent `_archive/` or delete after copy. No destination: ask once, then keep.
- **Delete** — only items they marked delete, after evidence. Then search again so leftover imports are gone.

Never mix choices.

## Setup (Will not touch unless they named that exact file)

Package manager, lockfile, `package.json` scripts, tsconfig, path aliases, CI, Docker, env examples, framework config (`next.config`, `vite.config`, `tailwind.config`), entry files, layouts, route files that still resolve, package `exports`.

Thin evidence (dynamic `import()`, string path, CMS slug, CSS-only import, config reference, feature flag): **Already keeping**. Say why.

Do not rewrite features, swap UI/state libraries, change folder architecture, upgrade majors, add a linter, mass-format, or edit generated output (`dist`, `.next`, `coverage`, vendor). Bun repos: `bun` only.

## Procedure

1. **Inspect.** Runner, framework, entrypoints (`app/`, `src/`, `components/`, `lib/`), generated folders, public API / routes / package `exports`.
2. **Search** before any delete proposal: imports, re-exports, dynamic `import()`, string paths, CSS `@import`, test fixtures, CI, README scripts.
3. **Files** — unused files, stubs, duplicates, dead CSS. Evidence must include the search. Then wait.
4. **Exports** — unused internals only. Keep public APIs, barrels used outside the folder, and package `exports`.
5. **Rename** — only if asked. Prefer `git mv`. Do not restyle the tree.

Keep cleanup commits separate from features (git-commit).

## Verify

- Existing typecheck / lint / test scripts pass after chosen edits only
- App boots; primary routes still render; setup unchanged unless chosen
- `git diff` matches the choices (no extra deletes, no formatter sweep)
- Deleted paths have no remaining imports. Archived paths exist at the named destination
- Unanswered items are still in place

## Done when

The list was shown; every delete/archive had an explicit choice (everything else kept); logic, routes, and setup still work; the user can see what was deleted, archived (and where), and kept.

Creator: Naveen Gumaste · [X](https://x.com/Z0D404) · [GitHub](https://github.com/NaveenGumaste)
