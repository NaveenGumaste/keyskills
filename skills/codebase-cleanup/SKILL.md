---
name: codebase-cleanup
description: Inspect a codebase and remove dead weight (unused files, exports, deps, noise) while keeping behavior. Use when the user asks to clean up, declutter, remove unused code, fix lint, or prepare a repo for resume/production quality.
---

# Codebase Cleanup

Safe cleanup. Preserve behavior. No drive-by rewrites.

## When to use

- "Clean this repo", "remove unused code", "it's messy"
- Unused dependencies, dead components, leftover templates
- Lint/format noise, console.log, commented-out blocks
- Preparing a project to look production-ready

## When not to use

- Greenfield feature work (use the relevant feature skill)
- Visual redesign (use design-skill)
- SEO implementation (use seo-setup)
- Git history surgery (use git-skill)

## Inspect first

1. Package manager and scripts (Bun, pnpm, npm, yarn). Use the repo's runner.
2. Framework and entrypoints. Map `app/`, `src/`, `components/`, `lib/`.
3. Existing lint, format, tsconfig, and CI. Do not add a new toolchain unless none exists and the user wants one.
4. Identify generated folders and do not hand-edit them.
5. Note public API / routes so deletions cannot break production paths.

## Order of work

1. **Safe deletes** — unused files never imported, leftover `page.tsx` stubs, duplicate components, dead CSS.
2. **Unused exports** — remove or stop exporting internals that nothing imports. Keep real public APIs.
3. **Dependencies** — remove packages not imported and not used by scripts/CI. Do not remove something only referenced in config without checking.
4. **Secrets and junk** — `.env` samples without values, stray debug files, `console.log` on hot paths, huge commented blocks.
5. **Consistency** — one component pattern, one import alias style, filenames matching neighbors.
6. **Lint/format** — run the existing checker; fix real issues. Do not mass-disable rules.
7. **A11y/HTML hygiene** if UI exists — button vs div, labels, alt on meaningful images. Not a full redesign.

## Rules

- One concern at a time. Cleanup commits stay separate from features when git-skill is also in play.
- If unsure a file is dead, search imports and routes before deleting. Prefer `git mv` over copy/delete when renaming.
- Do not upgrade major versions as a side effect.
- Do not replace the UI library, state library, or folder architecture "while cleaning".
- Do not change runtime behavior to satisfy a lint rule without saying so.
- Bun repos: use `bun` for install/lint/test; do not add a parallel npm lockfile.

## Verify

- Typecheck / lint / test scripts that already exist
- App still boots; primary routes still render
- `git diff` is reviewable (no 5k-line formatter-only surprise unless the user asked to format the tree)

## Done when

- Dead files and unused deps are gone or listed as "kept because X"
- Lint/typecheck is no noisier than before, ideally cleaner
- No behavior change except removal of unused paths
- README/scripts still match the remaining commands
