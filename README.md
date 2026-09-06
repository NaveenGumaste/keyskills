# Agent Skills

Portable agent skills for repo init: SEO, design, git, and cleanup.

## Install

```bash
npx skills add <you>/agent-skills
```

Same command works with `bunx`, `pnpm dlx`, and `yarn dlx`.

The CLI lists the four skills and asks which ones to install, which agents to target, and project vs global.

### Non-interactive

```bash
npx skills add <you>/agent-skills --list
npx skills add <you>/agent-skills --skill seo-setup -y
npx skills add <you>/agent-skills --skill seo-setup --skill design-skill -a claude-code -a cursor -y
npx skills add <you>/agent-skills --all -y
```

### Skills

| Install name       | When to pick it                                       |
| ------------------ | ----------------------------------------------------- |
| `seo-setup`        | Metadata, sitemap, robots, JSON-LD, Open Graph        |
| `design-skill`     | Frontend UI that should not look like default AI slop |
| `git-skill`        | Commits, branches, ignores, PR hygiene                |
| `codebase-cleanup` | Dead code, unused deps, lint/format, structure        |
