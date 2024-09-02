# security header


https://en.wikipedia.org/wiki/List_of_HTTP_header_fields#

HTTP Security Headers are additional layers of security that can be implemented on web servers to enhance the security of web applications. Here are some common HTTP security headers that you can implement:

1. **Strict-Transport-Security (HSTS)**: This header tells the browser to only connect to the website over HTTPS, preventing downgrade attacks.

2. **Content-Security-Policy (CSP)**: This header helps prevent Cross-Site Scripting (XSS) attacks by defining where resources can be loaded from.

3. **X-Frame-Options**: This header prevents your website from being embedded in an iframe on another domain, protecting against Clickjacking attacks.

4. **X-XSS-Protection**: This header enables the browser's built-in XSS protection mechanism.

5. **X-Content-Type-Options**: This header prevents browsers from MIME-sniffing a response away from the declared content type.

6. **Referrer-Policy**: This header controls how much referrer information is included in the request header when navigating from one page to another.

7. **Feature-Policy**: This header allows you to control which web platform features are allowed to be used on your website.

To check if these headers are present on a website, you can use the `curl` command with the `-I` option to fetch the headers. For example:


# follow

https://hapi.dev/api/?v=21.3.3#-routeoptionssecurity

https://www.keycdn.com/blog/http-security-headers

## HSTS header


In Hapi, you can set the Strict-Transport-Security (HSTS) header using the `hsts` plugin. Here's an example of how you can set the HSTS header in a Hapi server:

The following appears to work:

```javascript
const server = new Server({
    host: '127.0.0.1',
    port: 3333,
    state: {
        strictHeader: true
    },
    routes: {
        security: {
            hsts: {
                includeSubDomains: true,
                preload: true,
                maxAge: 15768000
            }
        }
    }
})
```

```javascript
const Hapi = require('@hapi/hapi');

const init = async () => {
    const server = Hapi.server({
        port: 3000,
        host: 'localhost'
    });

    await server.register({
        plugin: require('hapi-hsts'),
        options: {
            maxAge: 31536000,  // 1 year in seconds
            includeSubDomains: true,
            preload: true
        }
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
```

In this example:
- We first import the necessary modules and set up a Hapi server.
- We register the `hapi-hsts` plugin with the desired options:
  - `maxAge`: Specifies the duration in seconds that the HSTS policy should be enforced (1 year in this case).
  - `includeSubDomains`: Indicates that the HSTS policy should be applied to all subdomains.
  - `preload`: Indicates that the site is eligible for HSTS preload lists.
- We define a simple route that responds with 'Hello World!'.
- Finally, we start the server and log the server's URI.

With this setup, the HSTS header will be automatically added to the server responses, enforcing HTTPS connections for the specified duration and including subdomains.

### RESULTS

```
strict-transport-security: max-age=15768000; includeSubDomains; preload
x-frame-options: DENY
x-xss-protection: 0
x-download-options: noopen
x-content-type-options: nosniff
```


## CSP

check out: https://www.writesoftwarewell.com/content-security-policy/

https://caniuse.com/?search=content%20security%20policy

In Hapi, you can set the Content-Security-Policy (CSP) header using the `hapi-securify` plugin. Here's an example of how you can set the CSP header in a Hapi server:

WIP, BAD First, install the `hapi-securify` plugin using npm:


WIP: bad `npm install hapi-securify`


Then, in your Hapi server configuration, you can set the CSP header like this:

WIP add a second route with customer headers:

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
        handler: function (request, h) {

            h.state('data', { firstVisit: false });
            return h.response('Hello');
        }
    });

    server.route({
        method: 'GET',
        path: '/test',
        handler: function (request, h) {
            const response = h.response('success');
            response.header('X-Custom', 'some-value');
            return response;
        }
    });

    server.state('data', {
        ttl: null,
        isSecure: true,
        isHttpOnly: true,
        encoding: 'base64json',
        clearInvalid: true,
        strictHeader: true
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



THIS IS OLD, don't USE:
```javascript
const Hapi = require('@hapi/hapi');
const securify = require('hapi-securify');

const init = async () => {
    const server = Hapi.server({
        port: 3000,
        host: 'localhost'
    });

    await server.register({
        plugin: securify,
        options: {
            csp: {
                directives: {
                    defaultSrc: ["'self'"],
                    scriptSrc: ["'self'", 'code.jquery.com'],
                    styleSrc: ["'self'", 'maxcdn.bootstrapcdn.com'],
                    imgSrc: ["'self'", 'data:'],
                    connectSrc: ["'self'"],
                    fontSrc: ["'self'"],
                    objectSrc: ["'none'"],
                    mediaSrc: ["'self'"],
                    frameSrc: ["'none'"],
                    sandbox: ['allow-forms', 'allow-scripts'],
                    reportUri: '/report-violation'
                }
            }
        }
    });

    server.route({
        method: 'GET',
        path: '/',
        handler: (request, h) => {
            return 'Hello World';
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
```


WIP, this is bad:
In this example:
- We are setting up a Hapi server on `localhost:3000`.
- We are registering the `hapi-securify` plugin with the CSP directives specified in the `options` object.
- The CSP directives specify the allowed sources for different types of content (defaultSrc, scriptSrc, styleSrc, etc.).
- The `reportUri` directive specifies where to send violation reports if the CSP is violated.

This example demonstrates how you can set the Content-Security-Policy header using the `hapi-securify` plugin in a Hapi server.


## x-frame

In Hapi, you can set the X-Frame-Options header to prevent your website from being embedded in an iframe on another domain by using the `hapi-response-utilities` plugin. Here's an example of how you can set the X-Frame-Options header in a Hapi server:

First, install the `hapi-response-utilities` plugin:

```bash
npm install hapi-response-utilities
```

Then, in your Hapi server configuration, you can set the X-Frame-Options header like this:

```javascript
const Hapi = require('@hapi/hapi');
const responseUtilities = require('hapi-response-utilities');

const init = async () => {
    const server = Hapi.server({
        port: 3000,
        host: 'localhost'
    });

    await server.register({
        plugin: responseUtilities,
        options: {
            headers: {
                'X-Frame-Options': 'DENY'
            }
        }
    });

    server.route({
        method: 'GET',
        path: '/',
        handler: (request, h) => {
            return 'Hello World';
        }
    });

    await server.start();
    console.log('Server running on %s', server.info.uri);
};

init();
```

In this example, we are setting the X-Frame-Options header to 'DENY', which means that the page cannot be displayed in a frame, regardless of the site attempting to do so.

After setting up the server with the X-Frame-Options header, any response from the server will include this security header to prevent Clickjacking attacks.


## X-XSS-Protection


In Hapi, you can set the X-XSS-Protection header using the `hapi-response-utilities` plugin. Here's an example of how you can set the X-XSS-Protection header in a Hapi server:

First, install the `hapi-response-utilities` plugin using npm:

```bash
npm install hapi-response-utilities
```

Then, in your Hapi server configuration, you can set the X-XSS-Protection header like this:

```javascript
const Hapi = require('@hapi/hapi');
const responseUtilities = require('hapi-response-utilities');

const init = async () => {
    const server = Hapi.server({
        port: 3000,
        host: 'localhost'
    });

    await server.register({
        plugin: responseUtilities,
        options: {
            xXssProtection: '1; mode=block'
        }
    });

    server.route({
        method: 'GET',
        path: '/',
        handler: (request, h) => {
            return 'Hello World';
        }
    });

    await server.start();
    console.log('Server running on %s', server.info.uri);
};

init();
```

In this example, we are setting the X-XSS-Protection header to `'1; mode=block'`, which enables the browser's built-in XSS protection mechanism with blocking mode.

When you run this Hapi server and make a request to it, the X-XSS-Protection header will be included in the response with the specified value.

Please note that the `hapi-response-utilities` plugin is just one way to set HTTP headers in Hapi. You can also set headers directly in the route handlers using `h.response().header()`.


## 5. X-Content-Type-Options


In Hapi, you can set the `X-Content-Type-Options` header using the `hapi` framework's response toolkit. Here's an example of how you can set the `X-Content-Type-Options` header in a Hapi route handler:

```javascript
const Hapi = require('@hapi/hapi');

const init = async () => {
    const server = Hapi.server({
        port: 3000,
        host: 'localhost'
    });

    server.route({
        method: 'GET',
        path: '/',
        handler: (request, h) => {
            return h.response('Hello World').header('X-Content-Type-Options', 'nosniff');
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
```

In this example:
- We create a Hapi server listening on port 3000.
- We define a route that responds with 'Hello World' and sets the `X-Content-Type-Options` header to 'nosniff'.
- The `h.response().header()` method is used to set the custom header in the response.

When you run this Hapi server and make a request to the specified route, the response will include the `X-Content-Type-Options: nosniff` header, which helps prevent MIME-sniffing attacks in modern browsers.

## 6. Referrer-Policy


In Hapi, a popular Node.js framework for building web applications, you can set the Referrer-Policy header using the `hapi` framework's response toolkit. Here's an example of how you can set the Referrer-Policy header in a Hapi route handler:

```javascript
const Hapi = require('@hapi/hapi');

const init = async () => {
    const server = Hapi.server({
        port: 3000,
        host: 'localhost'
    });

    server.route({
        method: 'GET',
        path: '/',
        handler: (request, h) => {
            return h.response('Hello World').header('Referrer-Policy', 'no-referrer');
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
```

In this example, we define a simple Hapi server with a single route that responds with 'Hello World' and sets the Referrer-Policy header to 'no-referrer'. This header value tells the browser not to send the referrer information when navigating from one page to another.

You can customize the Referrer-Policy header value based on your specific security requirements.
