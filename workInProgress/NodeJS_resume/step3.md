# resume html

We'll need a theme to generate a html or pdf doc (see https://www.npmjs.com/search?q=jsonresume-theme)

`npm install jsonresume-theme-modern`{{exec}}

`resume export --format html --theme jsonresume-theme-modern  myresume.html`{{exec}}

WIP `resume serve`{{exec}}

uses https://www.npmjs.com/package/browser-sync

`resume serve --port 0.0.0.0:4000`{{exec}}



Options:

--port <port>
--theme <name>

When developing themes, change into your theme directory and run resume serve --theme ., which tells it to run the local folder as the specified theme.



`resume export --format pdf --theme jsonresume-theme-modern  myresume.pdf`{{exec}}



check -https://www.npmjs.com/package/resume-cli
and -https://jsonresume.org/getting-started
also your devops pipeline
