# Design the user interface (UI)

We'll be using [Material Design](https://material.io/)


install the components

`npm install @mui/material @emotion/react @emotion/styled @mui/icons-material`{{exec}}

in main.jsx

```
import React from 'react'
import ReactDOM from 'react-dom/client'

import { ThemeProvider, createTheme } from '@mui/material/styles';
import CssBaseline from '@mui/material/CssBaseline';
const theme = createTheme();

import Pizza from './Pizza'

ReactDOM.createRoot(document.getElementById('root')).render(
  <React.StrictMode>
    <ThemeProvider theme={theme}>
      <CssBaseline />
      <Pizza className="Pizza"/>
    </ThemeProvider>
  </React.StrictMode>,
)
```


in pizzalist.jst replace html with

```
(
    <Box className="Box" sx={{ display: 'flex', flexDirection: 'column', alignItems: 'center' }}>
      <h2>{name}</h2>
      <form onSubmit={handleSubmit} style={{ display: 'flex', flexDirection: 'row', alignItems: 'center', gap: 8}}>
        <TextField label="Name" name="name" value={formData.name} onChange={handleFormChange} />
        <TextField label="Description" name="description" value={formData.description} onChange={handleFormChange} />
        <Button sx={{ mr: 1 }} variant="contained" type="submit">{editingId === null ? 'Create' : 'Update'}</Button>
        {editingId !== null && <Button variant="contained" color="secondary" onClick={handleCancel}>Cancel</Button>}
      </form>
      <List sx={{ width: '100%', maxWidth: 360 }}>
        {data.map(item => (
          <ListItem key={item.id} secondaryAction={
            <>
              <IconButton edge="end" aria-label="edit" onClick={() => handleEdit(item.id)}>
                <Edit />
              </IconButton>
              <IconButton edge="end" aria-label="delete" onClick={() => onDelete(item.id)}>
                <Delete />
              </IconButton>
            </>
          }>
            <ListItemText primary={item.name} secondary={item.description} />
          </ListItem>
        ))}
      </List>
      {error && <p>{error}</p>}
    </Box>
  );

```
