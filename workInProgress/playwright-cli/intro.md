# Browser automation with playwright-cli

`playwright-cli` is a command-line interface for **browser automation** built on top of Microsoft's [Playwright](https://playwright.dev/). It is designed to be **token-efficient** and easy to drive, so it works great both **manually** from your terminal and as the browser-control layer for **AI coding agents** (Claude Code, GitHub Copilot, and similar).

Instead of writing a full test suite, you run small, terse commands against a persistent browser session:

```
playwright-cli open https://demo.playwright.dev/todomvc/
playwright-cli type "Buy groceries"
playwright-cli press Enter
playwright-cli snapshot
playwright-cli click e15
playwright-cli screenshot
```

The CLI keeps the browser running in the background (a daemon), so there is no startup cost per command, and every command prints a concise snapshot of the current page state — nothing more.

In this scenario you will:

- Install Node.js and `playwright-cli` with a pinned config.
- Open pages and inspect them with accessible snapshots.
- Click, type, fill, and press keys against a real web app.
- Work with named sessions and save/load browser state.
- Peak into the browser's console, network, and traces.

This lab is set up as a **learning experience**. Automating third-party websites should always respect their terms of service, and any automation you write should **never be aimed at production systems** unless you know exactly what you are doing.

Last updated: 2026-09-01 · Version 1.0
