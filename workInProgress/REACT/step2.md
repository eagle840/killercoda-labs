# Hello React

We'll be using the 'old world' (ie, not things like Vite)

`mkdir myReact`{{exec}}

`cd myReact`{{exec}}

`mkdir public`{{exec}}


`cd public`{{exec}}

`mkdir scripts`{{exec}}

`touch index.html`{{exec}}

`touch ./scripts/app.js`{{exec}}

`cd ../..`{{exec}}

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

`live-server --host=0.0.0.0 public`{{exec}}

{{TRAFFIC_HOST1_8080}}


create scripts/app.js

`console.log(`App.js is running`);`{{exec}}

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
    <script src="/scripts/app.js"></script>

</body>
</html>
```

## JSX

### Babel

[bablel repl](https://babeljs.io/repl)


- be sure to enable es2015 and react



`npm install -g  babel-cli`{{exec}}

`# npm install -g  babel-cli@6.24.1`

`babel --help`{{exec}}

`npm add babel-preset-react`{{exec}}

`# npm add babel-preset-react@6.24.1`

`npm add babel-preset-env`{{exec}}

`# npm add babel-preset-env@1.5.2`

`cat package.json`{{exec}}

`mkdir src`{{exec}}

`touch ./src/app.js`{{exec}}
# this file gets translatted to scripts/app.js

```jsx
console.log('App.js is running!');

// JSX - JavaScript XML

var template = <p>This is JSX from app.js!</p>;
var appRoot = document.getElementById('app');

ReactDOM.render(template, appRoot);
```

babel src/app.js --out-file=public/scripts/app.js --presets=env,react`{{exec}}

`cat public/scripts/app.js `{{exec}}

`babel src/app.js --out-file=public/scripts/app.js --presets=env,react --watch #auto change on detect`{{exec}}

`live-server --host=0.0.0.0 public`{{exec}}

Now update some of the JSX and see it update (eg change <p> to <h>)

## Wrap the HTML

Note that the code is wrapped in a <div>, without this react will generate an error


```jsx
console.log('App.js is running!');

// JSX - JavaScript XML

var template = <div><h1>Hello World</h><p>This is JSX from app.js!</p></div>;
var appRoot = document.getElementById('app');

ReactDOM.render(template, appRoot);
```

but lets clean it up (sometimes you'll see the html in a set of () )


```jsx
console.log('App.js is running!');

// JSX - JavaScript XML

var template =
<div>
    <h1>Hello World</h>
    <p>This is JSX from app.js!</p>
</div>;
var appRoot = document.getElementById('app');

ReactDOM.render(template, appRoot);
```

Now take a look at how babel has translated this is /public/scripts/app.js

--- dont use below

```jsx
console.log('App.js is running!');

// JSX - JavaScript XML
// var template = <p>This is JSX from app.js !< /p>;
var template = React.createElement(
"h1",
{ id: "someid" },
"Something new"
);

var appRoot = document.getElementById('app');

ReactDOM.render(template, appRoot);
```


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
