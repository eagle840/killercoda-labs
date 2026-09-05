# Install Node.js & playwright-cli

First we need a modern **Node.js**. `playwright-cli` requires **Node.js 20 or newer** (the docs recommend 20+). The base Ubuntu image ships an old Node, so we'll install a current LTS version using the official NodeSource repository.

Run on the terminal:

`curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -`{{execute}}

This adds the NodeSource apt repository. Now install Node (this may take a minute):

`sudo apt-get install -y nodejs`{{execute}}

Check the version — it should be **v20** or newer:

`node --version`{{execute}}

`npm --version`{{execute}}


## Install playwright-cli globally

Now install the CLI package globally:

`sudo npm install -g @playwright/cli@latest`{{execute}}

Confirm it is on your path and see the help output:

`which playwright-cli`{{execute}}

`playwright-cli --help`{{execute}}

Take a moment to scroll the help — you'll see categories for **Interact**, **Navigate**, **Target**, **Save as**, **DevTools**, **Sessions** and more. We'll use many of these in the coming steps.

## Install the browser and config

`playwright-cli` drives real browsers. Install the **Chromium** browser binary it needs (this is the big download, be patient):


`npx playwright install-deps`{{exec}}

`npx playwright install`{{exec}} # installs the browser binaries

WIP `playwright-cli install-browser chromium`{{execute}}

`npx playwright install chrome`{{exec}}





The scenario also ships a pinned config file that the CLI loads automatically from `~/.playwright/cli.config.json`. Verify it's there:

`cat ~/.playwright/cli.config.json`{{execute}}

You should see a JSON config setting the browser to `chromium` with a 1280x720 viewport.

## What you learned

- A modern Node.js (20+) is required by `playwright-cli`.
- `npm install -g @playwright/cli` installs the `playwright-cli` command.
- `playwright-cli --help` reveals the full command surface.
- The CLI needs a browser binary (Chromium by default) installed separately.
- Configuration lives in `~/.playwright/cli.config.json`.
