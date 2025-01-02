# resume html

We'll need a theme to generate a html or pdf doc (see https://www.npmjs.com/search?q=jsonresume-theme)

`npm install jsonresume-theme-modern`{{exec}}

`resume export --format html --theme jsonresume-theme-modern  myresume.html`{{exec}}

WIP `resume serve`{{exec}}

uses https://www.npmjs.com/package/browser-sync

`resume serve --port 0.0.0.0:4000`{{copy}}

Options:

--port <port>
--theme <name>

This command only allows http requests from 127.0.0.1, we need 0.0.0.0 for killacoda, so:

`npm install -g http-server`{{exec}}

`http-server -h`{{exec}}

`http-server -c-1 -a 0.0.0.0`{{exec}}

{{TRAFFIC_HOST1_8080}}

lets try a more pleasing theme:

`npm install jsonresume-theme-flat

`resume export --format html --theme jsonresume-theme-flat  myresumeflat.html

`http-server -c-1 -a 0.0.0.0

{{TRAFFIC_HOST1_8080}}



When developing themes, change into your theme directory and run resume serve --theme ., which tells it to run the local folder as the specified theme.


check -https://www.npmjs.com/package/resume-cli
and -https://jsonresume.org/getting-started
also your devops pipeline
