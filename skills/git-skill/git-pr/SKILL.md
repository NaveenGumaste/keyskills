---
name: git-pr
description: Open a pull request with a precise title, story body from the real diff, reviewers, assignees, labels, and UI screenshots. Use when the user says create PR, open PR, pull request, request review, assign PR, PR labels, or attach screenshots to a PR.
metadata:
  author: Naveen Gumaste
  x: https://x.com/Z0D404
  github: https://github.com/NaveenGumaste
---

# Git PR

Inspect first. Show the Action List before opening the PR. Do not guess base, reviewers, or product story. Uncommitted work: git-commit. Missing remote: git-init.

## Action List (mandatory)

Read-only (`status`, `log`, `diff base...head`, `gh pr status`) is allowed. Do not `gh pr create` / `gh pr edit` until this is in the user-visible reply:

```
Findings:
- <head, default branch, commits vs base, existing PRs, template, UI diffs?>
Will do:
- gh pr create --base <base> --head <head>
  title: <title>
  reviewers / assignees / labels: <only user-given, or none>
  screenshots: <paths or skip>
Needs your OK:
- <missing base / wrong existing PR / force / draft vs ready>
Will not touch:
- <unrelated branches, extra labels, guessed reviewers>
```

Proceed with **Will do** after that list. Stop on every **Needs your OK**. "open a PR" is not approval to target `main`, add reviewers, or file against the wrong base.

**Needs your OK**

- Base branch not named by the user and not already obvious from an existing PR on this head
- Reviewers, assignees, or labels the user did not give
- Opening a second PR for a head that already has one (`gh pr view` first)
- Converting draft ↔ ready when they did not say
- Push `--force` to update the head

## Ask once

In one message, fill only what the latest request omitted:

| Field | Default if omitted |
| --- | --- |
| **Head** (from) | Current branch |
| **Base** (to) | None — ask. Do not assume `main` |
| **Reviewers** | Skip `--reviewer` |
| **Assignees** | Skip `--assignee` |
| **Labels** | Skip `--label` |
| **Draft** | Ready unless they said draft |

Do not invent people or labels.

## Title

Treat the title as the squash-merge subject: imperative, ~72 chars, no trailing period, names the change.

Match commit style on the branch. Conventional repo: `feat(scope): …` / `fix(scope): …`. Never "Update", "Fix stuff", "WIP" (unless they asked for a draft).

## Body

Use `.github/pull_request_template.md` if present; fill it from the real `git log base..head` and `git diff base...head`. Otherwise:

```markdown
## Summary
<2–4 lines: why this exists. From the diff, not invented product context.>

## Changes
- <concern>: <what actually changed>

## Test plan
- [ ] <command or manual step that proves the change>

## Screenshots
<see checklist; or "N/A — no UI">
```

Link `Fixes #N` / `Closes #N` only when that issue is in the branch, the template, or the user's message. No filler, no "This PR does the following".

## Screenshots (UI diffs)

Required when the diff touches user-visible UI (layout, styling, routing, rendered copy). Skip with `N/A — no UI` otherwise.

Checklist — attach a real capture for each that applies:

- [ ] Primary view after the change (desktop)
- [ ] Same view, mobile width, if layout/CSS changed
- [ ] Before/after if this is a redesign or visual fix
- [ ] Empty / error / loading if those states changed

Use captures from this change (browser, existing asset, or user file). Do not generate decorative mockups. Embed hosted markdown images when a URL exists (`![what it shows](url)`). Local-only files: create the PR, list the paths, tell the user to drop them onto the GitHub PR. Do not commit screenshot dumps unless they asked.

## Procedure

1. Inspect: current branch, `git status` (must be clean or already pushed), `git log` / `git diff <base>...<head>`, `gh pr view --head <head>` if `gh` exists, PR template.
2. If head has no upstream, `git push -u origin <head>` (regular push). Uncommitted files: stop and send them to git-commit.
3. Show the Action List (base, head, title, body summary, reviewers/labels, screenshot plan).
4. Create:

   ```
   gh pr create --base <base> --head <head> --title "<title>" --body "<body>"
     [--reviewer u1,u2] [--assignee u1] [--label x,y] [--draft]
   ```

   Only pass flags the user gave. If `gh` is missing, print the compare URL (`<origin>/compare/<base>...<head>`) plus title and body to paste.
5. Print the PR URL. Do not merge.

## Verify

- PR head/base match the Action List
- Title names the change; body matches the real diff (no invented context)
- Reviewers / assignees / labels are exactly what the user gave (or none)
- UI PRs have a Screenshots section with real captures or an explicit drop instruction
- No second PR for the same head; no force-push

## Done when

The Action List was shown; **Needs your OK** items were confirmed or skipped; the PR exists (or the paste payload does) with title, body, and screenshot section filled from the diff.

Creator: Naveen Gumaste · [X](https://x.com/Z0D404) · [GitHub](https://github.com/NaveenGumaste)
