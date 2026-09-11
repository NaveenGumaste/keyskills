---
name: cleanup-a11y
description: Fix HTML accessibility hygiene in existing UI — buttons vs divs, form labels, and image alt — without redesigning. Use when the user says a11y, accessibility, alt text, form labels, button vs div, or HTML hygiene.
metadata:
  author: Naveen Gumaste
  x: https://x.com/Z0D404
  github: https://github.com/NaveenGumaste
---

# Cleanup A11y

Inspect first. Fix semantics, not visuals. Not a redesign (design-skill). Lint errors: cleanup-lint.

## Action List (mandatory)

Read-only until this is in the user-visible reply:

```
Findings:
- <UI surfaces, existing a11y checker if any>
Will do:
- <path> — <div-as-button / missing label / missing alt>
Needs your OK:
- <change that would restyle or rewrite copy>
Will not touch:
- <layout, color, typography, routes, SEO>
```

Proceed with **Will do** after that list. Stop on **Needs your OK**. "fix a11y" is not approval to restyle, add a design system, or rewrite page copy.

**Needs your OK**

- Visual restyle (color, type, spacing, layout) to "fix" contrast
- Changing visible copy
- Adding an a11y library or overlay that is not already in the repo

## Procedure

1. **Inspect.** Pages/components the user named, or the primary UI already in the task. If the repo has an a11y script (axe, eslint-plugin-jsx-a11y, Lighthouse), run it. Do not add one.
2. **Controls.** A clickable non-link `div`/`span` with an `onClick` → `<button>` (or the existing Button component). Keep the same handler. Do not restyle.
3. **Forms.** Every input has a visible `<label>` (or `aria-label` if a visible label already exists in copy). No placeholder-as-label.
4. **Images.** Meaningful `alt` from nearby copy or filename; decorative images `alt=""`. Do not invent marketing captions.
5. Do not: redesign, swap icon libraries, change routing, or mass-edit unrelated files.

## Verify

- Listed controls are real buttons/links; listed inputs have labels; listed images have alt
- No layout/color/type diffs unless approved
- Existing a11y/lint script (if any) is cleaner on those files
- `git diff` matches the Action List

## Done when

The Action List was shown; listed hygiene issues are fixed; the UI still looks the same; the user has a file-by-file summary.

Creator: Naveen Gumaste · [X](https://x.com/Z0D404) · [GitHub](https://github.com/NaveenGumaste)
