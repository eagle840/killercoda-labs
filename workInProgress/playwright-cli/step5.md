# DevTools & network

Now we'll look under the hood: the browser's **console**, the **network requests** it makes, and how to evaluate **JavaScript** and record **traces** and **video**. These are the diagnostic tools you'd use to debug an automation or investigate a page.

## Open a fresh session and enable monitoring

`playwright-cli goto https://demo.playwright.dev/todomvc/`{{execute}}

## Watch the console

The CLI collects console messages from the page. View them (optionally with a minimum log level):

`playwright-cli console`{{execute}}

If you add a todo, you may see React's dev warnings:

`playwright-cli type "Check console output"`{{execute}}

`playwright-cli press Enter`{{execute}}

`playwright-cli console`{{execute}}

## Inspect network requests

List the requests the page has made since load:

`playwright-cli requests`{{execute}}

Show full details of a specific request by its index number:

`playwright-cli request 0`{{execute}}

This shows method, status, headers, etc. — useful for understanding what a page loads and confirming API calls succeed.

## Evaluate JavaScript on the page

`eval` runs a JavaScript function in the page context and returns the result. Pass in an arrow function:

`playwright-cli eval '() => document.title'`{{execute}}

`playwright-cli eval '() => document.querySelectorAll("li").length'`{{execute}}

Count how many todo items exist:

`playwright-cli eval '() => document.querySelectorAll(".todo-list li").length'`{{execute}}

`run-code` is more powerful — it lets you run an arbitrary Playwright code snippet against the page. For example, read some text:

`playwright-cli run-code 'page => page.title()'`{{execute}}

## Record a trace and a video

Traces capture a full, inspectable record of a session (DOM snapshots, network, console, screenshots). Start a trace, do a couple of actions, then stop:

`playwright-cli tracing-start`{{execute}}

`playwright-cli type "Trace me"`{{execute}}

`playwright-cli press Enter`{{execute}}

`playwright-cli tracing-stop`{{execute}}

Similarly, you can record a video of the session (great for sharing reproductions):

`playwright-cli video-start`{{execute}}

`playwright-cli type "Video me"`{{execute}}

`playwright-cli press Enter`{{execute}}

`playwright-cli video-stop --filename=demo.webm`{{execute}}

List the artifacts produced:

`ls -la *.trace *.webm 2>/dev/null`{{execute}}

## What you learned

- `console` shows the page's console messages.
- `requests` / `request <n>` inspect network requests the page made.
- `eval` runs a JavaScript expression in the page and returns the result.
- `run-code` executes an arbitrary Playwright code snippet.
- `tracing-start/stop` and `video-start/stop` record debugging artifacts.

>>Q1: Which command evaluates a JavaScript expression in the page context?<<
=== eval
=~= eval

>>Q2: Which command lists the network requests the page has made?<<
=== requests
=~= requests
