# Getting started


https://mui.com/material-ui/getting-started/installation/

`mkdir react1; cd react1`{{exec}}

`npm create vite@latest my-app -- --template react`{{exec}}

`cd my-app`{{exec}}




`npm i react react-dom -y`{{exec}}


`npm install @mui/material @emotion/react @emotion/styled`{{exec}}


Material UI uses the Roboto font by default

`npm install @fontsource/roboto`{{exec}}

To use the font Icon component

`npm install @mui/icons-material`{{exec}}


## QUICK START

https://mui.com/material-ui/getting-started/usage/

Replace the contents of src/App.jsx with your component code:



```javascript
import * as React from 'react';
import Button from '@mui/material/Button';

export default function ButtonUsage() {
  return <Button variant="contained">Hello world</Button>;
}
```


### WIP (coPilot)

Ensure src/main.jsx renders your ButtonUsage component:

```
import React from 'react';
import ReactDOM from 'react-dom/client';
import ButtonUsage from './App';
import './index.css';

ReactDOM.createRoot(document.getElementById('root')).render(
  <React.StrictMode>
    <ButtonUsage />
  </React.StrictMode>
);
```{{copy}}

5. Run Your Project
Start the development server to see your component in action:

first update  vite.config.js

```
import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

// https://vite.dev/config/
export default defineConfig({
  plugins: [react()],
  server: {
    host: '0.0.0.0',
    allowedHosts: true
  }
})
```{{copy}}

`npm run dev`{{copy}}

`npm run dev -- --host 0.0.0.0`{{exec}}

This will open your project in the browser, typically at http://localhost:5173.

6. Build for Production
To package your project into static files, run:

`npm run build`{{exec}}

This command will create a dist directory with all the necessary files to deploy your application. You can then serve these files using any static file server.

---

## BELOW NO LONGER MAINTAINED


https://create-react-app.dev/docs/getting-started/

`npx create-react-app my-app`{{exec}}

`cd my-app`{{exec}}

in ./src/.env  add  'HOST=0.0.0.0'  WIP is this needed?

`npm start`{{exec}}


## Tic Tac Toe

https://react.dev/learn/tutorial-tic-tac-toe
