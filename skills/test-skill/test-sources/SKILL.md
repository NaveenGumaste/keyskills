---
name: test-sources
description: Fetch the current official testing docs and the expert guidance those docs cite for the detected framework, and emit a practice card. Use when the test tool, file layout, or assertions must follow that framework's latest practice. Requires internet.
metadata:
  author: Naveen Gumaste
  x: https://x.com/Z0D404
  github: https://github.com/NaveenGumaste
---

# Test Sources

This file owns the practice card. Later skills follow the card from this run. They do not replace it with memory, and they do not invent fields, unless **Needs your OK** approved a model-knowledge card.

Read-only on the repo. Use the agent's web search and page fetch. No test files yet.

## Action List (mandatory)

One block per stack card from test-inspect:

```
Practice card:
- app: <path>
- framework: <name> <installed major>
- fetched: <YYYY-MM-DD>
- official: <url> — <what it settled>
- expert: <url> — <what it settled, or "official page cites none">
- runner when none is installed: <tool the official docs tell a new app to use>
- keep existing runner: <name, or "none installed">
- command: <exact test command for this package manager>
- files: <where tests go, how they are named>
- test this: <what the sources say to assert>
- avoid: <what the sources say not to mock, snapshot, or reach into>
- setup: <config, environment, or fixtures the docs require>
- disagreement: <official vs expert, or "none">
```

Print the card, then the router continues. No web access or a failed fetch: prompt under **Needs your OK** before stopping.

## How to fetch

For each stack card:

1. Search and open the official testing documentation for that framework and the installed major version. The version in the URL or the page must match the installed major. A newer major's guide is not the source.
2. An expert source is a document that official page cites, or the current testing guide from the maintainers of the framework or of the test tool that page names. Open it. Skip generic roundups and undated posts when a primary source exists.
3. Record the fetch date and the URLs on the card. The card's rules are quotes of those pages in the agent's words, tied to the URL.
4. Official docs for the installed major win when an expert source disagrees. Write both sides on `disagreement`.
5. The repo already has a runner: `keep existing runner` is that runner. `runner when none is installed` is still filled from the docs, for the empty case only. Do not tell later skills to swap the installed runner.
6. No official testing page for this framework: fetch the language's own current testing guide and set `official` to that URL. Say the framework page was missing.

No web access, a blocked page, or offline: name the query and the URL that failed, then prompt **Needs your OK: fill practice card from model knowledge**. Approval fills the card from model knowledge, sets `fetched` to `model knowledge`, and leaves `official` / `expert` as `unfetched`. The suite then continues. No approval: stop. Do not continue to test-harness or test-write until they approve.

No page for this installed major after a successful fetch: stop. Name the query and the URL. Do not fill that card from memory.

## Needs your OK

- fill practice card from model knowledge — only when web access fails or the agent is offline. Approval fills the card and the suite continues. No approval stops the suite.

## Done when

Every stack card has a practice card with working URLs and today's fetch date, or an approved model-knowledge card, or the suite has stopped. No project files were written.

Creator: Naveen Gumaste · [X](https://x.com/Z0D404) · [GitHub](https://github.com/NaveenGumaste)
