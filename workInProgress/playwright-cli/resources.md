# Notes & resources for the playwright-cli scenario

## Topic and alternatives considered

The user asked for "playwright-cli". There are two distinct tools with that name:

1. **`@playwright/cli` — the `playwright-cli` command** (microsoft/playwright-cli). A **token-efficient, interactive browser-automation CLI** launched officially in 2026. It runs a persistent browser daemon and exposes terse commands (`open`, `snapshot`, `click <ref>`, `fill`, `screenshot`, `eval`, `requests`, `state-save`, etc.). It is designed primarily for **AI coding agents** (Claude Code, GitHub Copilot) but is fully usable manually. **This is what the scenario teaches.**

2. **The standard Playwright CLI** (`@playwright/test`, invoked as `npx playwright test` / `codegen` / `install`). The classic **test runner** CLI for CI/test-suite work.

### Trade-offs (chosen tool vs alternatives)

| Tool | Best for | Notes |
|------|----------|-------|
| **`@playwright/cli`** (chosen) | Coding agents + quick manual automation | Low token cost, skill-based, persistent daemon sessions, ref-based. |
| **Playwright MCP** | Long autonomous agent loops, exploratory automation | Richer introspection, higher token cost, persistent state. |
| **Standard test runner** (`npx playwright test`) | CI, regression suites, reproducible tests | One-shot execution, config, reporters, sharding. |

The repo's existing "CLI + curl" lab theme (tcpdumpnc, swaggerandpy, etc.) pairs well with a hands-on CLI lab, and the command's name matches the user's request exactly.

## Versions (pinned / as of last update)

- Node.js **20 LTS** (CLI requires Node 20+). Installed via NodeSource `setup_20.x`.
- `@playwright/cli@latest` — pinned to `latest` in the install command; browsers installed via `playwright-cli install chromium`.
- A `.playwright/cli.config.json` config file is shipped as an asset to pin defaults (chromium, 1280x720 viewport, 30s timeout) for reproducibility.

## Backend note

Chosen backend: `imageid: ubuntu:2004`. The base image ships an old Node via apt, so step 1 installs Node 20 from NodeSource. The Chromium binary download in step 1 is the slowest operation; the step's timing reflects that.

## Known gotchas

- `type` appends text to the focused element; `fill` overwrites a selected field's value.
- Element **refs** from `snapshot` are positional and can change between snapshots — prefer stable CSS/role selectors for re-runnable commands.
- Default session keeps state in memory (lost on browser close); use `--persistent` or `state-save`/`state-load` to persist.

## Official links

- Getting started: https://playwright.dev/docs/getting-started-cli
- CLI intro: https://playwright.dev/agent-cli/introduction
- Repo: https://github.com/microsoft/playwright-cli
- Standard test-runner CLI: https://playwright.dev/docs/test-cli

## Older scaffold / history

None — this is a new scenario created 2026-09-01.
