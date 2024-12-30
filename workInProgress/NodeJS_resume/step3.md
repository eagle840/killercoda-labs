# resume pdf


`npm install jsonresume-theme-modern`{{exec}}

`resume export --format html --theme jsonresume-theme-modern  myresume.html`{{exec}}

WIP `resume serve`{{exec}}

uses https://www.npmjs.com/package/browser-sync

`resume serve --port 0.0.0.0:4000`{{exec}}

## AI:
To set the binding to `0.0.0.0:4000` using `browser-sync`, you can specify the `--host` and `--port` options when running the `browser-sync` command. Here's an example of how you can do it:

```bash
browser-sync start --server --host 0.0.0.0 --port 4000
```

WIP DOESN'T work --host 0.0.0.0

This command will start a `browser-sync` server with the host set to `0.0.0.0` and the port set to `4000`. This will make your server accessible on all network interfaces on port `4000`.

## end AI

Options:

--port <port>
--theme <name>
When developing themes, change into your theme directory and run resume serve --theme ., which tells it to run the local folder as the specified theme.

`resume export --format pdf myresume.pdf`{{exec}}

`resume export --format pdf --theme jsonresume-theme-modern  myresume.pdf`{{exec}}

WIP: having install with theme. First try theme with html, then pdf

check -https://www.npmjs.com/package/resume-cli
and -https://jsonresume.org/getting-started
also your devops pipeline
