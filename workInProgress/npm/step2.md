# mock api

Using the npm built in api server [json-server](https://www.npmjs.com/package/json-server)

Start a new terminal

`touch db.json`{{exec}}

```
{
  "pizzas": [
      { "id": 1, "name": "Margherita", "description": "Tomato sauce, mozzarella, and basil" },
      { "id": 2, "name": "Pepperoni", "description": "Tomato sauce, mozzarella, and pepperoni" },
      { "id": 3, "name": "Hawaiian", "description": "Tomato sauce, mozzarella, ham, and pineapple" }
  ]
}
```{{copy}}

then run the program json-server


`npx json-server --watch db.json --port 5100`{{exec}}

add extention for curk to vsc

curl http://localhost:5100/pizzas

using the code on https://learn.microsoft.com/en-us/training/modules/build-web-api-minimal-spa/5-exercise-create-api

add the mocked api

lets add the code to connect with the api in Pizza.jsx

```
import { useState, useEffect } from 'react';
import PizzaList from './PizzaList';

const term = "Pizza";
const API_URL = '/pizzas';
const headers = {
  'Content-Type': 'application/json',
};

function Pizza() {
  const [data, setData] = useState([]);
  const [error, setError] = useState(null);

  useEffect(() => {
    fetchPizzaData();
  }, []);

  const fetchPizzaData = () => {
    fetch(API_URL)
      .then(response => response.json())
      .then(data => setData(data))
      .catch(error => setError(error));
  };

  const handleCreate = (item) => {

    console.log(`add item: ${JSON.stringify(item)}`)

    fetch(API_URL, {
      method: 'POST',
      headers,
      body: JSON.stringify({name: item.name, description: item.description}),
    })
      .then(response => response.json())
      .then(returnedItem => setData([...data, returnedItem]))
      .catch(error => setError(error));
  };

  const handleUpdate = (updatedItem) => {

    console.log(`update item: ${JSON.stringify(updatedItem)}`)

    fetch(`${API_URL}/${updatedItem.id}`, {
      method: 'PUT',
      headers,
      body: JSON.stringify(updatedItem),
    })
      .then(() => setData(data.map(item => item.id === updatedItem.id ? updatedItem : item)))
      .catch(error => setError(error));
  };

  const handleDelete = (id) => {
    fetch(`${API_URL}/${id}`, {
      method: 'DELETE',
      headers,
    })
      .then(() => setData(data.filter(item => item.id !== id)))
      .catch(error => console.error('Error deleting item:', error));
  };


  return (
    <div>
      <PizzaList
        name={term}
        data={data}
        error={error}
        onCreate={handleCreate}
        onUpdate={handleUpdate}
        onDelete={handleDelete}
      />
    </div>
  );
}

export default Pizza;
```{{copy}}

Then add proxy in vite.config.js
```
import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [react()],
  server: {
    port: 3000,  // Client port
    proxy: {
      '/pizzas': {
        target: 'http://localhost:5100', // Mock server port
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


`npx json-server --watch --port 5100 db.json`{{exec}}