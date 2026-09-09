---
name: seo-setup
description: Inspect a site or codebase and add missing SEO and 2026 AI-search surfaces (metadata, sitemap, robots, canonical, Open Graph, JSON-LD, AEO extractable answers, AI crawler access, llms.txt) without overwriting working setup. Always list findings and planned file changes before writing. Use when initializing a repo, adding SEO, AEO, GEO, AI Overviews, ChatGPT/Perplexity citations, keyword optimization, backlinks, llms.txt, schema, sitemap, robots, or OG.
---

# SEO Setup

Inspect first. Add only what is missing. Never invent a brand, domain, or ranking copy. Never silently overwrite SEO that already works.

## Show the user first (mandatory)

Do not create, edit, or delete files until an **Action List** is in the user-visible reply. Keep listing as you work. After you finish, report what changed and what you skipped.

```
Findings:
- <stack, existing metadata, sitemap/robots, domain if known>
Will do (additive, missing-only):
- <file> — <exact change>
Needs your OK (overwrite / indexing / URLs):
- <file> — <what would change and the risk>
Will not touch:
- <pages, copy, design, routes, working tags>
```

Proceed with **Will do** only after that list is shown. Stop on every **Needs your OK** item until the user confirms. A vague request ("add SEO", "fix discoverability") is not approval for those items. If the latest message already asked for one specific overwrite (for example "replace the homepage title with X"), list it and do that item only.

**Needs your OK** (do not do these on your own):

- Replace an existing title, description, canonical, OG image, or JSON-LD
- Add or tighten `noindex`, or disallow a public URL in robots
- Change slugs, routes, heading text, or visible page copy
- Point canonicals or `metadataBase` at a domain that is not already in the repo or env
- Delete an existing sitemap, robots file, or SEO component
- Rewrite visible copy into "answer-first" AEO blocks
- Add FAQ / HowTo schema or FAQ UI that is not already on the page
- Change robots policy for AI training crawlers (`GPTBot`, `ClaudeBot`, `Google-Extended`, `CCBot`)
- Newly disallow AI *search* crawlers (`OAI-SearchBot`, `Claude-SearchBot`, `PerplexityBot`)

## When to use

- New website repo with no SEO, or missing title / description / OG / canonical
- No sitemap or robots
- JSON-LD / structured data requested
- Search Console, crawl, or social-preview issues
- AEO / GEO / AI Overviews / "cite us in ChatGPT" / AI search
- Keyword optimization of titles and intent (not stuffing)
- Backlink *readiness* (cite-worthy pages). Not off-site link building.

## When not to use

- Backend-only, CLI, or library repos with no public pages
- The user only asked for visual design, git, or cleanup
- Paid ads / Google Ads campaign setup
- Buying links, PBNs, guest-post spam, or fake directories
- Inventing FAQs, reviews, authors, or keywords the site does not have

## Inspect first (read-only)

1. Detect stack: Next.js App Router vs Pages, other frameworks, or static HTML.
2. Detect layout: `src/` vs root, `app/` vs `pages/`, existing `metadata` / `Helmet` / `<head>`.
3. Read existing title, description, canonical, sitemap, robots (including AI crawler rules), `llms.txt`, and any CMS/SEO plugin.
4. Infer site purpose, primary URLs, and language from the repo and live site if provided.
5. Collect identity only from the project: brand name, domain (`NEXT_PUBLIC_SITE_URL` or equivalent), existing copy. If a value is missing, leave it out or mark it **Needs your OK**. Do not invent it.

## Implementation order (additive)

1. **Identity** — one primary title pattern and one meta description per unique route. Keep titles unique. Fill empty fields from existing page copy; do not rewrite copy that is already in `<title>` or `metadata`.
2. **Framework metadata**
   - Next.js App Router: root `layout.tsx` `metadata` / `generateMetadata`, not ad-hoc `<head>` tags.
   - Next.js Pages: `next/head` or a shared SEO component already in the repo.
   - Other stacks: use whatever head API already exists.
3. **Canonical** — absolute URLs, consistent trailing-slash policy, no duplicate home URLs. Match the policy already in use. Do not pick a new domain.
4. **Open Graph + Twitter** — `og:title`, `og:description`, `og:url`, `og:type`, image 1200×630 if an asset already exists. Do not add a fake OG image. Do not generate a new image unless the user asked.
5. **robots** — allow public pages; disallow preview, api internals, and draft routes that already exist. Do not newly block an indexable URL.
6. **sitemap** — include only indexable canonical URLs. Honor existing `noindex`. Do not add URLs that are not real routes.
7. **JSON-LD** — only types the site actually is (`WebSite`, `Organization`, `Person`, `Article`, `SoftwareApplication`). Add `FAQPage` / `HowTo` only when those Q&As or steps are already visible. `Article` author / `Person` / `sameAs` only when a named author and real profile URLs exist in the project. No fake reviews, ratings, or invented company. Google does not require special AI schema; markup must match visible content.
8. **Technical** — set `lang` on `<html>` only if it is missing. Do not restyle headings or rewrite visible text "for SEO."
9. **Keywords (on-page intent)** — unique title + H1 that match what the page already says. Fill empty titles/descriptions from existing copy. Do not keyword-stuff, hide text, or swap a working title for a guessed query. If the user named target queries, list gaps vs current copy under **Needs your OK**.
10. **AI crawlers / agents** — inspect `robots.txt` before changing it. Do not newly block search/citation bots (`OAI-SearchBot`, `Claude-SearchBot`, `PerplexityBot`, `Googlebot`, `Bingbot`). Training-bot policy is the user's call; list current allow/disallow and do not flip it. User-fetch bots (`ChatGPT-User`, `Claude-User`) follow the same inspect-first rule. Keep public HTML crawlable (answers not only in canvas/images).
11. **AEO (answer engines)** — engines cite short, self-contained HTML answers with a clear entity (who wrote this, about which org, on which date). If a page already has a direct answer, leave it. Turning a page into question/answer copy, adding FAQ UI, or changing headings is **Needs your OK**. Do not add FAQ blocks just to hang schema on.
12. **`llms.txt`** — additive at the site root if missing. Curated Markdown index of real public URLs plus one-line summaries taken from existing titles/descriptions. Not a Google ranking factor (Google has said it does not use it). Do not duplicate the whole site into `llms-full.txt`. Do not put robots rules in `llms.txt`.
13. **Backlinks** — this skill cannot acquire external links. In-repo only: stable canonical URLs, internal links to important pages, no invented outbound "authority" links. Report off-site work (digital PR, real citations) as out of scope. Never buy links or add footer/blog comment spam.

## Next.js specifics (only if detected)

- Prefer Metadata API over manual tags.
- Add `app/sitemap.ts` and `app/robots.ts` if App Router and those files are missing. Serve `llms.txt` from `public/llms.txt` (or an equivalent static route) if you add one.
- Use `metadataBase` from the real domain in env (`NEXT_PUBLIC_SITE_URL`) when present. If no origin exists, say so and skip absolute URLs rather than using `example.com`.
- Keep `openGraph` and `twitter` in sync with the page title/description you did not overwrite.

## Rules

- Smallest change that makes SEO correct. Edit metadata / head / sitemap / robots / JSON-LD / `llms.txt` only. No design, no link schemes.
- Match existing code style, formatter, and folder conventions.
- If Bun is the package manager, do not add npm-only scripts or a second lockfile.
- Call out anything that needs a real domain, Search Console, or production env. Do not fake it.
- Do not add SEO packages if the framework already has a metadata API.

## Verify

- Primary templates still have unique title + description (existing values preserved unless the user approved a replace)
- Canonical strategy matches existing trailing-slash / domain policy
- robots does not newly disallow a public page
- sitemap lists only real canonical routes
- JSON-LD contains only entity data found in the project (no FAQ/HowTo/reviews that are not on the page)
- robots does not newly block AI search crawlers; training-bot policy is unchanged unless the user approved it
- `llms.txt` (if added) lists only real public URLs and copy already on the site
- No dummy `example.com` if a real origin exists
- No keyword stuffing and no new external link schemes

## Done when

- The Action List was shown before writes, and **Needs your OK** items were either confirmed or skipped
- Missing SEO / AEO pieces are added; working pieces are unchanged
- User can see a file-by-file summary of what you did and what you left alone
