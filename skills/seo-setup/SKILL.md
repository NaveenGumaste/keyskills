---
name: seo-setup
description: Inspect any site or codebase and implement SEO (metadata, sitemap, robots, canonical, Open Graph, JSON-LD, crawlability). Use when initializing a repo, adding SEO, fixing discoverability, or the user mentions metadata, sitemap, robots, OG, or schema.
---

# SEO Setup

Adaptable SEO playbook. Inspect first. Never assume a brand, domain, framework, or file layout.

## When to use

- New repo init and the project is a website
- Missing or weak title, description, OG, twitter, canonical
- No sitemap or robots
- JSON-LD / structured data requested
- Search Console, crawl, or social-preview issues

## When not to use

- Backend-only, CLI, or library repos with no public pages
- The user only asked for visual design, git, or cleanup
- Paid ads / Google Ads campaign setup

## Inspect first

1. Detect stack: Next.js App Router vs Pages, other frameworks, or static HTML.
2. Detect layout: `src/` vs root, `app/` vs `pages/`, existing `metadata` / `Helmet` / `<head>`.
3. Read existing title, description, canonical, sitemap, robots, and any CMS/SEO plugin.
4. Infer site purpose, primary URLs, and language from the repo and live site if provided.
5. Do not invent a brand name, domain, or product copy if it is not in the project.

## Implementation order

1. **Identity** — one primary title pattern and one meta description per unique route. Keep titles unique.
2. **Framework metadata**
   - Next.js App Router: root `layout.tsx` `metadata` / `generateMetadata`, not ad-hoc `<head>` tags.
   - Next.js Pages: `next/head` or a shared SEO component already in the repo.
   - Other stacks: use whatever head API already exists.
3. **Canonical** — absolute URLs, consistent trailing-slash policy, no duplicate home URLs.
4. **Open Graph + Twitter** — `og:title`, `og:description`, `og:url`, `og:type`, image 1200×630 if assets exist. Do not add fake OG images.
5. **robots** — allow public pages; disallow preview, api internals, and draft routes that exist.
6. **sitemap** — include only indexable canonical URLs. Honor `noindex`.
7. **JSON-LD** — only types the site actually is (`WebSite`, `Organization`, `Person`, `Article`, `SoftwareApplication`). No fake reviews or inventing a company.
8. **Technical** — correct `lang` on `<html>`, meaningful headings, indexable text (not text-only-in-canvas), internal links to important pages.

## Next.js specifics (only if detected)

- Prefer Metadata API over manual tags.
- Add `app/sitemap.ts` and `app/robots.ts` if App Router and files are missing.
- Use `metadataBase` from the real domain in env (`NEXT_PUBLIC_SITE_URL`) when present.
- Keep `openGraph` and `twitter` in sync with the page title/description.

## Rules

- Match existing code style, formatter, and folder conventions.
- Smallest change that makes SEO correct. No redesign.
- If Bun is the package manager, do not add npm-only scripts.
- Call out anything that needs a real domain, Search Console, or production env — do not fake it.

## Done when

- Unique title + description on primary templates
- Canonical strategy is consistent
- robots + sitemap exist or an equivalent is documented
- OG tags are valid or explicitly skipped with a reason
- JSON-LD matches real entity data only
- No leftover dummy `example.com` if a real origin exists
