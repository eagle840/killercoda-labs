# install resume-cli


## sites:

https://www.npmjs.com/package/resume-cli

https://www.npmjs.com/package/resumed

https://www.npmjs.com/search?q=jsonresume-theme

## install


`npm install -g resume-cli`{{exec}}

The following was taken from https://www.npmjs.com/package/resume-cli



`resume --help`{{exec}}
Show a list of options and commands for the CLI.

`resume init`{{exec}}
Creates a new resume.json file in your current working directory.

Complete the resume.json with your text editor. Be sure to follow the schema (available at https://jsonresume.org/schema/).

`resume validate`{{exec}}
Validates your resume.json against our schema to ensure it complies with the standard. Tries to identify where any errors may be occurring.

`resume export [fileName]`

`resume export resume.json`{{exec}}

Exports your resume in a stylized HTML or PDF format.

'ls`{{exec}}

A list of available themes can be found here:
https://jsonresume.org/themes/

Please npm install the theme you wish to use before attempting to export it.

Options:

--format <file type> Example: --format pdf
--theme <name> Example: --theme even


`resume serve`{{exec}}
Starts a web server that serves your local resume.json. It will live reload when you make changes to your resume.json.

Options:

--port <port>
--theme <name>

When developing themes, change into your theme directory and run resume serve --theme ., which tells it to run the local folder as the specified theme.

This is not intended for production use, it's a convenience for theme development or to visualize changes to your resume while editing it.

### Supported Resume Input Types
json: via JSON.parse.
yaml: via yaml-js
quaff: if --resume is a directory, then the path is passed to quaff and the resulting json is used as the resume. quaff supports a variety of formats in the directory, including javascript modules.


### Resume Data
Setting --resume - tells the CLI to read resume data from standard input (STDIN), and defaults --type to application/json.
Setting --resume <path> reads resume data from path.
Leaving --resume unset defaults to reading from resume.json on the current working directory.


### Resume MIME Types
Supported resume data MIME types are:

application/json
text/yaml
