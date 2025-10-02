

# Step 1: Install Node.js with NVM

Before we can create a React application, we need to install Node.js and its package manager, npm. We'll use the Node Version Manager (nvm), a script that lets you easily install and manage different Node.js versions.

First, let's update our package lists.
`sudo apt update`{{exec}}

### 1. Install NVM

Run the following command to download and execute the nvm installation script.
```bash
# Download and install nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

# Source the script to apply the changes to the current session
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
```{{exec}}

### 2. Install Node.js

Now, we can use nvm to install a recent version of Node.js.
```bash
# Install the latest Long-Term Support (LTS) version of Node.js
nvm install --lts

# Verify the installation
node -v
npm -v
```{{exec}}

This will install the latest stable version of Node.js and npm, and you should see the version numbers printed in your terminal.




# Create the React front client

We'll be Using [React](https://react.dev/), and the [Vite](https://vitejs.dev/) web builder

`npm create vite@latest PizzaClient --template react`{{exec}}

#### Answer the CLI prompts as follows:

Package name: **pizzaclient** - The folder created by Vite uses Camel case, PizzaClient.

Select a framework: **React**

Select a variant: **Javascript**

`cd PizzaClient/`{{exec}}

`npm install`{{exec}}

Update vite.config.js

```
import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [react()],
  server: {
    port: 3000,  // Client port
    host: '0.0.0.0', // Bind to all network interfaces
    allowedHosts: true // allow all hosts
  }
})
```{{copy}}


## Start the app


`npm run dev`{{exec}}



{{TRAFFIC_HOST1_3000}}

exit the app with ctrl-c


# Build the Pizza component


create in src Pizza.jsx

`touch ./src/Pizza.jsx`{{exec}}

```
import { useState, useEffect } from 'react';
import PizzaList from './PizzaList';

const term = "Pizza";

function Pizza() {
  const [data, setData] = useState([]);
  const [maxId, setMaxId] = useState(0);

  useEffect(() => {
    fetchPizzaData();
  }, []);

  const fetchPizzaData = () => {
    // Simulate fetching data from API
    const pizzaData = [
      { id: 1, name: 'Margherita', description: 'Tomato sauce, mozzarella, and basil' },
      { id: 2, name: 'Pepperoni', description: 'Tomato sauce, mozzarella, and pepperoni' },
      { id: 3, name: 'Hawaiian', description: 'Tomato sauce, mozzarella, ham, and pineapple' },
    ];
    setData(pizzaData);
    setMaxId(Math.max(...pizzaData.map(pizza => pizza.id)));
  };

  const handleCreate = (item) => {
    // Simulate creating item on API
    const newItem = { ...item, id: data.length + 1 };
    setData([...data, newItem]);
    setMaxId(maxId + 1);
  };

  const handleUpdate = (item) => {
    // Simulate updating item on API
    const updatedData = data.map(pizza => pizza.id === item.id ? item : pizza);
    setData(updatedData);
  };

  const handleDelete = (id) => {
    // Simulate deleting item on API
    const updatedData = data.filter(pizza => pizza.id !== id);
    setData(updatedData);
  };


  return (
    <div>
      <PizzaList
        name={term}
        data={data}
        onCreate={handleCreate}
        onUpdate={handleUpdate}
        onDelete={handleDelete}
      />
    </div>
  );
}

export default Pizza;
```{{copy}}


create PizzaList.jsx

`touch ./src/PizzaList.jsx`{{exec}}

```
import { useState } from 'react';

function PizzaList({ name, data, onCreate, onUpdate, onDelete, error }) {
  const [formData, setFormData] = useState({ id: '', name: '', description: '' });
  const [editingId, setEditingId] = useState(null);

  const handleFormChange = (event) => {
    const { name, value } = event.target;
    setFormData(prevData => ({
      ...prevData,
      [name]: value,
    }));
  };

  const handleSubmit = (event) => {
    event.preventDefault();
    if (editingId) {
      onUpdate(formData);
      setEditingId(null);
    } else {
      onCreate(formData);
    }
    setFormData({ id: '', name: '', description: '' });
  };

  const handleEdit = (item) => {
    setEditingId(item.id);
    setFormData({
      id: item.id,
      name: item.name,
      description: item.description,
    });
  };

  const handleCancelEdit = () => {
    setEditingId(null);
    setFormData({ id: '', name: '', description: '' });
  };


  return (
    <div>
      <h2>New {name}</h2>
      <form onSubmit={handleSubmit}>
        <input
          type="text"
          name="name"
          placeholder="Name"
          value={formData.name}
          onChange={handleFormChange}
        />
        <input
          type="text"
          name="description"
          placeholder="Description"
          value={formData.description}
          onChange={handleFormChange}
        />
        <button type="submit">{editingId ? 'Update' : 'Create'}</button>
        {editingId && <button type="button" onClick={handleCancelEdit}>Cancel</button>}
      </form>
      {error && <div>{error.message}</div>}
      <h2>{name}s</h2>
      <ul>
        {data.map(item => (
          <li key={item.id}>
            <div>{item.name} - {item.description}</div>
            <div><button onClick={() => handleEdit(item)}>Edit</button>
            <button onClick={() => onDelete(item.id)}>Delete</button></div>
          </li>
        ))}
      </ul>
    </div>
  );
}

export default PizzaList;
```{{copy}}

in main.jsx, replace with

```
import React from 'react'
import ReactDOM from 'react-dom/client'

import Pizza from './Pizza'

ReactDOM.createRoot(document.getElementById('root')).render(
  <React.StrictMode>
    <Pizza />
  </React.StrictMode>,
)
```{{copy}}

And run the app:

`npm run dev`{{exec}}

{{TRAFFIC_HOST1_3000}}
