`mkdir myproject`{{exec}}

`cd myproject`{{exec}}

`npm init`{{exec}}

Just hit return from each item until complete

`npm i @hapi/hapi@20.3.0`{{exec}}

`npm install @hapi/hapi`{{copy}}

`nano index.js`{{exec}}

```
'use strict';

const Hapi = require('@hapi/hapi');

const init = async () => {

    const server = Hapi.server({
        port: 3000,
        host: '0.0.0.0'
    });

    server.route({
        method: 'GET',
        path: '/',
        handler: (request, h) => {

            return 'Hello World!';
        }
    });

    await server.start();
    console.log('Server running on %s', server.info.uri);
};

process.on('unhandledRejection', (err) => {

    console.log(err);
    process.exit(1);
});

init();
```{{copy}}

`node index.js`{{exec}}

{{TRAFFIC_HOST1_3000}}

`npm install -g nodemon`{{exec}}


`nodemon -v`{{exec}}


nodemon watches the current directry, lets adjust that to watch all files above:

`nano nodemon.json`{{exec}}


```
{
    "watch": ["**/*.*"]
}
```{{exec}}

`nodemon index.js`{{exec}}

# Hapi Inert


https://hapi.dev/module/inert/api/?v=7.1.0


`npm install @hapi/inert`{{exec}}


create a public folder in the project folder

`mkdir public`{{exec}}

create page.html

```
hello world
```

IGNORE set path to 'public/file.js'

use - will always return, no matter the url

```
const Path = require('path');
const Hapi = require('@hapi/hapi');
const Inert = require('@hapi/inert');

const server = new Hapi.Server({
    port: 3000,
    routes: {
        files: {
            relativeTo: Path.join(__dirname, 'public')
        }
    }
});

const provision = async () => {

    await server.register(Inert);

    server.route({
    method: 'GET',
    path: '/{path*}',
    handler: {
        file: 'page.html'
    }
});

    await server.start();

    console.log('Server running at:', server.info.uri);
};

provision();
```
