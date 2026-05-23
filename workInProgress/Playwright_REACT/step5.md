# Step 5: Testing Interactions and Traces

One of Playwright's most powerful features is the **Trace Viewer**, which allows you to record everything that happened during a test.

### 1. Write an Interactive Test

Let's test the "counter" button in the default Vite app.

```bash
cat << 'EOF' > tests/counter.spec.js
import { test, expect } from '@playwright/test';

test('counter increments when clicked', async ({ page }) => {
  await page.goto('/');

  // Find the button by its text content
  const counter = page.getByRole('button', { name: /count is/i });
  
  // Check initial state
  await expect(counter).toHaveText('count is 0');
  
  // Click it!
  await counter.click();
  
  // Verify it incremented
  await expect(counter).toHaveText('count is 1');
});
EOF
```{{exec}}

### 2. Enable Tracing

Update the config to record a trace for every test.

```bash
sed -i "s/trace: 'on-first-retry'/trace: 'on'/g" playwright.config.js
```{{exec}}

### 3. Run and View Traces

`npx playwright test`{{exec}}

Now, start the report server again:

`http-server playwright-report -a 0.0.0.0 -p 9323`{{exec}}

{{TRAFFIC_HOST1_9323}}

In the report, click on the **counter.spec.js** test. You will see a **Traces** section at the bottom. Click the image to open the **Trace Viewer**. You can now hover over each action (click, navigation) and see exactly what the browser looked like at that moment!
