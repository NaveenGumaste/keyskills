---
name: test-inspect
description: Read the repo and record language, framework, version, package manager, existing test runner, test command, and public seams. Use when starting testing, or before fetching testing docs, adding a harness, writing tests, or running them.
metadata:
  author: Naveen Gumaste
  x: https://x.com/Z0D404
  github: https://github.com/NaveenGumaste
---

# Test Inspect

Read-only. No installs, no test files, no web lookup. Print one stack card per application. Then stop. test-sources looks up practices. The router loads the later skills.

## Action List (mandatory)

```
Findings:
- <manifests, lockfile, scripts, existing tests>
Stack card:
- app: <path>
- language:
- framework: <name> <version from the manifest or lock>
- package manager:
- test script: <command or none>
- runner already installed: <name or none>
- test roots: <dirs or files, or none>
- seams uncovered: <public entry points with no outside test>
- seams covered: <entry points an existing test already exercises>
```

Do not choose a runner here. Do not treat a framework name in the user's sentence as the stack when the manifests say otherwise.

## What to read

Detect from the tree. One stack card per app (a workspace package with its own entry). A library with a single manifest is one app.

More than three workspace apps, and the user named none: ask which apps to test, or default to the top-level / primary entry apps. Do not card every workspace package.

| Look in | Record |
| --- | --- |
| `package.json`, workspace file, lockfile | name, dependency versions, `scripts.test`, package manager |
| `pyproject.toml`, `requirements*.txt`, `Pipfile`, `manage.py` | Python app and version pins |
| `go.mod` | module and Go version |
| `Cargo.toml` | Rust package |
| `Gemfile` | Ruby app |
| `composer.json` | PHP app |
| `*.csproj`, `*.fsproj` | .NET target |
| `mix.exs` | Elixir app |
| `pubspec.yaml` | Dart app |
| `pom.xml`, `build.gradle*` | JVM app |

The framework is the application framework the entry files import. Record that dependency's installed version. Transitive UI kits and test libraries are not the framework. No manifest and no entry files: say the repo has no application code and stop.

Package manager is the tool that owns the lockfile in the repo (`bun.lock` / `bun.lockb`, `pnpm-lock.yaml`, `package-lock.json`, `yarn.lock`, `uv.lock`, `poetry.lock`, `go.sum`, `Cargo.lock`). Record that name on the stack card.

Runner already installed: a test script, a test config, or a declared test dependency. Record the name. test-sources decides whether that tool is the one the current docs mean. Several apps may differ. Do not collapse them into one card.

## Seams

A public seam is an entry another module, a user, or a framework can call without reaching into private helpers: an exported function, an HTTP route, a CLI command, a page or component public props, a framework handler.

- The user named files or a feature: list seams of that code only.
- They said "test this" with no path: list process entry points only (server main, routes, CLI bin, package exports, top-level UI entry). Do not list private helpers.
- Mark a seam covered when an existing test exercises it from the outside. Otherwise uncovered.

## Done when

The Action List is in the user-visible reply, every selected app has a stack card with evidence, seams are split covered vs uncovered, and no files were written.

Creator: Naveen Gumaste · [X](https://x.com/Z0D404) · [GitHub](https://github.com/NaveenGumaste)
