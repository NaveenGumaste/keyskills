---
name: git-commit
description: Group related diffs into atomic commits, write Git/Conventional Commit messages, run lint/build, and push the target branch. Use when the user says commit, commit and push, lint and commit, atomic commits, group these changes, stage files, or push this branch.
metadata:
  author: Naveen Gumaste
  x: https://x.com/Z0D404
  github: https://github.com/NaveenGumaste
---

# Git Commit

Inspect first. Show the Action List before staging, committing, or pushing. Stay on the current branch unless the user named another. New remotes: git-init. Pull requests: git-pr.

Each commit is one concern and must leave a tree Git can bisect (lint/build pass).

## Action List (mandatory)

Read-only (`status`, `diff`, `log`, `branch -v`) is allowed. Do not `add`, `commit`, `checkout`, `push`, `stash`, `reset`, or `rebase` until this is in the user-visible reply:

```
Findings:
- <branch, upstream, dirty files, commit style, lint/build scripts>
Will do:
- commit 1: <subject>
  files: <paths>
- commit 2: …
- push: git push -u origin <branch>
Needs your OK:
- <history / discard / shared-branch / extra files>
Will not touch:
- <unrelated dirty files>
```

Proceed with **Will do** after that list. Stop on every **Needs your OK**. "commit this" is not approval to force-push, amend a published commit, or stage unrelated files. If they already named the files and message, list those and commit only those.

**Needs your OK**

- `push --force` / `--force-with-lease` to a shared branch (`main`, `master`, default)
- `reset --hard`, `checkout --`, or anything that discards uncommitted work
- `commit --amend` of a commit that is already pushed
- `rebase` / history rewrite
- Switch/create a branch when the user did not name one
- `git add -A` / `git add .` while unrelated dirty files exist
- `--no-verify`
- Commit `.env`, keys, or files that look like secrets

## Group

1. `git status` + `git diff` (and `git diff --cached`). Name every dirty path.
2. Split **this task** vs **unrelated** (leave unrelated unstaged).
3. Cluster the task files by **one concern**. Default: one commit per concern.

   | Together | Apart |
   | --- | --- |
   | Component + its styles + its test | Unrelated features |
   | Bug fix + the regression test | Drive-by refactor / format of files you did not need |
   | One config change and its only consumer | `feat` mixed with unrelated `chore`/`docs` |

   A cluster must make sense on its own (revert and bisect). If two files would not compile or test without each other, they are one concern.
4. Order commits: config/deps → implementation → tests → docs.
5. Put every proposed `(subject + paths)` in the Action List before staging.

## Message

Match the repo's existing `git log` style. If the repo is new or already Conventional Commits:

```
<type>(<optional scope>): <subject>

<body — why, not a diff restatement>
```

Types: `feat` `fix` `docs` `style` `refactor` `perf` `test` `build` `ci` `chore` `revert`. Breaking: `feat!:` or a `BREAKING CHANGE:` footer.

Git subject/body rules:

- Subject: imperative ("add", not "added" / "adds"), ~50 chars, 72 max, no trailing period
- Body: why this change, wrapped ~72; omit if the subject is enough

```
git commit -m "feat(auth): add session expiry" -m "Idle tokens stayed valid after logout."
```

Do not invent ticket IDs or product context. If the repo prefixes (`ABC-123:`) or uses freeform subjects, match that instead of forcing Conventional Commits.

## Procedure

1. Inspect: status, diff, current branch, upstream, last ~10 subjects, package scripts. Use the repo's runner (Bun / pnpm / npm / yarn).
2. Show the Action List (clusters + push target). Push target = current branch, or the branch the user named.
3. Run existing **lint**, then **build** (or typecheck if there is no build). Do not invent scripts. Missing script: say so and skip. Failure: show it, do not commit, do not push, unless they said to proceed anyway.
4. For each listed commit: `git add -- <paths>` (never `git add .` / `-A` while unrelated files exist). Then `git commit` with the listed message. No `--no-verify`.
5. Push the **target branch** only: `git push -u origin <branch>`. Regular push. One push per branch involved. No force.

Do not switch branches to push. If HEAD is not the named target, that switch is **Needs your OK**.

Never commit secrets, private keys, `.env`, `node_modules`, build caches, or large binaries. If they are already tracked, list `git rm --cached -- <path>` under **Needs your OK**.

## Verify

- `git status` matches the Action List (only listed files committed; unrelated still dirty)
- `git log --oneline -n <N>` shows the listed subjects, imperative, one concern each
- Lint/build ran (or were reported missing); no commit after a failed check unless they overrode
- Upstream is the named branch; push was not forced
- No secrets or generated junk in the new commits

## Done when

The Action List was shown; **Needs your OK** items were confirmed or skipped; each listed concern is its own commit and on the target remote branch; the user can see commands, files, and subjects.

Creator: Naveen Gumaste · [X](https://x.com/Z0D404) · [GitHub](https://github.com/NaveenGumaste)
