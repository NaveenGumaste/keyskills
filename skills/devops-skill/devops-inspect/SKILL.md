---
name: devops-inspect
description: Classify a repo's architecture (website, SSR app, API, LLM/agent, CLI/library, worker) and emit the DevOps system plus which sibling skills to load. Use when starting DevOps, or before CI, Docker, Terraform, deploy, or monitoring.
metadata:
  author: Naveen Gumaste
  x: https://x.com/Z0D404
  github: https://github.com/NaveenGumaste
---

# DevOps Inspect

Read-only. No files, no cloud CLIs. Output the architecture read, trigger map, and pipeline sketch. Then stop. The router loads implementers.

## Action List (mandatory)

```
Findings:
- <kind, runtime, runner, existing CI/host/Docker/tf/metrics, scripts, secrets surface, data>
Reading this as: <kind> (<stack>), runner <bun|pnpm|npm|yarn|go|py>, host <existing or none>
Will trigger:
- <skill> — <why this architecture needs it>
Will not trigger:
- <skill> — <why it would be generic slop here>
Needs your OK (before any later skill):
- <new host / first container / first Terraform / first Prometheus stack>
Pipeline sketch:
- <stages derived from existing scripts and kind>
```

Do not invent a kind. If website vs API vs agent is ambiguous, ask **once**.

## Classify

Detect from the tree, lockfiles, and config — not from the user's adjectives alone.

| Kind | Signals |
| --- | --- |
| Static / marketing site | HTML/Vite/Astro static, no server, `output: 'export'` |
| SSR website | Next/Nuxt/SvelteKit/Remix with a server |
| API / backend | Express/Fastify/Go/FastAPI, no public pages as the product |
| LLM / agent | model SDKs, tool/agent loops, `OPENAI_*` / `ANTHROPIC_*` / Workers AI |
| CLI / library | `bin` in package.json, no deploy host, publish scripts |
| Worker / queue | cron, queues, `wrangler` worker without a site |
| Mixed / monorepo | `apps/` + `packages/`, multiple lockfiles or workspaces |

Also record: runner (Bun if `bun.lock`/`bun.lockb`), existing CI (`.github/workflows`, `.gitlab-ci.yml`), host files (`vercel.json`, `wrangler.toml`, `fly.toml`, `netlify.toml`, Dockerfile, `compose.y*ml`, `*.tf`), metrics (`/metrics`, `prometheus.yml`, Grafana `provisioning/`), scripts (`lint`, `test`, `build`, `typecheck`).

## System by kind (smallest correct)

Twelve-Factor: explicit config, build/release/run, no secrets in the artifact. Instantiated per kind:

| Kind | Artifact | CI | Docker | Terraform | Observe | Deploy |
| --- | --- | --- | --- | --- | --- | --- |
| Static site | `dist`/`out` | build + preview | no | no unless they have `.tf` | no | Pages/Netlify/GH Pages |
| SSR website | framework build | lint → typecheck → test → build → preview | only if Dockerfile or Fly/Cloud Run already | no if PaaS-only | PaaS telemetry; Prometheus only if they host a scrape target | existing host, else Vercel/Cloudflare |
| API | binary or image | test → build → (migrate if present) | yes if they run a process | if they asked or `.tf` exists | yes — RED/golden signals | Fly/Cloud Run/compose |
| LLM / agent | worker or server | unit tests **without** paid model calls; secret scan | only if they already containerize | same as API | if they host a process; never scrape vendor APIs | Workers / existing server |
| CLI / library | pack tarball | test matrix → pack / publish dry-run | no | no | no | registry on tag (CI) |
| Worker | worker bundle | test → deploy preview | no unless specified | rare | if always-on | wrangler / existing |

Monorepo: path filters; one pipeline per shippable app, not one giant job.

## Trigger map (write into Will trigger / Will not trigger)

- **devops-env** — code reads env / bindings.
- **devops-ci** — any lint/test/build script, or they asked for a pipeline. Always for a shippable app.
- **devops-docker** — kind is containerized **or** Dockerfile/compose/Fly/Cloud Run present **or** they asked to containerize a process that is not on a PaaS. Never for static/PaaS-only/library.
- **devops-terraform** — `.tf` present **or** they asked for IaC **or** they named a cloud account and are not fully on a PaaS. Never "because DevOps".
- **devops-observe** — they host a long-running process **or** named Prometheus/Grafana. Never for static sites or libraries.
- **devops-deploy** — host file exists **or** they named a host. Library publish stays in CI.

## Pipeline sketch

List stages from **scripts that exist**, in fail-fast order:

`install (cache lockfile) → lint → typecheck → test → build → [image] → [tf plan] → [preview] → [prod, gated]`

Omit stages with no script. Do not invent Jest, Playwright, or eval suites. Paid LLM calls in CI: **Needs your OK**.

## Done when

The Action List is in the user-visible reply; kind is evidenced; every sibling is either Will trigger or Will not trigger with a reason; no files were written.

Creator: Naveen Gumaste · [X](https://x.com/Z0D404) · [GitHub](https://github.com/NaveenGumaste)
