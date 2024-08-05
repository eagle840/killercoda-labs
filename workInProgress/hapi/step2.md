`mkdir myproject`{{exec}}

`cd myproject`{{exec}}

`npm init`{{exec}}

`npm install @hapi/hapi`{{exec}}

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
