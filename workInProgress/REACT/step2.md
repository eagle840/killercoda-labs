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
