---
name: devops-skill
description: Architecture-aware DevOps. Inspect the repo, then load only the matching pipeline skills (CI/CD, Docker, env, deploy, Terraform, Prometheus/Grafana). Use when the user says DevOps, CI, CD, GitHub Actions, Docker, deploy, Terraform, Prometheus, Grafana, pipeline, containerize, or monitoring.
metadata:
  author: Naveen Gumaste
  x: https://x.com/Z0D404
  github: https://github.com/NaveenGumaste
---

# DevOps

This file is the router. Do **not** implement CI, Docker, Terraform, or monitoring from here. Read the listed sub-skill `SKILL.md` before that phase, and skip any skill inspect did not select.

Git, SEO, cleanup, and design are other suites. Do not commit, rewrite UI, or add meta tags.

## Mandatory order

```
1. Read devops-inspect/SKILL.md and run it. Stop after its Action List
   until the user has seen the architecture read and the trigger map.
2. Load only the skills inspect marked Will trigger, in this order:
     devops-env        →  devops-ci        →  devops-docker
     devops-terraform  →  devops-observe   →  devops-deploy
3. Each loaded skill shows its own Action List, then executes.
   Do not start skill N+1 until skill N is done or skipped.
```

If the user named one slice ("just Docker", "add Prometheus"), still run inspect first, then that slice only — unless inspect forbids it (for example Docker on a static site with no container host).

## When to trigger each skill

| Skill | Read | Trigger when inspect found | Do not trigger |
| --- | --- | --- | --- |
| [devops-inspect](devops-inspect/SKILL.md) | always | any DevOps request | — |
| [devops-env](devops-env/SKILL.md) | after inspect | runtime config / secrets surface | no env usage in code |
| [devops-ci](devops-ci/SKILL.md) | after inspect | a build, test, or lint script, or they asked for a pipeline | nothing to run (empty repo) |
| [devops-docker](devops-docker/SKILL.md) | after CI plan | container kind, existing Dockerfile, or Fly/Cloud Run/compose | static site, Vercel/Netlify/Pages-only, library/CLI with no image |
| [devops-terraform](devops-terraform/SKILL.md) | after CI plan | existing `.tf`, user asked for IaC, or a cloud account the app is not fully on a PaaS | PaaS-only (Vercel/Cloudflare Pages) with no `.tf` and no ask |
| [devops-observe](devops-observe/SKILL.md) | after deploy-shape is known | long-running service they host (API, worker, VM, K8s, compose) **or** they named Prometheus/Grafana | static site, serverless PaaS with no scrape target, library |
| [devops-deploy](devops-deploy/SKILL.md) | last | a host already in the repo, or they named one | library/CLI publish-only (CI handles the registry) |

Inspect’s trigger map is the source of truth. If this table and inspect disagree, **inspect wins**.

## Shared gates (every sub-skill)

- Inspect the tree. Additive. Do not overwrite working CI/Docker/Terraform/deploy config.
- **Needs your OK:** production, DNS, destroy, new cloud account, long-lived cloud keys, `terraform apply`, scraping a paid LLM API in CI, second host/CI.
- Match the repo’s runner (Bun: no second lockfile).
- Smallest system that kind needs. No Kubernetes/Helm/Ansible unless already in the repo.

## Direct paths

Relative to this folder:

- `devops-inspect/SKILL.md`
- `devops-env/SKILL.md`
- `devops-ci/SKILL.md`
- `devops-docker/SKILL.md`
- `devops-terraform/SKILL.md`
- `devops-observe/SKILL.md`
- `devops-deploy/SKILL.md`

Creator: Naveen Gumaste · [X](https://x.com/Z0D404) · [GitHub](https://github.com/NaveenGumaste)
