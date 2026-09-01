# Open pages & snapshots

The CLI runs a persistent browser in the background. The first command below **opens** a browser session and navigates to the TodoMVC demo app. Note that it prints a tidy snapshot: page URL, page title, and an accessibility tree.

## You'll need to NOT be root

```{{bash}}
# Create a new user (e.g., 'coder')
useradd -ms /bin/bash coder

# Switch to the new user
su - coder
```{{exec}}

## Open a page


`playwright-cli open https://demo.playwright.dev/todomvc/`{{execute}}

You should see output like:

```
### Page
- Page URL: https://demo.playwright.dev/todomvc/
- Page Title: React • TodoMVC

### Snapshot
...
```

The **Snapshot** section lists the page accessibility tree. Each interactive element has a **ref** like `e15`. You'll use these refs to target elements with commands such as `click`, `fill`, and `check`.

## Navigate within the session

The browser session stays alive between commands. You can navigate to a new URL without re-opening:

`playwright-cli goto https://playwright.dev/`{{execute}}

This visits the Playwright homepage. Now head back to the demo app:

`playwright-cli goto https://demo.playwright.dev/todomvc/`{{execute}}

Other navigation commands you can try:

`playwright-cli go-back`{{execute}}

`playwright-cli go-forward`{{execute}}

`playwright-cli reload`{{execute}}

## Take a snapshot anytime

`goto` and `open` print a snapshot automatically. To re-print the snapshot of the current page at any time:

`playwright-cli snapshot`{{execute}}

Notice the element refs. They're assigned to the element positions in the accessibility tree and are used to target actions — we'll put them to work in the next step.

## What you learned

- `open <url>` starts a session and navigates, printing a snapshot.
- `goto <url>` navigates the current session to a new URL.
- `go-back`, `go-forward`, and `reload` navigate without a URL.
- `snapshot` prints the current page's accessibility tree with element **refs**.
- The session is persistent — a daemon keeps the browser running between commands.

>>Q1: Which command prints the current page's accessibility tree with element refs?<<
=== snapshot
=~= snapshot

>>Q2: True or false: playwright-cli keeps the browser running between commands.<<
=== true
=~= true
