---
name: git-init
description: Initialize a local Git repo, set the default branch, write a minimal .gitignore, add origin, and create a public or private GitHub repository. Use when starting a project, running git init, adding a remote, creating a GitHub repo, or setting visibility.
metadata:
  author: Naveen Gumaste
  x: https://x.com/Z0D404
  github: https://github.com/NaveenGumaste
---

# Git Init

Inspect first. Show the Action List before mutating. New GitHub repos are **private** unless the user said public. App commits: git-commit. PRs: git-pr.

## Action List (mandatory)

Read-only (`status`, `remote -v`, `branch -a`, `rev-parse`) is allowed. Do not `init`, rewrite `.gitignore`, add/change remotes, `gh repo create`, or push until this is in the user-visible reply:

```
Findings:
- <already a repo? default branch, remotes, existing .gitignore, gh auth>
Will do:
- <command or file> — <why>
Needs your OK:
- <public visibility / change origin / change default branch / nested repo / overwrite>
Will not touch:
- <tracked files, history, unrelated remotes>
```

Proceed with **Will do** after that list. Stop on every **Needs your OK**. "init this" / "put it on GitHub" is not approval to make it public, replace `origin`, or rewrite a working `.gitignore`.

**Needs your OK**

- Visibility `public` (or `--internal`) when the user did not name it
- `git init` inside an existing repo, or a nested repo under another `.git`
- Change an existing remote URL or default branch
- Rewrite / delete a working `.gitignore`
- Delete `.git`
- `git push` when the user only asked to init

## Procedure

1. **Inspect.** `git rev-parse --is-inside-work-tree`, `git remote -v`, default branch (`main`/`master`/other), `.gitignore`, `git config user.name` / `user.email`. If name/email are unset, ask once — do not invent, do not write global config. If already a repo, only add what is missing.
2. **Init** (missing `.git` only):

   ```
   git init -b main
   ```

   Use `main` unless the user or `init.defaultBranch` named another.
3. **`.gitignore`** — append missing lines only; never remove existing rules. If the file is absent, create it with at least:

   - dependencies (`node_modules/`)
   - env (`.env`, `.env.*`; keep `.env.example`)
   - build output (`.next/`, `dist/`, `coverage/`, `*.tsbuildinfo`)
   - OS/editor (`.DS_Store`, `Thumbs.db`)

   Ignore the other package-manager lockfile only when that manager is unused. Do not ignore skills or files the user wants shared.
4. **Remote** — exactly one path:

   | Situation | Action |
   | --- | --- |
   | User gave a URL, no `origin` | `git remote add origin <url>` |
   | User wants a new GitHub repo | `gh repo create <name> --source=. --remote=origin --private` (or `--public` if they said so). `--push` only if a commit exists and they asked to publish |
   | `origin` already correct | leave it |
   | `gh` missing or unauthenticated | print `gh auth login` plus the `gh repo create` line and `https://github.com/new`; do not fake a remote |

   Repo name defaults to the directory name. Do not invent an org. **Private unless they said public** — if they did not say, list `--private` under Will do.
5. **Publish** only when asked: `git push -u origin HEAD`. Regular push. No `--force`.
6. **Initial commit** (optional, this skill only): VCS scaffolding (`.gitignore`, existing `README*`, `LICENSE*`). Stage by path. Subject: `chore: initial commit`. Application code belongs in git-commit.

## Verify

- `git rev-parse --is-inside-work-tree` is true
- HEAD branch matches the listed default
- `git remote -v` matches the listed origin (or none, if none was asked)
- `.gitignore` covers deps / env / build; previous rules intact
- GitHub visibility matches the Action List
- No `.env`, keys, `node_modules`, or build output in the initial commit

## Done when

The Action List was shown; **Needs your OK** items were confirmed or skipped; the repo has the listed branch, ignore file, and remote; the user can see the commands and the visibility.

Creator: Naveen Gumaste · [X](https://x.com/Z0D404) · [GitHub](https://github.com/NaveenGumaste)
