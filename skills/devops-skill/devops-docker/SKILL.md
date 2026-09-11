---
name: devops-docker
description: Write a production-safe Dockerfile and Compose from the actual app (multi-stage, non-root, no baked secrets). Use when the user says Docker, Dockerfile, compose, containerize, or after devops-inspect selects a container artifact.
metadata:
  author: Naveen Gumaste
  x: https://x.com/Z0D404
  github: https://github.com/NaveenGumaste
---

# DevOps Docker

Only if inspect selected a container. Do not Dockerize a static/PaaS/library repo. Image build-in-CI: devops-ci. Host run: devops-deploy.

## Action List (mandatory)

```
Findings:
- <runtime, start command, port, existing Dockerfile/compose>
Will do:
- <Dockerfile / .dockerignore / compose> — <why>
Needs your OK:
- <replace working Dockerfile / privileged / publish to a registry>
Will not touch:
- <app source, CI YAML, Terraform>
```

## Procedure

1. **Inspect.** Start command and port from `package.json`, `CMD`, or framework defaults. Base image from the runtime inspect found (node, bun, python, go) — pin a major tag, not `latest`.
2. **`.dockerignore`** first: `.git`, `node_modules`, `.env`, `.env.*`, `dist` if built in-image, CI files, `*.md` except LICENSE.
3. **Dockerfile** (Docker / OCI best practice: small, non-root, one concern):
   - Multi-stage: `deps` → `build` → `runtime` with production deps only.
   - `USER` non-root. No `sudo`.
   - `ENV NODE_ENV=production` (or equivalent) in runtime.
   - Bind the port the app listens on. `EXPOSE` that port.
   - `HEALTHCHECK` against a real route (`/health`, `/`, or framework health) if the app has one.
   - Never `COPY .env`. Never `ENV API_KEY=...`. Config at **runtime** (devops-env).
4. **Compose** — local only unless they asked for prod compose. Services the repo actually has. `env_file: .env` is local; document that production injects env. No `privileged`, no host network, no bind-mount of secrets into the image.
5. Do not add Kubernetes/Helm. Do not push an image unless devops-ci/deploy listed it.

## Verify

- Image builds with the repo's runner context
- Runtime user is non-root; no secrets in layers (`docker history` / grep Dockerfile)
- `.dockerignore` excludes `.env` and `.git`
- Compose does not use `privileged` or host network
- Existing Dockerfile unchanged unless approved

## Done when

The Action List was shown; the container matches the inspected start command and port; PaaS-only apps were not containerized.

Creator: Naveen Gumaste · [X](https://x.com/Z0D404) · [GitHub](https://github.com/NaveenGumaste)
