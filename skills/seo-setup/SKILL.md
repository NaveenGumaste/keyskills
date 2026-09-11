---
name: seo-setup
description: SEO suite — on-page metadata, crawl/index, JSON-LD, AEO/llms.txt. Selecting this skill installs seo-meta, seo-crawl, seo-schema, and seo-aeo. Use when the user says SEO, sitemap, robots, schema, OG, AEO, GEO, or llms.txt.
metadata:
  author: Naveen Gumaste
  x: https://x.com/Z0D404
  github: https://github.com/NaveenGumaste
---

# SEO

This file is the router. Selecting **seo-setup** installs every sub-skill in this folder. Do not implement from here — read the listed `SKILL.md` and skip any slice inspect would not select.

## Mandatory order

```
1. Titles, descriptions, canonical, OG, keywords → seo-meta/SKILL.md
2. robots + sitemap                               → seo-crawl/SKILL.md
3. JSON-LD / structured data                      → seo-schema/SKILL.md
4. AEO, AI crawlers, llms.txt                     → seo-aeo/SKILL.md
```

"add SEO" runs all four, each with its own Action List. A named slice ("just sitemap", "add JSON-LD") runs that skill only.

## When to trigger each skill

| Skill | Read | Trigger | Skip |
| --- | --- | --- | --- |
| [seo-meta](seo-meta/SKILL.md) | first on "add SEO" | metadata, titles, OG, canonical, keywords | they only named crawl/schema/AEO |
| [seo-crawl](seo-crawl/SKILL.md) | after meta | sitemap, robots, indexing | no public pages |
| [seo-schema](seo-schema/SKILL.md) | after crawl | JSON-LD, schema, rich results | they only wanted tags or sitemap |
| [seo-aeo](seo-aeo/SKILL.md) | last | AEO, GEO, llms.txt, ChatGPT citations | static tags-only request with no AI-search ask |

## Direct paths

- `seo-meta/SKILL.md`
- `seo-crawl/SKILL.md`
- `seo-schema/SKILL.md`
- `seo-aeo/SKILL.md`

Creator: Naveen Gumaste · [X](https://x.com/Z0D404) · [GitHub](https://github.com/NaveenGumaste)
