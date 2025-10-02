# Step 2: Create a React App with Vite

With Node.js installed, we can now create our React application. We will use **Vite**, a modern and extremely fast build tool that provides an excellent development experience.

### 1. Scaffold the Project

Run the following command to create a new React project named `my-app`:
```bash
npm create vite@latest my-app -- --template react
```{{exec}}

This command uses the official React template to set up a project structure for you.

### 2. Configure the Dev Server

Before we can run the app, we need to make a small change to Vite's configuration to ensure it works correctly within the Killercoda environment.

First, navigate into your new project directory:
`cd my-app`{{exec}}

Next, I'll use a command to update the `vite.config.js` file to accept external network connections.
`echo "import { defineConfig } from 'vite';\nimport react from '@vitejs/plugin-react';\n\nexport default defineConfig({\n  plugins: [react()],\n  server: {\n    host: '0.0.0.0',\n    port: 3000\n  }\n});" > vite.config.js`{{exec}}

### 3. Install Dependencies and Run

Finally, install the project dependencies and start the development server:
```bash
npm install
npm run dev
```{{exec}}

Vite will start the server, and you'll see a link in the terminal to view your new React application.

---