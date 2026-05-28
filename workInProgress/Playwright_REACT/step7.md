# Step 7: Visual Regression Testing

Visual testing catches bugs that code assertions might miss, such as shifted layouts, incorrect colors, or broken icons.

### 1. Generate Baseline Snapshots
Run the following command to capture the "correct" version of your UI. Playwright will store these images in your project.

`npx playwright test tests/homepage.spec.js --update-snapshots`{{exec}}

Take a look at the generated snapshot:
`ls tests/homepage.spec.js-snapshots/`{{exec}}

### 2. Introduce a Visual "Bug"
Let's simulate a regression by changing the color of the heading using CSS.

```bash
sed -i 's/color: inherit/color: red/' src/App.css
```{{exec}}

### 3. Detect the Regression
Run the test again. Playwright will compare the live browser against the baseline snapshot and fail if they don't match.

`npx playwright test tests/homepage.spec.js`{{exec}}

### 4. Inspect the Diff
Start the report server to see the visual comparison.

`http-server playwright-report -a 0.0.0.0 -p 9323`{{exec}}

{{TRAFFIC_HOST1_9323}}

**Action:**
1. Open the report.
2. Click the failed **homepage.spec.js** test.
3. Click the **Image Diff** tab. You will see three images: **Expected**, **Actual**, and **Diff** (highlighting the red text in this case).
