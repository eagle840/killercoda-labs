# Step 2: Create a React App with Vite

With Node.js installed, we can now create our React application. We will use **Vite**, a modern and extremely fast build tool that provides an excellent development experience.

### 1. Scaffold the Project

Run the following command to create a new React project named `my-app`:
```bash
npm create vite@latest my-app -- --template react
```{{exec}}

This command uses the official React template to set up a project structure for you.

### 2. Configure the Dev Server

Navigate into your new project directory. **All subsequent commands in this step should be run from inside this `my-app` directory.**
```bash
cd my-app
```{{exec}}

Next, you need to update the Vite configuration to work in this environment. Open the `vite.config.js` file and **replace all of its content** with the code below. This tells the dev server to listen on all network interfaces.

```javascript
import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [react()],
  server: {
    host: '0.0.0.0',
    port: 3000,
    allowedHosts: true // allow all hosts
  }
});
```{{copy}}

### 3. Install Dependencies and Run

Finally, install the project dependencies and start the development server:
```bash
npm install
npm run dev
```{{exec}}

Vite will start the server, and you'll see a link in the terminal to view your new React application.

---
