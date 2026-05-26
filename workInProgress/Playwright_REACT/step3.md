# Step 3: Install Playwright

Now that our React app is running, let's install **Playwright**, a powerful tool for End-to-End (E2E) testing.

## Docs

To review the cli commands, check out https://playwright.dev/docs/getting-started-cli

### 1. Initialize Playwright
Terminate the app with `ctri-c`, and install playwrite

```bash
npm init playwright@latest --  --quiet --browser=chromium --lang=js
```{{exec}}

*Note: We are focusing on Chromium and JavaScript for this lab.*

### 2. Install System Dependencies
Playwright requires specific Linux libraries to run browsers headlessly.
`npx playwright install-deps`{{exec}}

### 3. Run the Default test

Playwrite comes preconfigured to run tests against it's own web site, lets take a look

`cat ./tests/example.spec.js`{{exec}}

### 4. Run the Tests
Now, attempt to run your tests:
`npx playwright test`{{exec}}

### 5. Review the report

Normally we could run `npx playwright show-report` to see the gui report, but since we are on katacoda

`npm install -g http-server`{{exec}}

`http-server playwright-report -a 0.0.0.0 -p 9323`{{exec}}

Lets look at the html report, note now each section is run for chromium, firefox and webkit.

{{TRAFFIC_HOST1_9323}}


### 3. Add a Custom Test for React

Let's create a test file named `tests/homepage.spec.js`.

wip: note that a port 3000 isn't speced

```bash
cat << 'EOF' > tests/homepage.spec.js
import { test, expect } from '@playwright/test';

test('React homepage loads', async ({ page }) => {
  await page.goto('/');
  await expect(page.locator('h1')).toBeVisible();
});
EOF
```{{exec}}

### 4. Run the Tests
Now, attempt to run your tests:
`npx playwright test`{{exec}}

`http-server playwright-report -a 0.0.0.0 -p 9323`{{exec}}

Lets look at the html report, note now each section is run for chromium, firefox and webkit.

{{TRAFFIC_HOST1_9323}}



