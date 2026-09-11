---
name: devops-env
description: Inventory runtime config from the code and add .env.example plus host secret mapping without writing real secrets. Use when the user says env, environment variables, .env.example, secrets mapping, or after devops-inspect finds a config surface.
metadata:
  author: Naveen Gumaste
  x: https://x.com/Z0D404
  github: https://github.com/NaveenGumaste
---

# DevOps Env

Twelve-Factor config: env vars, not baked files. Finding leaked `.env`: cleanup-secrets. Gitignore: git-init. This skill only maps **required** runtime config.

## Action List (mandatory)

```
Findings:
- <vars referenced in code, existing .env.example, host secret names>
Will do:
- <.env.example / host env docs> — <keys, not values>
Needs your OK:
- <rename a live var / commit .env / rotate a key>
Will not touch:
- <.env values, gitignore unless missing .env, app logic>
```

Never print secret values. Never write `.env`.

## Procedure

1. **Inventory** from code: `process.env`, `Bun.env`, `os.environ`, `NEXT_PUBLIC_*`, wrangler `[vars]` / bindings, `TF_VAR_*`. Split **public** (ok in the client) vs **server**.
2. **`.env.example`** — additive keys with empty or obvious dummy placeholders (`changeme` only for non-secrets like `PORT=3000`). Keep existing keys. Do not copy values from `.env`.
3. **Map** each server secret to the host inspect named: GitHub `secrets.*` / Environments, Vercel/Cloudflare env, Docker runtime `-e` / compose `environment`. Document the name mapping; do not create cloud secrets via CLI unless they asked.
4. LLM/agent: model keys are server-only. Never `NEXT_PUBLIC_` a provider key.
5. If `.env` is tracked: stop and hand off to cleanup-secrets. If `.env` is missing from `.gitignore`: hand off to git-init.

## Verify

- `.env.example` lists real keys from code; no live secrets
- Public vs server split is correct for the framework
- `.env` was not written or committed
- Transcript contains no token/key material

## Done when

The Action List was shown; the example file matches the inventory; host mapping is named, not invented.

Creator: Naveen Gumaste · [X](https://x.com/Z0D404) · [GitHub](https://github.com/NaveenGumaste)
