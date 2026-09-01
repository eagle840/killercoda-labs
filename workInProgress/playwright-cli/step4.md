# Sessions, storage & state

So far you've used the **default session**. The CLI can run multiple isolated browser sessions side-by-side, each with its own cookies, local storage, and tab state. This is how you'd keep work for different projects (or different logins) separate.

## Named sessions

By default, the CLI keeps the browser **profile in memory** — cookies and storage persist across commands *within* a session, but are lost when the browser closes. Named sessions let you spin up isolated instances and keep them around.

List all active sessions:

`playwright-cli list`{{execute}}

Open a **named** session pointed at the TodoMVC app:

`playwright-cli -s=lab open https://demo.playwright.dev/todomvc/`{{execute}}

The `-s=lab` flag selects the session named `lab`. Add a couple of todos in that session:

`playwright-cli -s=lab type "Session todo one"`{{execute}}

`playwright-cli -s=lab press Enter`{{execute}}

`playwright-cli -s=lab type "Session todo two"`{{execute}}

`playwright-cli -s=lab press Enter`{{execute}}

Now confirm both sessions exist:

`playwright-cli list`{{execute}}

You should see both the default session and the `lab` session listed.

## Save and load storage state

Browsing state (cookies, localStorage) can be saved to a file and re-loaded later — great for persisting a login across test runs. Save the `lab` session's state:

`playwright-cli -s=lab state-save lab-state.json`{{execute}}

Look at the saved file — for TodoMVC it holds localStorage entries (the React app stores todos in localStorage):

`cat lab-state.json`{{execute}}

Now close the `lab` session, which wipes its in-memory state:

`playwright-cli -s=lab close`{{execute}}

Re-open the app in a fresh named session:

`playwright-cli -s=restored open https://demo.playwright.dev/todomvc/`{{execute}}

The fresh session is empty. Load the saved state back:

`playwright-cli -s=restored state-load lab-state.json`{{execute}}

Reload the page so the app re-reads its localStorage:

`playwright-cli -s=restored reload`{{execute}}

`playwright-cli -s=restored snapshot`{{execute}}

The todos you saved should be back. That's persistent browser state without re-doing the work.

## Clean up sessions

You can inspect cookies and localStorage too (try a site that uses cookies, like a search or commerce page), and close sessions when done:

`playwright-cli -s=restored close`{{execute}}

`playwright-cli close-all`{{execute}}

`playwright-cli list`{{execute}}

## What you learned

- Named sessions (`-s=name`) give you isolated browser instances with separate state.
- `state-save <file>` writes cookies + localStorage to a file.
- `state-load <file>` restores that state into a session.
- `close`, `close-all`, and `list` manage sessions.

>>Q1: Which flag selects a named session?<<
=== -s=
=~= -s=

>>Q2: Which options saves the current session's cookies and localStorage to a file?<<
=== state-save
=~= state-save
