# Step 4: Automating the Workflow

Currently, you have to manually start the Vite server and then run Playwright. In a professional CI/CD environment, Playwright handles this automatically.

### 1. Configure the `baseURL` and `webServer`

By setting a `baseURL`, you can use relative paths like `page.goto('/')`. By adding a `webServer` block, Playwright will start your app automatically before running tests.

Run the following command to update `playwright.config.js`:

```bash
cat << 'EOF' > playwright.config.js
import { defineConfig, devices } from '@playwright/test';

export default defineConfig({
  testDir: './tests',
  fullyParallel: true,
  reporter: 'html',
  use: {
    baseURL: 'http://localhost:3000',
    trace: 'on-first-retry',
  },
  projects: [
    {
      name: 'chromium',
      use: { ...devices['Desktop Chrome'] },
    },
  ],
  webServer: {
    command: 'npm run dev',
    url: 'http://localhost:3000',
    reuseExistingServer: true,
  },
});
EOF
```{{exec}}

### 2. Run Tests Automatically

Now, you don't need a separate terminal running `npm run dev`. Playwright will detect if the server is down, start it, run the tests, and shut it down (unless `reuseExistingServer` is true).

`npx playwright test`{{exec}}

### 3. View the Results
To view the results in the Killercoda environment, we'll use a simple static server:
`npm install -g http-server`{{exec}}
`http-server playwright-report -a 0.0.0.0 -p 9323`{{exec}}

{{TRAFFIC_HOST1_9323}}

Playwright will now successfully navigate to `/` because it knows the `baseURL`.
