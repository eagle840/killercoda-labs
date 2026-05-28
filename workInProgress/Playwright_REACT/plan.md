# Playwright Expansion Plan: Visuals & Locators

## 1. Refinements (v0.1.3 Cleanup)
*   Fix `ctri-c` to `Ctrl+C` in Step 3.
*   Remove "WIP" notes from Step 4.
*   Streamline `npm create vite` in Step 2 to use `-- --template react`.
*   Move `http-server` install to Step 1.

## 2. New Step 6: The "Web-First" Approach (Locators)
*   **Objective:** Move beyond generic locators to accessible, resilient testing.
*   **Activity:** 
    *   Update the React app with a few more elements (a text input, a checkbox).
    *   Write a test using `page.getByRole()`, `page.getByLabel()`, and `page.getByPlaceholder()`.
    *   Demonstrate **Auto-waiting** assertions (e.g., `expect(locator).toBeChecked()`).

## 3. New Step 7: Visual Regression Testing
*   **Objective:** Detect visual changes that code assertions might miss.
*   **Activity:**
    *   Run `npx playwright test --update-snapshots` to generate a baseline.
    *   "Break" the UI (e.g., change a CSS color or padding via `sed`).
    *   Run the test again to see it fail with a visual difference.
    *   View the visual diff in the Playwright HTML report.

## 4. Final Polish
*   Update `index.json` to include Step 6 and Step 7.
*   Update `finish.md` to reflect these advanced skills.
