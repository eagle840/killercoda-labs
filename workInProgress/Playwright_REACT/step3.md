# Step 3: Install Playwright

Now that our React app is running, let's install **Playwright**, a powerful tool for End-to-End (E2E) testing.

### 1. Initialize Playwright
Open a **new terminal tab** (or stop the server with `Ctrl+C` for a moment) and run:
```bash
npm init playwright@latest -- --yes --quiet --browser=chromium --lang=js
```{{exec}}

*Note: We are focusing on Chromium and JavaScript for this lab.*

### 2. Install System Dependencies
Playwright requires specific Linux libraries to run browsers headlessly.
`npx playwright install-deps`{{exec}}

### 3. Add a Custom Test
Let's create a test file named `tests/homepage.spec.js`.
```bash
cat << 'EOF' > tests/homepage.spec.js
import { test, expect } from '@playwright/test';

test('homepage loads', async ({ page }) => {
  await page.goto('/');
  await expect(page.locator('h1')).toBeVisible();
});
EOF
```{{exec}}

### 4. Run the Tests
Now, attempt to run your tests:
`npx playwright test`{{exec}}

### 🧠 Why did it fail?
You will notice that the default tests might pass, but your **homepage test** fails with an "Invalid URL" error.

This is because Playwright doesn't know where your application is hosted. In the test, we used:
`await page.goto('/');`

Without a configuration, Playwright doesn't know that `/` should resolve to `http://localhost:3000`. In the next step, we will fix this and automate the workflow.
