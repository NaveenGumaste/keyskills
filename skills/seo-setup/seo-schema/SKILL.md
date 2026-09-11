---
name: seo-schema
description: Add JSON-LD structured data that matches visible page content (WebSite, Organization, Person, Article, SoftwareApplication). Use when the user says JSON-LD, schema, structured data, rich results, FAQPage, HowTo, or entity markup.
metadata:
  author: Naveen Gumaste
  x: https://x.com/Z0D404
  github: https://github.com/NaveenGumaste
---

# SEO Schema

Inspect first. Markup only what the page already is. Never invent an organization, author, review, or FAQ. On-page tags: seo-meta. Crawl: seo-crawl. AI search / `llms.txt`: seo-aeo.

## Action List (mandatory)

Do not create, edit, or delete files until this is in the user-visible reply:

```
Findings:
- <stack, existing JSON-LD, visible entities, authors/profiles, FAQ/HowTo on page?>
Will do (additive, missing-only):
- <file> — <type + fields sourced from>
Needs your OK:
- <replace existing JSON-LD / FAQPage / HowTo / new entity>
Will not touch:
- <working JSON-LD, page copy, metadata, robots, llms.txt>
```

Proceed with **Will do** after that list. Stop on every **Needs your OK**. "add schema" is not approval to mint FAQs, reviews, or a company the repo does not name.

**Needs your OK**

- Replace existing JSON-LD
- Add `FAQPage` / `HowTo` when those Q&As or steps are not already visible
- Add `Article` author / `Person` / `sameAs` without a named author and real profile URLs in the project
- Reviews, ratings, or an invented Organization

## Procedure

1. **Inspect (read-only).** Existing JSON-LD / schema components, visible page type, brand name, authors, dates, offers — only values present in the project or on the page. Missing field: omit it. Do not invent it. Backend-only / no public pages: stop.

2. **Emit JSON-LD** via the stack's existing pattern (`<script type="application/ld+json">`, `next/script`, or a schema helper already in the repo). Do not add a schema package if a script tag suffices. Google requires markup to match visible content; there is no special "AI schema."

3. **Types** — only what the site actually is:

   | Type | When |
   | --- | --- |
   | `WebSite` | Site-wide, if a real origin exists |
   | `Organization` / `Person` | Named in the project; `sameAs` only with real profile URLs |
   | `Article` | Article pages with a real title/date; author only if named |
   | `SoftwareApplication` | The product is software and the page says so |
   | `FAQPage` / `HowTo` | Those Q&As or steps are already on the page |

4. **Do not** add fake reviews/ratings, keyword-stuffed descriptions, or types the page is not. Do not change visible copy to justify markup (that is seo-meta / seo-aeo).

Match existing code style and the repo's runner (Bun: no second lockfile). `@id` / URLs use the origin already in the repo; otherwise omit absolute `@id`.

## Verify

- Every type and field is visible in the project or on the page
- No FAQ/HowTo/reviews that are not on the page
- Existing JSON-LD unchanged unless approved
- No dummy `example.com` if a real origin exists

## Done when

The Action List was shown; **Needs your OK** items were confirmed or skipped; missing honest types are added; working JSON-LD is unchanged; the user has a file-by-file summary.

Creator: Naveen Gumaste · [X](https://x.com/Z0D404) · [GitHub](https://github.com/NaveenGumaste)
