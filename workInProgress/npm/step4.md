STep 4

## add proxy

update **vite.config.js in** PizzaClient

`cd ~`{{exec}}

`cd PizzaClient/`{{exec}}

CHANGE port to 5000


```
import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [react()],
  server: {
    port: 3000,  // Client port
    host: '0.0.0.0', // Bind to all network interfaces
    proxy: {
      '/pizzas': {
        target: 'http://localhost:5000', // Server port
        changeOrigin: true,
        secure: false,
        ws: true,
        configure: (proxy, _options) => {
          proxy.on('error', (err, _req, _res) => {
            console.log('proxy error', err);
          });
          proxy.on('proxyReq', (proxyReq, req, _res) => {
            console.log('Sending Request to the Target:', req.method, req.url);
          });
          proxy.on('proxyRes', (proxyRes, req, _res) => {
            console.log('Received Response from the Target:', proxyRes.statusCode, req.url);
          });
        },
      }
    }
  }
})
```{{copy}}
`npm run dev`{{exec}}

{{TRAFFIC_HOST1_3000}}

Add a pizza to the menu, and confirm it's showing up it the 'GET /Pissa'

{{TRAFFIC_HOST1_5000}}/swagger

WIP it's not showing
