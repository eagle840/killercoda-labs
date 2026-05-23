# Playwright & React Lab Improvement Plan

## 1. Audit & Cleanup
*   **Remove Unrelated Assets:** The `assets/` folder contains RabbitMQ/Python scripts (`send.py`, etc.) which are listed in `index.json`. These should be removed as they are irrelevant to Playwright/React.
*   **Fix `index.json`:** Remove the `assets` section referencing the Python files.

## 2. Proposed New Steps

### Step 4: Automating the Workflow (`playwright.config.js`)
*   **The Problem:** In Step 3, the test failed because it didn't know the `baseURL`.
*   **The Fix:** Update `playwright.config.js` to include:
    *   `baseURL: 'http://localhost:5173'` (or port 3000).
    *   `webServer` configuration so Playwright starts the Vite dev server automatically.
*   **Goal:** User runs `npx playwright test` and it "just works" without manually starting the server in a separate terminal.

### Step 5: Testing Interactions & Traces
*   **Component Interaction:** Write a test for the default Vite counter.
    *   Click the "count is 0" button.
    *   Assert the text changes to "count is 1".
*   **Debugging with Traces:**
    *   Enable `trace: 'on'` in the config.
    *   Run a failing test.
    *   Use `http-server` to view the HTML report and show how to open the **Trace Viewer** to see the "action log" and "snapshots". This is the most powerful way to debug in a headless environment like Killercoda.

## 3. Final Polish
*   **Finish Page:** Summarize the E2E testing lifecycle (Build -> Test -> Report -> Trace).
*   **Resources:** Link to Playwright's "Best Practices" and "Locators" documentation.

## Verification
*   Verify that `npx playwright install-deps` is run (already in Step 2).
*   Ensure the `http-server` ports (9323) are consistently used for reporting.
