# Add a Playwright Test File


```
mkdir -p tests
```

```
cat << 'EOF' > tests/homepage.spec.js
import { test, expect } from '@playwright/test';

test('homepage loads', async ({ page }) => {
  await page.goto('/');
  await expect(page.locator('h1')).toBeVisible();
});
EOF
```
#  Re-run Tests With Your New Spec


```
npx playwright test
npx playwright show-report
```


```
http-server playwright-report -a 0.0.0.0 -p 9323
```
