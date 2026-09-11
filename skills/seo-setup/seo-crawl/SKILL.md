---
name: seo-crawl
description: Add or repair robots and sitemap so public canonical URLs are crawlable and indexable. Use when the user says sitemap, robots.txt, indexing, crawl, Search Console, noindex, or discoverability plumbing.
metadata:
  author: Naveen Gumaste
  x: https://x.com/Z0D404
  github: https://github.com/NaveenGumaste
---

# SEO Crawl

Inspect first. Add missing robots/sitemap only. Never invent routes or a domain. On-page tags: seo-meta. Schema: seo-schema. AI user-agent policy / `llms.txt`: seo-aeo.

## Action List (mandatory)

Do not create, edit, or delete files until this is in the user-visible reply:

```
Findings:
- <stack, existing robots/sitemap, noindex, routes, domain/slash policy, existing User-agent groups>
Will do (additive, missing-only):
- <file> — <exact change>
Needs your OK:
- <noindex / disallow public URL / delete>
Will not touch:
- <working robots/sitemap, metadata, schema, llms.txt, existing User-agent groups>
```

Proceed with **Will do** after that list. Stop on every **Needs your OK**. "add a sitemap" is not approval to `noindex` a public page or delete robots.

**Needs your OK**

- Add or tighten `noindex`
- Disallow a public URL in robots
- Delete an existing sitemap, robots file, or SEO route module
- Change any existing `User-agent` group (AI crawler policy is seo-aeo)

## Procedure

1. **Inspect (read-only).** Stack and route tree. Existing `robots.txt` / `app/robots.ts`, sitemap (`app/sitemap.ts`, `sitemap.xml`), `noindex`, canonical/trailing-slash policy, domain in env. List current `User-agent` groups; do not edit them. Identity (origin) only from the repo; if missing, skip absolute sitemap URLs rather than `example.com`. Backend-only / no public pages: stop.

2. **robots** — allow public pages. Disallow preview, api internals, and draft routes that already exist. Do not newly block an indexable URL. Preserve every existing `User-agent` group verbatim (search, training, and fetch bots). A new file is `User-agent: *` plus path allows/disallows only.

3. **sitemap** — only real, canonical, indexable URLs. Honor existing `noindex`. Same trailing-slash and host policy as current canonicals. Do not add URLs that are not routes.

4. **Next.js (App Router, files missing):** `app/sitemap.ts` and `app/robots.ts`. Do not add a sitemap package if the framework already has these APIs. Pages/static: `public/robots.txt` and `public/sitemap.xml` (or the existing generator).

Match existing code style and the repo's runner (Bun: no second lockfile).

## Verify

- robots does not newly disallow a public page
- Existing `User-agent` groups are unchanged
- sitemap lists only real canonical indexable routes
- Host and trailing-slash match existing canonical policy
- No dummy `example.com` if a real origin exists
- No deleted robots/sitemap unless approved

## Done when

The Action List was shown; **Needs your OK** items were confirmed or skipped; public routes are listed and allowed; working crawl files and AI user-agent rules are intact; the user has a file-by-file summary.

Creator: Naveen Gumaste · [X](https://x.com/Z0D404) · [GitHub](https://github.com/NaveenGumaste)
