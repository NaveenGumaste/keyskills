---
name: codebase-cleanup
description: Cleanup suite — dead files, unused deps, in-file tidy, lint, secrets, a11y. Selecting this skill installs all six cleanup sub-skills. Default is keep. Use when the user says clean this repo, unused code, unused packages, fix lint, committed .env, or a11y.
metadata:
  author: Naveen Gumaste
  x: https://x.com/Z0D404
  github: https://github.com/NaveenGumaste
---

# Cleanup

This file is the router. Selecting **codebase-cleanup** installs every sub-skill in this folder. Do not implement from here — read the listed `SKILL.md`. Default for anything uncertain: **keep**.

## Mandatory order

```
1. Dead files / unused exports     → cleanup-files/SKILL.md
2. Unused packages                 → cleanup-deps/SKILL.md
3. Imports, comments, console.log  → cleanup-tidy/SKILL.md
4. Existing lint/format/typecheck  → cleanup-lint/SKILL.md
5. .env, keys, junk dumps          → cleanup-secrets/SKILL.md
6. Button/label/alt hygiene        → cleanup-a11y/SKILL.md
```

"clean this repo" starts at cleanup-files and continues only through slices that have findings. A named slice ("fix lint", "remove unused packages") runs that skill only.

## When to trigger each skill

| Skill | Read | Trigger | Skip |
| --- | --- | --- | --- |
| [cleanup-files](cleanup-files/SKILL.md) | first on "clean this repo" | unused files, dead code, unused exports | they only named lint/deps/secrets/a11y |
| [cleanup-deps](cleanup-deps/SKILL.md) | after files | unused packages, prune deps | no package manifest |
| [cleanup-tidy](cleanup-tidy/SKILL.md) | after deps | unused imports, console.log, commented-out blocks | they only wanted deletes |
| [cleanup-lint](cleanup-lint/SKILL.md) | after tidy | fix lint, format, typecheck | no checker in the repo |
| [cleanup-secrets](cleanup-secrets/SKILL.md) | when findings exist | committed .env, secrets, debug dumps | none found |
| [cleanup-a11y](cleanup-a11y/SKILL.md) | if UI exists | a11y, alt, labels, button vs div | no UI / they did not ask |

## Direct paths

- `cleanup-files/SKILL.md`
- `cleanup-deps/SKILL.md`
- `cleanup-tidy/SKILL.md`
- `cleanup-lint/SKILL.md`
- `cleanup-secrets/SKILL.md`
- `cleanup-a11y/SKILL.md`

Creator: Naveen Gumaste · [X](https://x.com/Z0D404) · [GitHub](https://github.com/NaveenGumaste)
