---
name: cleanup-secrets
description: Report stray secrets and junk (.env with values, debug dumps, local artifacts) and ask delete, archive, or keep. Default is keep. Never print secret values. Use when the user says secrets, committed .env, debug files, junk files, stray dumps, or credentials in the repo.
metadata:
  author: Naveen Gumaste
  x: https://x.com/Z0D404
  github: https://github.com/NaveenGumaste
---

# Cleanup Secrets

Talk first. Default: **keep**. Report presence, not values. Dead source files: cleanup-files. Unused packages: cleanup-deps.

## Action List (mandatory)

Read-only until this is in the user-visible reply. Do not edit `.env` values.

```
Findings:
- <paths that look like secrets or junk; .env.example present?>
Ask you (one choice per item):
- <path>
  Why it looks like a secret/junk: <filename / tracked-by-git, not the value>
  Risk if wrong: <needed for local run?>
  Choose: delete  |  archive (say where)  |  keep
Already keeping:
- .env.example — keep
Will not touch:
- .env values (report path only), setup, generated output
```

Stop after that list. "Clean this up" is not an answer. Unanswered items: **keep**.

## Choices

- **Keep** (default) — leave the file.
- **Archive** — `git mv` to a path the user names. Do not invent `_archive/`. No destination: ask once, then keep.
- **Delete** — only items they marked delete. If it was tracked, `git rm` (or `git rm --cached` when they want the file to stay on disk). Then check it is not still imported.

Never mix choices. Never paste API keys, tokens, or `.env` bodies into the reply.

## Procedure

1. **Inspect.** Tracked and untracked: `.env`, `.env.*` (except `.env.example`), `*.pem`, `*.p12`, `id_rsa`, credential JSON, debug dumps, stray `*.log`, local DB files, `Thumbs.db` / `.DS_Store` if tracked.
2. **Report path + kind only.** Do not open and echo secret contents.
3. Apply the chosen action per item. Keep `.env.example`. Do not rewrite `.gitignore` unless the user asked (git-init owns ignore rules).
4. Do not: uninstall packages, delete source components, or edit generated `dist` / `.next`.

## Verify

- Chosen files are gone or at the named archive path; unanswered files still present
- `.env.example` unchanged; no secret values in the transcript or in `git diff`
- App setup files and source tree otherwise untouched

## Done when

The list was shown; every delete/archive had an explicit choice (everything else kept); no secret value was printed; the user can see paths acted on.

Creator: Naveen Gumaste · [X](https://x.com/Z0D404) · [GitHub](https://github.com/NaveenGumaste)
