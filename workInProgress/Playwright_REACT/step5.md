# Step 5: Testing Interactions and Traces

One of Playwright's most powerful features is the **Trace Viewer**, which provides a "flight recorder" for your tests.

### 1. Write an Interactive Test
Let's test the "counter" button in the default Vite app. This test will click the button and verify the count increases.

```bash
cat << 'EOF' > tests/counter.spec.js
import { test, expect } from '@playwright/test';

test('counter increments when clicked', async ({ page }) => {
  await page.goto('/');

  // Locate the button by its text content
  const counter = page.getByRole('button', { name: /count is/i });
  
  // Assert initial state
  await expect(counter).toHaveText('count is 0');
  
  // Click the button
  await counter.click();
  
  // Assert final state
  await expect(counter).toHaveText('count is 1');
});
EOF
```{{exec}}

### 2. Enable Tracing
Update your configuration to record a trace for every test run.

```bash
sed -i "s/trace: 'on-first-retry'/trace: 'on'/g" playwright.config.js
```{{exec}}

### 3. Run and View Traces
`npx playwright test`{{exec}}

Start the report server again (if not already running):
`http-server playwright-report -a 0.0.0.0 -p 9323`{{exec}}

{{TRAFFIC_HOST1_9323}}

**Action:**
1. Open the report link.
2. Click on the **counter.spec.js** test results.
3. Scroll down to the **Traces** section and click the image to open the **Trace Viewer**.
4. You can now step through each action (click, navigation) and see exactly what the browser looked like at that moment!
