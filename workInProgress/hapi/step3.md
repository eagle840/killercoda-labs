# Step 3

https://hapi.dev/tutorials/cookies/?lang=en_US



To explore cookies and XSS headers, you can use a combination of command line tools like `curl` and `grep`. Here's an example command you can use:

```bash
curl -I -s -L -X GET http://example.com | grep -i -E 'set-cookie|x-xss-protection'
```

In this command:
- `curl` is used to make a GET request to the specified URL.
- `-I` is used to only show the response headers.
- `-s` is used to silent mode (to suppress the progress meter).
- `-L` is used to follow redirects.
- `-X GET` specifies the HTTP method as GET.
- `http://example.com` is the URL you want to explore.
- `grep -i -E 'set-cookie|x-xss-protection'` is used to filter the output to show only lines containing 'Set-Cookie' or 'X-XSS-Protection' headers, ignoring case sensitivity.

This command will show you the response headers containing the Set-Cookie and X-XSS-Protection headers from the specified URL. You can modify the URL and headers as needed for your exploration.


for localhost

`curl -I -s -L -X GET http://localhost:3000 `{{exec}}

`curl -I -s -L -X GET http://localhost:3000 | grep -i -E 'set-cookie|x-xss-protection'`{{exec}}

## Add cookies

after the server.route(), add the following:

```
server.state('data', {
        ttl: null,
        isSecure: true,
        isHttpOnly: true,
        encoding: 'base64json',
        clearInvalid: true,
        strictHeader: true
    });
```

Now in the server.route change the handler to:

```
handler: function (request, h) {

            h.state('data', { firstVisit: false });
            return h.response('Hello');
        }
```


`curl -I -s -L -X GET http://localhost:3000 `{{exec}}

`curl -I -s -L -X GET http://localhost:3000 | grep -i -E 'set-cookie|x-xss-protection'`{{exec}}
