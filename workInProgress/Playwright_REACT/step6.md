# Step 6: Web-First Locators

Playwright recommends using **Role-based locators** (like `getByRole`) because they are more resilient to UI changes and enforce accessibility best practices.

### 1. Update the React App
Let's add some more interactive elements to our app to test advanced locators.

```bash
cat << 'EOF' > src/App.jsx
import { useState } from 'react'
import './App.css'

function App() {
  const [count, setCount] = useState(0)
  const [name, setName] = useState('')
  const [terms, setTerms] = useState(false)

  return (
    <div className="App">
      <h1>Vite + React</h1>
      <div className="card">
        <button onClick={() => setCount((count) => count + 1)}>
          count is {count}
        </button>
      </div>

      <div className="form">
        <label htmlFor="name-input">Name:</label>
        <input 
          id="name-input" 
          placeholder="Enter your name" 
          value={name} 
          onChange={(e) => setName(e.target.value)} 
        />
        
        <label>
          <input 
            type="checkbox" 
            checked={terms} 
            onChange={(e) => setTerms(e.target.checked)} 
          />
          I agree to the terms
        </label>
      </div>
    </div>
  )
}

export default App
EOF
```{{exec}}

### 2. Write a "Web-First" Test
Create `tests/locators.spec.js` using accessible locators and auto-waiting assertions.

```bash
cat << 'EOF' > tests/locators.spec.js
import { test, expect } from '@playwright/test';

test('advanced locators and assertions', async ({ page }) => {
  await page.goto('/');

  // 1. Locate by Role
  const heading = page.getByRole('heading', { name: /vite \+ react/i });
  await expect(heading).toBeVisible();

  // 2. Locate by Placeholder
  const input = page.getByPlaceholder('Enter your name');
  await input.fill('Killercoda User');
  await expect(input).toHaveValue('Killercoda User');

  // 3. Locate by Label (Checkbox)
  const checkbox = page.getByLabel('I agree to the terms');
  await expect(checkbox).not.toBeChecked();
  await checkbox.check();
  await expect(checkbox).toBeChecked();
});
EOF
```{{exec}}

### 3. Run the Test
`npx playwright test tests/locators.spec.js`{{exec}}

Notice how Playwright automatically waits for elements to be "Actionable" (visible, stable, enabled) before performing clicks or fills.
