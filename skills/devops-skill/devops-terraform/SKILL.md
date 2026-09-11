---
name: devops-terraform
description: Terraform write → plan → apply with remote state, CI plan-on-PR, apply-from-saved-plan on the default branch. Use when the user says Terraform, OpenTofu, IaC, terraform plan/apply, or after devops-inspect selects IaC.
metadata:
  author: Naveen Gumaste
  x: https://x.com/Z0D404
  github: https://github.com/NaveenGumaste
---

# DevOps Terraform

HashiCorp core workflow: **write, plan, apply**. Never apply without a reviewed plan. Never add Terraform to a PaaS-only app because "DevOps". CI wiring: devops-ci. Cloud credentials: OIDC via devops-ci, not access keys in tf.

## Action List (mandatory)

```
Findings:
- <existing .tf, backend, workspaces vs dirs, providers>
Will do:
- <files / CI jobs> — <fmt, validate, plan, apply-from-plan>
Needs your OK:
- <terraform apply / new backend / new cloud account / destroy>
Will not touch:
- <app source, working .tf that already plans, state files>
```

`add Terraform` is not approval to `apply` or to create a cloud account.

## Layout

Match what exists. If greenfield and they asked:

```
infra/
  versions.tf      # required_version + required_providers (pinned)
  backend.tf       # remote backend — see below
  main.tf
  variables.tf
  outputs.tf
```

One directory per environment **or** existing workspaces — do not mix both. Modules only for repeated resources already in the repo's style.

## State

- Remote backend required for any shared/apply path (S3+lock, GCS, Terraform Cloud/HCP, azurerm). Local state only for a throwaway solo experiment they asked for.
- Commit `.terraform.lock.hcl`. Gitignore `.terraform/`, `*.tfstate`, `*.tfstate.*`, `crash.log`, `tfplan`.
- Do not write secrets into state on purpose (use the provider's secret store). Do not print `terraform show` of sensitive outputs.

If no backend is configured, put `backend.tf` as a stub and **Needs your OK** for the bucket/org — do not invent account IDs.

## Procedure (local)

1. `terraform fmt` / `tofu fmt`
2. `terraform init`
3. `terraform validate`
4. `terraform plan -out=tfplan` — paste the summary in the Action List
5. `terraform apply tfplan` **only** after they approved that plan. No `apply -auto-approve` on production.

## Procedure (CI) — HashiCorp + GitHub recommended

PR:

- `fmt -check`, `init -input=false`, `validate`, `plan -input=false -out=tfplan`
- Upload `tfplan` as an artifact. Comment the plan if the repo already has that pattern; do not add a noisy bot otherwise.

Default branch / production environment:

- Download the **exact** plan artifact (or re-plan and require approval).
- `terraform apply -input=false tfplan`
- Job `environment: production`. OIDC to the cloud (`id-token: write`), not `AWS_ACCESS_KEY_ID` in repo secrets.

`terraform destroy` is always **Needs your OK**.

## Code rules

- Pin `required_version` and provider versions.
- Variables: `variables.tf` + `*.tfvars` for non-secrets. Secrets via `TF_VAR_*` or the host's secret store — never committed `secret.tfvars`.
- `sensitive = true` on secret outputs.
- No `local-exec` that curls the internet as a side effect unless they asked.
- Do not generate a VPC/EKS/GKE for a website that already deploys to Vercel/Cloudflare.

## Verify

- `fmt` + `validate` clean
- Plan was shown before any apply
- State is remote (or explicitly local and approved)
- Lockfile committed; state files not committed
- No long-lived cloud keys in workflows
- Apply used the saved plan, not a fresh unreviewed apply

## Done when

The Action List was shown; write/plan(/apply) matches HashiCorp's workflow; production apply was gated or skipped.

Creator: Naveen Gumaste · [X](https://x.com/Z0D404) · [GitHub](https://github.com/NaveenGumaste)
