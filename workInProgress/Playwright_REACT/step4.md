# Step 4: Automating the Workflow

Currently, you have to manually start the Vite server and then run Playwright in a separate terminal. In a professional CI/CD environment, Playwright handles this automatically.

### 1. Configure the `baseURL`

By setting a `baseURL`, you can use relative paths like `page.goto('/')` in your tests.

Run the following command to update `playwright.config.js`:

```bash
cat << 'EOF' > playwright.config.js
import { defineConfig, devices } from '@playwright/test';

export default defineConfig({
  testDir: './tests',
  fullyParallel: true,
  forbidOnly: !!process.env.CI,
  retries: process.env.CI ? 2 : 0,
  workers: process.env.CI ? 1 : undefined,
  reporter: 'html',
  use: {
    baseURL: 'http://localhost:5173',
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
    url: 'http://localhost:5173',
    reuseExistingServer: !process.env.CI,
  },
});
EOF
```{{exec}}

### 2. Run Tests Automatically

Now, you don't need to have `npm run dev` running in another terminal. Playwright will detect if the server is down, start it, run the tests, and shut it down.

Close any running dev servers (Ctrl+C) and run:

`npx playwright test`{{exec}}

Playwright will now successfully navigate to `/` because it knows the `baseURL`.
