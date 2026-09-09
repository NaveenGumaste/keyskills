---
name: codebase-cleanup
description: Inspect a codebase and propose cleanup without breaking logic or setup. List every candidate with evidence, then ask the user to delete, archive somewhere else, or keep. Default is keep. Use when the user asks to clean up, declutter, remove unused code, fix lint, or prepare a repo for resume/production quality.
---

# Codebase Cleanup

Talk first. Keep the app working. Do not destroy logic, setup, or architecture.

Default for anything uncertain: **keep**. Nothing is deleted, moved, or uninstalled until the user picks an option for that item.

## Show the user first (mandatory)

Inspect is read-only. Do not edit, move, delete, or change dependencies until the user has seen the list and answered.

Write the list in plain language. For every risky item, ask **delete / archive / keep**.

```
Findings:
- <package manager, framework, lint/test commands, public routes, setup files>

Safe to tidy (no delete):
- <path> — <small edit> — <evidence>

Ask you (one choice per item):
- <path or package>
  Why it looks unused: <search you ran>
  Risk if wrong: <what logic or setup could break>
  Choose: delete  |  archive (say where)  |  keep

Will not touch:
- <setup, public API, generated folders, design, SEO, git history>

Already keeping:
- <path> — <why it must stay>
```

Stop after that list. Do not proceed on **Ask you** items until the user answers. "Clean this up" is not an answer. If they name one file, apply their choice to that file only.

If they do not answer an item, **keep** it.

## Choices

- **Keep** (default) — leave the file, export, or dependency exactly as it is.
- **Archive** — `git mv` to a path the user names. Do not invent `_archive/` or delete after copy. If they do not name a destination, ask once, then keep.
- **Delete / uninstall** — only the items they marked delete, and only after evidence was shown. Then search again so no leftover imports remain.

Never mix choices. Do not delete a file they asked to archive. Do not archive a file they asked to keep.

## Keep it safe

Do not break runtime logic, routes, public API, or project setup.

Treat these as setup. List them under **Will not touch** unless the user named that exact file:

- Package manager, lockfile, `package.json` scripts, tsconfig, path aliases
- CI, Docker, env examples, framework config (`next.config`, `vite.config`, `tailwind.config`)
- Entry files, layouts, route files that still resolve, package `exports`

If evidence is thin (dynamic `import()`, string path, CMS slug, CSS-only import, config reference, feature flag), it is **Already keeping**. Say why. Do not put it on the delete list.

Do not:

- Rewrite features, swap UI/state libraries, or change folder architecture
- Upgrade majors, add a linter, or swap the package manager
- Mass-format the tree or mass-disable lint rules
- Change behavior to satisfy a lint rule (ask first)
- Edit generated output (`dist`, `.next`, `coverage`, vendor)
- Touch `.env` values (report only). Keep `.env.example`

Bun repos: use `bun`. Do not add a second lockfile.

## When to use

- "Clean this repo", "remove unused code", "it's messy"
- Unused dependencies, dead components, leftover templates
- Lint/format noise, leftover `console.log`, commented-out blocks
- Preparing a project to look production-ready

## When not to use

- Greenfield feature work (use the relevant feature skill)
- Visual redesign (use design-skill)
- SEO implementation (use seo-setup)
- Git history surgery (use git-skill)

## Inspect first (read-only)

1. Package manager and scripts (Bun, pnpm, npm, yarn). Use the repo's runner.
2. Framework and entrypoints. Map `app/`, `src/`, `components/`, `lib/`.
3. Existing lint, format, tsconfig, and CI. Do not add a new toolchain.
4. Identify generated folders and do not hand-edit them.
5. Note public API / routes / sitemap / package `exports`.
6. Search before proposing a delete: imports, re-exports, dynamic `import()`, string paths, CSS `@import`, test fixtures, CI configs, README scripts.

## Order of work

Only items that appeared in the list, after the user chose.

1. **Safe to tidy** — unused imports in a file already being edited, leftover comments, debug `console.log` that is not a feature flag. List them first. Do not delete the file they live in.
2. **Files** — unused files, stubs, duplicates, dead CSS. Evidence must include the search. Then wait for delete / archive / keep.
3. **Exports** — unused internals only. Keep public APIs, barrels used outside the folder, and package `exports`.
4. **Dependencies** — unused in code, scripts, CI, and config (PostCSS, ESLint, Tailwind). Uninstall only if they chose delete.
5. **Secrets and junk** — report stray debug files and `.env` with values. Same three choices. Keep `.env.example`.
6. **Consistency / rename** — only if asked. Prefer `git mv`. Do not restyle the whole tree.
7. **Lint/format** — existing checker only; fix real issues in files you already have reason to touch.
8. **A11y/HTML hygiene** if UI exists — button vs div, labels, alt. Not a redesign.

Cleanup commits stay separate from features when git-skill is also in play.

## Verify

- Typecheck / lint / test scripts that already exist, after chosen edits only
- App still boots; primary routes still render; setup files unchanged unless chosen
- `git diff` matches the user's choices (no extra deletes, no surprise formatter sweep)
- Deleted paths have no remaining imports. Archived paths exist at the destination the user named
- Items with no answer are still in place

## Done when

- The list was shown, and every delete/archive had an explicit choice (everything else kept)
- Logic, routes, and setup still work
- User can see what was deleted, archived (and where), edited, and kept
