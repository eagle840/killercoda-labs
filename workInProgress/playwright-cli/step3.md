# Interact with a page

Now we'll put the browser to work. We'll use the **TodoMVC** demo app — a clean, predictable target for learning interactions. First make sure the session is on the app:

`playwright-cli goto https://demo.playwright.dev/todomvc/`{{execute}}

Take a snapshot to see the refs:

`playwright-cli snapshot`{{execute}}

The main input (a text box with the placeholder **"What needs to be done?"**) should appear in the snapshot.

## Type text into the focused element

`type` types text into whatever editable element currently has focus. After `open`/`goto`, the main input is focused, so we can type directly:

`playwright-cli type "Buy groceries"`{{execute}}

Then press **Enter** to commit the todo:

`playwright-cli press Enter`{{execute}}

Add a couple more:

`playwright-cli type "Water flowers"`{{execute}}

`playwright-cli press Enter`{{execute}}

`playwright-cli type "Write a lab"`{{execute}}

`playwright-cli press Enter`{{execute}}

Take a snapshot — you should now see three list items, each with a checkbox ref and a label.

## Click and check

Snapshots assign refs to interactive elements. Grab a fresh snapshot and pick a ref (e.g. `e15`), then:

`playwright-cli snapshot`{{execute}}

Toggle the first todo as completed by checking its checkbox (use the checkbox ref you just saw):

`playwright-cli check e15`{{execute}}

You can uncheck it again:

`playwright-cli uncheck e15`{{execute}}

Confirm the count counter in the footer updates:

`playwright-cli snapshot`{{execute}}

### Target elements with selectors too

Refs are convenient, but you can also target with CSS or role selectors directly:

`playwright-cli click "role=button[name=All]"`{{execute}}

`playwright-cli click "role=button[name=Active]"`{{execute}}

`playwright-cli click "role=button[name=Completed]"`{{execute}}

`playwright-cli click "role=button[name=All]"`{{execute}}

You can also use a CSS selector:

`playwright-cli click "input.toggle"`{{execute}}

## Fill a form field

`fill` overwrites a field's value (unlike `type`, which appends). Let's try it on the main input:

`playwright-cli fill "input.new-todo" "Replaced by fill"`{{execute}}

## Take screenshots and PDF

Capture the current page:

`playwright-cli screenshot --filename=todo.png`{{execute}}

Killacoda presently doesn't have a image viewer, so lets use a web server to access them:

`npx http-server`{{exec}}

`npx http-server &`{{exec}}

and open {{TRAFFIC_HOST1_80}}

Capture a specific element by its snapshot ref (grab a ref from the input, then):

`playwright-cli screenshot e15 --filename=input.png`{{execute}}

Export the page as a PDF:

`playwright-cli pdf --filename=todo.pdf`{{execute}}

List the files we created:

`ls -la *.png *.pdf`{{execute}}

## What you learned

- `type <text>` types into the focused editable element; `press <key>` presses a key.
- `check <ref>` / `uncheck <ref>` toggle checkboxes and radios.
- Elements can be targeted by snapshot **refs** or by **CSS / role selectors**.
- `fill <selector> <text>` overwrites a field's value.
- `screenshot` and `pdf` export the current page (or a specific element) to a file.

>>Q1: You type text into whatever element currently has focus. Which keyword completes: `playwright-cli ____ "some text"`?<<
=== type
=~= type

>>Q2: Which command overwrites a field's value (rather than appending text)?<<
=== fill
=~= fill
