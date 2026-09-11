---
name: git-skill
description: Git suite — init/remote, atomic commits and push, pull requests. Selecting this skill installs git-init, git-commit, and git-pr. Use when the user says git, commit, push, open PR, init repo, or GitHub.
metadata:
  author: Naveen Gumaste
  x: https://x.com/Z0D404
  github: https://github.com/NaveenGumaste
---

# Git

This file is the router. Selecting **git-skill** installs every sub-skill in this folder. Do not implement from here — read the listed `SKILL.md` and skip any slice the request does not need.

## Mandatory order

```
1. No repo / new remote / GitHub create → git-init/SKILL.md
2. Uncommitted work / commit / push     → git-commit/SKILL.md
3. Open or format a pull request        → git-pr/SKILL.md
```

Run only the steps the user asked for. "commit and push" does not init a new GitHub repo. "open a PR" runs git-commit first if the branch is dirty.

## When to trigger each skill

| Skill | Read | Trigger | Skip |
| --- | --- | --- | --- |
| [git-init](git-init/SKILL.md) | first if no `.git` or no origin | git init, add remote, create GitHub repo, visibility | repo already has origin and they only want a commit/PR |
| [git-commit](git-commit/SKILL.md) | after init if needed | commit, push, group diffs, lint and commit | they only asked to open a PR and HEAD is clean + pushed |
| [git-pr](git-pr/SKILL.md) | last | create PR, reviewers, labels, screenshots | they only asked to commit/push |

## Direct paths

- `git-init/SKILL.md`
- `git-commit/SKILL.md`
- `git-pr/SKILL.md`

Creator: Naveen Gumaste · [X](https://x.com/Z0D404) · [GitHub](https://github.com/NaveenGumaste)
