---
name: git-skill
description: Set up and enforce git hygiene (gitignore, branches, commit messages, PR description, no secrets) without rewriting history or staging unrelated files. Always list git actions before running them. Trigger commit-and-push when the user says "commit and push", "lint and commit", "commit each change", or "push this". Trigger open-PR when they say "create PR", "open PR", "pull request", "assign PR", or mention PR labels/tags. Use when initializing a repository, fixing git mess, writing commits/PRs, or the user mentions git, branches, commits, or GitHub.
---

# Git Skill

Inspect existing conventions first. Show the user the exact git actions before you run them. Do not rewrite history unless the user explicitly asks.

## Show the user first (mandatory)

Do not run mutating git commands (`add`, `commit`, `checkout`, `branch`, `reset`, `rebase`, `push`, `stash`, rewrite of `.gitignore`) until an **Action List** is in the user-visible reply. Read-only commands (`status`, `diff`, `log`, `branch -v`) are allowed during inspect.

```
Findings:
- <current branch, default branch, dirty files, remotes, existing commit style>
Will do:
- <command or file edit> — <why>
Needs your OK (history / shared branch / discard):
- <command> — <what it would destroy or overwrite>
Will not touch:
- <unrelated dirty files, remotes, hooks, history>
```

Proceed with **Will do** only after that list is shown. Stop on every **Needs your OK** item until the user confirms. A vague request ("fix git", "commit this") is not approval for history rewrite, force-push, or discard. If the latest message already asked for one specific dangerous command (for example "force-push this branch"), list it and do that item only.

**Needs your OK** (do not do these on your own):

- `push --force` / `--force-with-lease` to any shared branch (`main`, `master`, or the default)
- `reset --hard`, `checkout --`, or anything that discards uncommitted work
- `commit --amend` of a commit that is already pushed
- `rebase` / `filter-branch` / history rewrite
- Delete a branch (local or remote)
- Change the default branch or remote URL
- `git add -A` / `git add .` when unrelated dirty files exist
- `--no-verify` to skip hooks
- Commit `.env`, keys, or files that look like secrets

When the user asked to commit, listing the exact files and the message, then committing those files, is **Will do**. Do not expand the commit to extra files.

## When to use

- Fresh repo init
- Missing or weak `.gitignore`, commit style, or branch naming
- User wants a commit, PR body, or branch plan
- Accidental secrets, generated files, or `node_modules` in git
- **Commit & push mode:** "commit and push", "lint and commit", "commit each change", "push this", "atomic commits"
- **Open PR mode:** "create PR", "open PR", "pull request", "assign PR", "PR labels", "PR tags"

## When not to use

- Pure UI / SEO / cleanup with no VCS work
- Force-push to shared `main` / `master` without an explicit request
- Changing remote hosting (GitHub to GitLab) unless asked

## Commit & push mode

Run this mode when the user wants commits and a push (keywords above). Stay on the current branch. Do not switch branches.

1. Inspect: `git status`, `git diff`, current branch, existing commit style, `package.json` scripts.
2. Cluster dirty files by **one concern**. Default is one commit per concern. Group files that share that concern (a component plus its styles/test, or 1-2 files with the same context). Do not mix unrelated features into one commit. Leave unrelated dirty files unstaged.
3. Show the Action List with every proposed commit (`message` + file paths) and `git push` of the current branch. No force-push.
4. Run the repo's existing **lint** script, then **build** (or typecheck if there is no build). Use the repo's runner (Bun / pnpm / npm / yarn). Do not invent scripts. If a script is missing, say so and skip it.
5. If lint or build fails: show the failure, do not commit, do not push. Stop unless the user says to proceed anyway.
6. If checks pass: create each listed commit with a proper message using the **Commits** rules in Setup. Stage by path, never `git add .`.
7. `git push -u origin <current-branch>` (create upstream if missing). Regular push only.

## Open PR mode

Run this mode when the user wants a pull request (keywords above). Do not guess missing fields.

Ask **once**, in one message, for anything not already in the user's request:

- **From** which branch (head). Default: current branch if they omit it.
- **To** which branch (base). Required. Do not assume `main`.
- **Assignee** (person they want). Skip assign if they give none.
- **Labels / tags**. Skip labels if they give none.

Then:

1. Inspect commits and files on head vs base (`git log`, `git diff base...head`).
2. Show the Action List: from, to, title, assignee, labels, and that you will open the PR.
3. Write a **title** that names the change, not "Update" or "Fix stuff."
4. Write a **story** body from the real diff and commits:
   - Why this change exists
   - What changed (grouped by concern)
   - How to verify
   - Linked issues if present
   Do not invent product context or pad with filler.
5. Create the PR with `gh pr create` (or the repo's equivalent) using those fields. Assign and label only the values the user gave.
6. If `gh` is missing, print the compare URL plus the title and body for the user to paste. Do not open a PR on the wrong base.

## Inspect first (read-only)

1. `git status`, current branch, remotes, and whether `main` or `master` is default.
2. Existing commit message style (conventional, freeform, ticket prefixes). Match it. Do not invent a new convention on a repo that already has one.
3. Existing `.gitignore`, `.gitattributes`, PR template, husky/lefthook.
4. Package manager: Bun (`bun.lock`), pnpm, npm, yarn. Ignore the others' artifacts only if unused.
5. Name every dirty file. Split "related to this task" vs "unrelated, leave unstaged."

## Setup (init or repair)

Only add missing lines. Do not remove ignore rules or rewrite a working `.gitignore` from scratch.

1. **`.gitignore`** — at minimum, if missing:
   - dependencies (`node_modules`)
   - env files (`.env`, `.env.local`; keep `.env.example`)
   - build output (`.next`, `dist`, `coverage`)
   - OS/editor junk (`.DS_Store`)
   - agent junk only if the team wants it ignored (do not ignore committed skills the user wants shared)
2. **Branch** — `main` (or existing default) is stable. Feature work on `feat/...`, `fix/...`, `chore/...` unless the repo already uses another scheme. Create a new branch instead of committing straight to the default only when the user asked or the repo already works that way.
3. **Commits** — conventional if the repo is new or already using it:
   - `feat:`, `fix:`, `docs:`, `chore:`, `refactor:`, `test:`, `style:`
   - imperative, under ~72 chars for the subject
   - one concern per commit when practical
4. **Never commit** — secrets, private keys, `.env`, large binaries, `node_modules`, build caches. If they are already tracked, list them under **Needs your OK** (`git rm --cached`), do not untrack them silently.
5. **PR** — use **Open PR mode**. Do not open a PR without from/to branches.

## Agent behavior

- Run `git status` and `git diff` before committing. Paste the file list and the proposed message in the Action List.
- Stage only files related to the task, by path.
- Do not amend commits that are already pushed unless asked.
- If hooks or a CLI are needed, prefer what the repo already uses (Husky, Lefthook, simple scripts). Prefer Bun scripts when the repo is Bun-based. Do not add a new hook framework.

## Verify

- `git status` after the action matches the Action List (only listed files staged/committed)
- No secrets or generated junk in the index
- Unrelated dirty files are still dirty and unstaged
- Branch name and commit subject match existing repo style

## Done when

- The Action List was shown before mutating git state, and **Needs your OK** items were either confirmed or skipped
- `.gitignore` covers deps, env, and build output without removing existing rules
- Commit / PR body explains why, not only what
- User can see the commands you ran and the files involved
