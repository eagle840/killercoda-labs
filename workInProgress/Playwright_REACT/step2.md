# Step 2: Create a React App with Vite

We will use **Vite** to scaffold a modern React application. Vite is significantly faster and more lightweight than older tools like `create-react-app`.

### 1. Scaffold the Project
Run the following command to create a new React project named `my-app` using the JavaScript template.
```bash
npm create vite@latest my-app -- --template react
cd my-app
npm install
```{{exec}}

### 2. Configure Vite for Killercoda
To access our application from outside the terminal, we need to configure Vite to bind to all network interfaces (`0.0.0.0`) and allow all hosts.

```bash
cat << 'EOF' > vite.config.js
import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

export default defineConfig({
  plugins: [react()],
  server: {
    port: 3000,
    host: '0.0.0.0',
    allowedHosts: true
  }
})
EOF
```{{exec}}

### 3. Start the Development Server
Now, start the application:
`npm run dev`{{exec}}

The application is now running on port 3000. You can view it by clicking the link below:

{{TRAFFIC_HOST1_3000}}

*Note: Keep this server running. In the next steps, we will install Playwright in a new terminal session or automate the startup process.*
