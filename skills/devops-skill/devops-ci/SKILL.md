---
name: devops-ci
description: Add an architecture-specific CI/CD pipeline from existing repo scripts — PR checks, cached install, artifacts, OIDC, environment gates. Use when the user says CI, CD, GitHub Actions, GitLab CI, pipeline, run tests on PR, or after devops-inspect selects CI.
metadata:
  author: Naveen Gumaste
  x: https://x.com/Z0D404
  github: https://github.com/NaveenGumaste
---

# DevOps CI

Industry CI/CD: build once, promote the artifact, fail fast, least privilege. Inspect must already have selected this skill. Docker image jobs: devops-docker. `terraform plan` job: devops-terraform. Production publish: devops-deploy.

## Action List (mandatory)

```
Findings:
- <existing workflows, scripts, runner, default branch>
Will do (additive):
- <file> — <jobs/stages>
Needs your OK:
- <replace working workflow / pull_request_target / write token / paid runners>
Will not touch:
- <working CI, app source, Docker/Terraform files owned by siblings>
```

"add CI" is not approval to replace a working pipeline or deploy production from `main` without an environment gate.

## Pipeline shape (from inspect's kind)

DORA / GitHub: every change is verified; production uses a **promoted artifact**, not a second build.

| Kind | PR | Default branch |
| --- | --- | --- |
| Static / SSR | install → lint → typecheck → test → build | preview deploy if host supports it |
| API | same + image build (no push on fork PRs) | push image / deploy **staging** |
| LLM / agent | lint → tests that **do not** call paid models → secret scan | deploy worker/server; live eval only if they asked |
| CLI / library | test matrix → pack | publish **on tag**, dry-run on PR |
| Monorepo | path filters; one job per affected app | same |

Use the repo's existing scripts and runner. Missing script: skip that stage, do not add Jest/Playwright.

## Procedure

1. **Inspect.** `.github/workflows`, `.gitlab-ci.yml`, `package.json`/`Makefile` scripts, lockfile. Existing CI that already covers the sketch: list it under Will not touch and stop.
2. **Prefer the CI that exists.** GitHub if `.github/` or `origin` is GitHub; GitLab if `.gitlab-ci.yml`. Do not add a second system.
3. **GitHub Actions** (default when GitHub):
   - `on: pull_request` and `push` to the default branch (and tags if library).
   - Workflow-level `permissions: { contents: read }`. Add `id-token: write` only for OIDC. Write scopes per job, never workflow-wide.
   - Pin first-party actions to a major (`actions/checkout@v4`). SHA-pin if the repo already does. Do not invent SHAs.
   - Cache the lockfile (Bun/pnpm/npm/yarn official cache action or `cache:`).
   - Upload the build artifact; later deploy jobs **download** it (do not rebuild).
   - `concurrency` group per ref; cancel in-progress PR runs.
   - Cloud access: GitHub OIDC (`id-token: write` + official login action), not long-lived `AWS_ACCESS_KEY_ID`. If OIDC is not set up, list the trust as **Needs your OK** — do not invent account IDs.
   - Production job: `environment: production` (GitHub Environments). Fork PRs never see prod secrets.
   - Never `pull_request_target` + checkout of untrusted head. Never echo secrets. Never `continue-on-error` on lint/test.
4. **GitLab:** `default` image matching the runtime; `cache` on the lockfile; `rules` so forks cannot deploy; `environment` for prod.

Match existing YAML style. Bun repos: `bun ci` / `bun run <script>`, no extra lockfile.

## Verify

- PR run does not deploy production
- Jobs call real repo scripts; no invented test runner
- Permissions are least-privilege; no long-lived cloud keys added
- Artifact is built once when a deploy job exists
- Existing workflows unchanged unless approved

## Done when

The Action List was shown; the pipeline matches inspect's kind; working CI is intact.

Creator: Naveen Gumaste · [X](https://x.com/Z0D404) · [GitHub](https://github.com/NaveenGumaste)
