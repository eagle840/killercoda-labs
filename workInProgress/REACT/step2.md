# Hello React

We'll be using the 'old world' (ie, not things like Vite)

`mkdir myReact`{{exec}}

`cd myReact`{{exec}}

`mkdir public`{{exec}}

index.html

```
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Bare Bones HTML</title>
</head>
<body>

    <h1>Hello World!</h1>
    <p>This is a bare-bones page with NO scripting and NO React.</p>

</body>
</html>
```

`live-server --host 0.0.0.0 public`{{exec}}

{{TRAFFIC_HOST1_8080}}


create scripts/app.js

```js
console.log(`App.js is running`);
```

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>React 18 Bare HTML</title>

</head>
<body>

    <script src="https://unpkg.com/react@18/umd/react.development.js"></script>
    <script src="https://unpkg.com/react-dom@18/umd/react-dom.development.js"></script>
    <script src="/scrips/app.js"></script>

</body>
</html>
```

## JSX



---
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>React 18 Bare HTML</title>
    <script src="https://unpkg.com/react@18/umd/react.development.js"></script>
    <script src="https://unpkg.com/react-dom@18/umd/react-dom.development.js"></script>
    <script src="https://unpkg.com/@babel/standalone/babel.min.js"></script>
</head>
<body>

    <div id="root"></div>

    <script type="text/babel">
        const { createRoot } = ReactDOM;

        function App() {
            return <h1>Hello, React 18!</h1>;
        }

        const container = document.getElementById('root');
        const root = createRoot(container);
        root.render(<App />);
    </script>

</body>
</html>
```
