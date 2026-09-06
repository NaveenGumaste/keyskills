---
name: git-skill
description: Set up and enforce git hygiene for a repo (gitignore, branches, commit messages, PR description, no secrets). Use when initializing a repository, fixing git mess, writing commits/PRs, or the user mentions git, branches, commits, or GitHub.
---

# Git Skill

Practical git workflow. Inspect existing conventions first. Do not rewrite history unless the user explicitly asks.

## When to use

- Fresh repo init
- Missing or weak `.gitignore`, commit style, or branch naming
- User wants a commit, PR body, or branch plan
- Accidental secrets, generated files, or `node_modules` in git

## When not to use

- Pure UI/SEO/cleanup with no VCS work
- Force-push to shared `main` / `master` without explicit request
- Changing remote hosting (GitHub → GitLab) unless asked

## Inspect first

1. `git status`, current branch, remotes, and whether `main` or `master` is default.
2. Existing commit message style (conventional, freeform, ticket prefixes).
3. Existing `.gitignore`, `.gitattributes`, PR template, husky/lefthook.
4. Package manager: Bun (`bun.lock`), pnpm, npm, yarn — ignore the others' artifacts only if unused.
5. Do not invent a team process that contradicts files already in the repo.

## Setup (init or repair)

1. **`.gitignore`** — at minimum:
   - dependencies (`node_modules`)
   - env files (`.env`, `.env.local`, keep `.env.example`)
   - build output (`.next`, `dist`, `coverage`)
   - OS/editor junk (`.DS_Store`)
   - agent junk only if the team wants it ignored (do not ignore committed skills the user wants shared)
2. **Branch** — `main` (or existing default) is stable. Feature work on `feat/...`, `fix/...`, `chore/...` unless the repo already uses another scheme.
3. **Commits** — conventional if the repo is new or already using it:
   - `feat:`, `fix:`, `docs:`, `chore:`, `refactor:`, `test:`, `style:`
   - imperative, under ~72 chars for the subject
   - one concern per commit when practical
4. **Never commit** — secrets, private keys, `.env`, large binaries, `node_modules`, build caches.
5. **PR** — short why / what / test plan. Link issues if present. Do not pad with filler.

## Agent behavior

- Run `git status` and `git diff` before committing.
- Only stage files related to the task.
- Do not `git add .` if unrelated dirty files exist.
- Do not amend commits that are already pushed unless asked.
- Do not use `--no-verify` unless the user asked and hooks are blocking for a stated reason.
- If hooks or a CLI are needed, prefer what the repo already uses (Husky, Lefthook, simple scripts). Prefer Bun scripts when the repo is Bun-based.

## Done when

- `.gitignore` covers deps, env, and build output
- Commit messages match the repo's style
- No secrets or generated junk in the index
- Branch name is descriptive
- PR/commit body explains why, not only what
