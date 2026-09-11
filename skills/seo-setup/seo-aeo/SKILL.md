---
name: seo-aeo
description: Make public pages citable by answer engines — extractable HTML answers, AI crawler access, and llms.txt — without rewriting copy or flipping robots policy. Use when the user says AEO, GEO, AI Overviews, llms.txt, ChatGPT/Perplexity citations, AI search, GPTBot, or AI crawlers.
metadata:
  author: Naveen Gumaste
  x: https://x.com/Z0D404
  github: https://github.com/NaveenGumaste
---

# SEO AEO

Inspect first. Add missing citation surfaces only. Never invent answers, FAQs, or a brand. On-page tags: seo-meta. Crawl paths: seo-crawl. JSON-LD: seo-schema.

## Action List (mandatory)

Do not create, edit, or delete files until this is in the user-visible reply:

```
Findings:
- <existing llms.txt, robots User-agent groups, pages with/without a direct HTML answer, entity/date if present>
Will do (additive, missing-only):
- <file> — <exact change>
Needs your OK:
- <copy rewrite / FAQ UI / training-bot flip / block a search bot>
Will not touch:
- <working copy, path rules in robots, sitemap, metadata, JSON-LD>
```

Proceed with **Will do** after that list. Stop on every **Needs your OK**. "cite us in ChatGPT" is not approval to rewrite headings or block `GPTBot`.

**Needs your OK**

- Rewrite visible copy into answer-first blocks, add FAQ UI, or change headings
- Change robots policy for training crawlers (`GPTBot`, `ClaudeBot`, `Google-Extended`, `CCBot`)
- Newly disallow AI *search* crawlers (`OAI-SearchBot`, `Claude-SearchBot`, `PerplexityBot`)
- Add `llms-full.txt` or put robots rules in `llms.txt`

## Procedure

1. **Inspect (read-only).** `robots.txt` / `app/robots.ts` user-agent groups, `llms.txt`, whether public HTML already has a short direct answer, and entity facts already on the page (who, org, date). Path allow/disallow belongs to seo-crawl — do not rewrite those lines. Backend-only / no public pages: stop.

2. **AI crawlers.** Do not newly block search/citation bots (`OAI-SearchBot`, `Claude-SearchBot`, `PerplexityBot`, `Googlebot`, `Bingbot`). Training-bot allow/disallow: list current policy and do not flip it. User-fetch (`ChatGPT-User`, `Claude-User`): same inspect-first rule. Keep public answers in HTML, not only in canvas/images.

3. **AEO.** Engines cite short, self-contained HTML with a clear entity. If a page already has a direct answer, leave it. Do not add FAQ blocks just to hang schema on (schema is seo-schema).

4. **`llms.txt`** — additive at site root if missing (`public/llms.txt` on Next.js, or an equivalent static route). Curated Markdown index of real public URLs plus one-line summaries taken from existing titles/descriptions. Not a Google ranking factor. Do not dump the site into `llms-full.txt`. Do not put robots rules here.

Match existing code style and the repo's runner (Bun: no second lockfile). No invented entity facts.

## Verify

- Training-bot policy unchanged unless approved
- AI search crawlers not newly disallowed
- Public HTML still crawlable; answers not only in canvas/images
- `llms.txt` (if added) lists only real public URLs and copy already on the site
- No new FAQ UI, heading rewrite, or `llms-full.txt` unless approved

## Done when

The Action List was shown; **Needs your OK** items were confirmed or skipped; missing citation surfaces are added; working copy and robots path rules are unchanged; the user has a file-by-file summary.

Creator: Naveen Gumaste · [X](https://x.com/Z0D404) · [GitHub](https://github.com/NaveenGumaste)
