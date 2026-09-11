---
name: seo-meta
description: Add missing on-page SEO — unique titles and descriptions, canonicals, Open Graph/Twitter, html lang, and keyword intent — without overwriting working tags. Use when adding SEO, metadata, titles, meta descriptions, canonical, OG, Twitter cards, keyword optimization, or social previews.
metadata:
  author: Naveen Gumaste
  x: https://x.com/Z0D404
  github: https://github.com/NaveenGumaste
---

# SEO Meta

Inspect first. Add only missing tags. Never invent a brand, domain, or ranking copy. Crawl/index: seo-crawl. Schema: seo-schema. AI search / `llms.txt`: seo-aeo.

## Action List (mandatory)

Do not create, edit, or delete files until this is in the user-visible reply:

```
Findings:
- <stack, existing title/description/canonical/OG, domain if known>
Will do (additive, missing-only):
- <file> — <exact change>
Needs your OK:
- <overwrite / new domain / copy rewrite>
Will not touch:
- <working tags, routes, copy, sitemap/robots/schema/llms (name the sibling skill)>
```

Proceed with **Will do** after that list. Stop on every **Needs your OK**. "add SEO" is not approval to replace a working title or pick a domain. If they already named one overwrite ("replace the homepage title with X"), list it and do that item only.

**Needs your OK**

- Replace an existing title, description, canonical, or OG image
- Change slugs, routes, heading text, or visible page copy
- Point canonicals or `metadataBase` at a domain not already in the repo or env
- Generate a new OG image
- Swap a working title/H1 for a guessed query

## Procedure

1. **Inspect (read-only).** Stack: Next.js App Router vs Pages, other framework, or static HTML. Layout: `src/` vs root, `app/` vs `pages/`, existing `metadata` / `Helmet` / `<head>`. Collect identity only from the project: brand, domain (`NEXT_PUBLIC_SITE_URL` or equivalent), current titles/descriptions/canonicals/OG, `lang`. Missing value: omit it or mark **Needs your OK**. Do not invent it. Backend-only / no public pages: stop.

2. **Identity.** One title pattern and one meta description per unique route. Titles unique. Fill empty fields from existing page copy; do not rewrite copy already in `<title>` or `metadata`.

3. **Framework metadata** — use the head API already in the repo. Do not add an SEO package if one exists.
   - App Router: root `layout.tsx` `metadata` / `generateMetadata`, not ad-hoc `<head>`
   - Pages Router: `next/head` or the shared SEO component already there
   - Other: existing Helmet / `useHead` / `<head>`

4. **Canonical.** Absolute URLs. Match the trailing-slash policy already in use. No duplicate home URLs. Do not pick a new domain. Next.js: `metadataBase` from the real env origin; if none, skip absolute URLs rather than `example.com`.

5. **Open Graph + Twitter.** `og:title`, `og:description`, `og:url`, `og:type`; Twitter mirrors the same. Image 1200×630 only if an asset already exists. Do not add a fake OG image. Keep `openGraph` / `twitter` in sync with the title/description you did not overwrite.

6. **`lang`** on `<html>` only if missing. Do not restyle headings or rewrite visible text "for SEO."

7. **Keywords (intent, not stuffing).** Unique title + H1 that match what the page already says. Do not hide text. If the user named target queries, list gaps vs current copy under **Needs your OK**.

8. **Internal links.** Stable canonicals and in-repo links to important pages. No invented outbound "authority" links, bought links, or comment spam. Off-site digital PR is out of scope.

Smallest change. Match existing code style and the repo's runner (Bun: no second lockfile). Call out Search Console / production domain; do not fake them.

## Verify

- Each primary template has a unique title + description; existing values preserved unless approved
- Canonical trailing-slash / domain policy unchanged; no dummy `example.com` if a real origin exists
- OG/Twitter match the title/description you left in place
- No new OG image unless asked; no keyword stuffing; no new external link schemes
- `lang` added only when it was missing

## Done when

The Action List was shown; **Needs your OK** items were confirmed or skipped; missing tags are filled from real copy; working tags are unchanged; the user has a file-by-file summary and sibling handoffs for crawl/schema/AEO.

Creator: Naveen Gumaste · [X](https://x.com/Z0D404) · [GitHub](https://github.com/NaveenGumaste)
