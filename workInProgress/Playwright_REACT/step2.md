# Hello React


```
mkdir myReact
cd myReact
mkdir public
cd public
mkdir scripts
touch index.html
touch ./scripts/app.js
cd ../..
pwd
```

```
mkdir test1
cd test1
```




`npm create vite@latest my-app --template react`{{exec}}

select

React > JavaScript


ls
`cd my-app`{{exec}}

`npm install`{{exec}}

`npm run dev`{{exec}}

`npm run dev -- --host 0.0.0.0`{{exec}}

or

`npm run dev -- --host`{{exec}}


`npm init playwright@latest`{{exec}}


Install additional dependenices for this Linux environment

`npx playwright install-deps`{{exec}}

`apt install -y tree`{{exec}}


`npx playwright test`{{exec}}


`npm install -g http-server`{{exec}}


`http-server playwright-report -a 0.0.0.0 -p 9323`{{exec}}

or modify Modify vite.config.js

```
import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

export default defineConfig({
  plugins: [react()],
  server: {
    host: '0.0.0.0',
    port: 5173,   // optional
  }
})
```



http://<killercoda-session-host>:9323
{{TRAFFIC_HOST1_9323}}

---
