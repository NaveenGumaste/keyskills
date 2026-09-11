---
name: devops-observe
description: Add Prometheus instrumentation and Grafana-as-code for a hosted service — golden signals, scrape config, provisioned dashboards, symptom alerts. Use when the user says Prometheus, Grafana, metrics, monitoring, alerting, /metrics, or after devops-inspect selects observe.
metadata:
  author: Naveen Gumaste
  x: https://x.com/Z0D404
  github: https://github.com/NaveenGumaste
---

# DevOps Observe

Prometheus + Grafana as they document it: instrument the process, scrape it, provision dashboards from git, alert on **symptoms**. Do not install a metrics stack on a static site or a Vercel-only app with no scrape target. Use the host's telemetry there unless they asked to run Prometheus.

## Action List (mandatory)

```
Findings:
- <process kind, existing /metrics, prometheus.yml, Grafana provisioning, host>
Will do:
- <instrumentation / scrape / dashboard / alert> — <signals>
Needs your OK:
- <self-host Prometheus+Grafana / Alertmanager destinations / paging>
Will not touch:
- <PaaS-only apps, client-side analytics, app features>
```

## When a full stack is wrong

| Situation | Do |
| --- | --- |
| Static site, library, CLI | skip this skill |
| Vercel / Cloudflare Pages, no long-running process | skip; mention host analytics |
| Container / VM / K8s / compose / Fly with a process | instrument + scrape |
| They named Prometheus/Grafana explicitly | instrument; stack only if they host it or asked |

## Instrumentation (Prometheus)

Per [Prometheus instrumentation](https://prometheus.io/docs/practices/instrumentation/):

- **Online-serving** (HTTP/API/LLM server): request **count**, **errors**, **latency** (histogram). In-progress gauge optional. Count at completion.
- **Offline / queue:** items in, in-progress, last processed timestamp (Unix timestamp, not "seconds since").
- **Batch:** last success timestamp + duration; Pushgateway only if it is a short batch they already run that way.

Use labels (`code`, `method`, `route` **bounded**). Do not label by user ID, email, or unbounded path. Metric names: `namespace_subsystem_name_unit` (`http_server_request_duration_seconds`). Counter if it only goes up; gauge if it can go down.

Default the series to 0 so they exist before traffic. One `/metrics` route, process-local. LLM apps: metrics on **your** server (queue depth, handler errors, latency). Do not scrape OpenAI/Anthropic.

Use the official client for the language already in the repo. Do not add a second metrics vendor if `/metrics` already exists.

## Scrape

`prometheus.yml` job for that target. Relabel to keep `job` + `instance` low-cardinality. Scrape interval 15–30s unless they have one. Do not scrape the whole VPC.

## Grafana (provisioning, not click-ops)

Per [Grafana provisioning](https://grafana.com/docs/grafana/latest/administration/provisioning/):

```
grafana/provisioning/
  datasources/datasources.yml   # Prometheus, access: proxy
  dashboards/dashboards.yml     # file provider
grafana/dashboards/             # JSON dashboards with stable uid
```

Datasource `type: prometheus`, `access: proxy`. Secrets in `secureJsonData` / env (`$PROM_URL`), not committed passwords. `allowUiUpdates: false` so git remains source of truth.

Dashboard: golden signals for **this** service (latency, traffic, errors, saturation) — not a 40-panel kitchen sink. Bounded PromQL (`rate`, `histogram_quantile`). No user-id labels.

## Alerting (Prometheus)

Per [Prometheus alerting](https://prometheus.io/docs/practices/alerting/): few alerts, **symptoms** (user-visible errors, latency high enough to hurt, burn of error budget), not "pod restarted". Slack in the threshold. Batch jobs: page only if last success is old enough to hurt (about two full run intervals).

Alert names CamelCase. Annotations: summary + a link to the Grafana dashboard. Do not add Alertmanager receivers (email/PagerDuty) without **Needs your OK**.

## Verify

- `/metrics` exposes the golden signals with stable names and bounded labels
- Prometheus config scrapes only that job (if a stack is in-repo)
- Grafana datasource + dashboard are provisioned files with a uid
- Alerts are symptom-based and few
- No metrics stack on a static/PaaS-only app unless they asked
- No vendor API keys in metrics labels

## Done when

The Action List was shown; instrumentation matches the process kind; Grafana is file-provisioned if a stack exists; paging destinations were approved or omitted.

Creator: Naveen Gumaste · [X](https://x.com/Z0D404) · [GitHub](https://github.com/NaveenGumaste)
