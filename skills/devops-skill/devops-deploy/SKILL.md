---
name: devops-deploy
description: Publish to the host already in the repo (Vercel, Cloudflare, Fly, Pages, registry) with preview then gated production. Use when the user says deploy, production, Vercel, wrangler, Fly, GitHub Pages, or after devops-inspect names a host.
metadata:
  author: Naveen Gumaste
  x: https://x.com/Z0D404
  github: https://github.com/NaveenGumaste
---

# DevOps Deploy

Promote the artifact CI already built. Do not add a second host. Production is **Needs your OK**.

## Action List (mandatory)

```
Findings:
- <host files, existing project/name, build command, output dir>
Will do:
- <config or CLI> — <preview vs prod>
Needs your OK:
- <production / custom domain / DNS / destroy / change host / first live deploy>
Will not touch:
- <app source, CI quality jobs, Terraform state>
```

## Procedure

1. **Inspect.** `vercel.json`, `wrangler.toml`, `fly.toml`, `netlify.toml`, `gh-pages`, Dockerfile + registry. Build command and output dir from existing scripts. If several hosts, use the one already wired; changing host is **Needs your OK**.
2. **Additive config** only. CLI of that host (`vercel`, `wrangler`, `flyctl`, `netlify`). Do not add a second platform.
3. **Preview** on PRs when the host supports it (Vercel/Netlify/Cloudflare preview, Fly PR apps). Production job uses GitHub `environment: production` (or GitLab environment) and the CI artifact — do not rebuild.
4. **LLM/agent:** deploy the worker/server inspect found. Do not expose provider keys to the edge client.
5. **Library/CLI:** do not use this skill; devops-ci publishes on tag.
6. Smoke: hit a real health or home URL if one exists. Rollback = the host's native rollback, listed, not invented.
7. Do not run `terraform apply` (devops-terraform). Do not `docker push` unless inspect's pipeline included a registry.

## Verify

- Host matches inspect; no second platform
- Production was gated or skipped
- Build command/output match the repo
- Preview ≠ production secrets
- No DNS/domain change unless approved

## Done when

The Action List was shown; preview or gated prod matches the named host; the user sees the URL or the exact CLI they must run if you cannot auth.

Creator: Naveen Gumaste · [X](https://x.com/Z0D404) · [GitHub](https://github.com/NaveenGumaste)
