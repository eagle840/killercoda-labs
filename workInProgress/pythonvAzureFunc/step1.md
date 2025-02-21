


[MS doc](https://learn.microsoft.com/en-us/azure/azure-functions/functions-run-local?tabs=linux%2Cisolated-process%2Cnode-v4%2Cpython-v2%2Chttp-trigger%2Ccontainer-apps&pivots=programming-language-python)

[MS Docs python](https://learn.microsoft.com/en-us/azure/azure-functions/functions-reference-python?tabs=get-started%2Casgi%2Capplication-level&pivots=python-mode-decorators)


## Quick Install - w/ pip-tools



Lets first check which version of python the F() app is running:
- goto your Azure Function App
- Click on 'Configuration' under Settings.
- In the general tab, not the python version.


We'll be using python version 3.11




`add-apt-repository ppa:deadsnakes/ppa`{{exec}}

`apt update`{{exec}}

`apt install -y python3.11 jq tree`{{exec}}


`python3 -V`{{exec}}

`python3.11 -V`{{exec}}

WIP `pip3 install --upgrade pip`{{exec}}

WIP `apt install -y python3.8-venv`{{copy}}

`apt install -y python3.11-venv`{{exec}}

`mkdir cleanproject`{{exec}}

`cd cleanproject`{{exec}}

WIP `python3 -m venv .venv`{{copy}}

`python3.11 -m venv .venv`{{exec}}

`source .venv/bin/activate`{{exec}}

`python -V`{{exec}}

Pip tool will help resolve dependency issues across packages

`pip install pip-tools`{{exec}}

## Install azure-functions-core-tools

`curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg`{{exec}}

`sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg`{{exec}}

`sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/microsoft-ubuntu-$(lsb_release -cs 2>/dev/null)-prod $(lsb_release -cs 2>/dev/null) main" > /etc/apt/sources.list.d/dotnetdev.list'`{{exec}}

`sudo apt-get update`{{exec}}

`sudo apt-get install azure-functions-core-tools-4`{{exec}}

`func -h`{{exec}}

## Start a new function app

Function vs Function App, the app is what holds the functions.

`func init MyProjFolder --worker-runtime python --model V2`{{exec}}



WIP appears this creats code in the folder MyProjFolder

`ls MyProjFolder`{{exec}}

WIP copilot says run `new` inside the created foler `cd MyProjFolder`{{exec}}

 WIP `func new --template "Http Trigger" --name MyHttpTrigger`{{exec}}

WIP makes code in this folder

select 'python' and 'anonymous'

`tree`{{exec}}

WIP `func start`

copy the default Azure f() code

```python
import azure.functions as func
import logging

app = func.FunctionApp(http_auth_level=func.AuthLevel.ANONYMOUS)

@app.route(route="http_trigger1")
def http_trigger1(req: func.HttpRequest) -> func.HttpResponse:
    logging.info('Python HTTP trigger function processed a request.')

    name = req.params.get('name')
    if not name:
        try:
            req_body = req.get_json()
        except ValueError:
            pass
        else:
            name = req_body.get('name')

    if name:
        return func.HttpResponse(f"Hello, {name}. This HTTP triggered function executed successfully.")
    else:
        return func.HttpResponse(
             "This HTTP triggered function executed successfully. Pass a name in the query string or in the request body for a personalized response.",
             status_code=200
        )

```{{copy}}

`func start --verbose`{{exec}}

Note the returned url in yellow

WIP `Reading host configuration file '/root/cleanproject/host.json'`

WIP it looks like the run function auto reloads on code change.

**open a new tab**


### GET

`curl http://localhost:7071/api/http_trigger1?name=john`{{exec}}




### POST
```
curl -X POST \
  http://localhost:7071/api/http_trigger1 \
  -H 'Content-Type: application/json' \
  -d '{"name": "nick"}'
```{{exec}}

## Create a new function

Make sure you're still in  the MyProjFolder

`func new --template "Timer Trigger" --name myTimerFunc`{{exec}}

- select python
- enter for the schedule:  `0 */1 * * * *`

And check the editor for the new updated code.


`func start --verbose`{{exec}}

--- WHAT IS BELOW?

Let check the site  open site for 7071

now with /api/MyHttpTrigger


[Developer Guide](https://learn.microsoft.com/en-us/azure/azure-functions/functions-reference-python?tabs=get-started%2Casgi%2Capplication-level&pivots=python-mode-decorators)

WORKING, input json list

```python
import azure.functions as func
import datetime
import json
import ssl
import socket
import logging

app = func.FunctionApp()



def get_ssl_expiry_date(hostname):
    context = ssl.create_default_context()
    conn = context.wrap_socket(
        socket.socket(socket.AF_INET),
        server_hostname=hostname,
    )
    conn.settimeout(3.0)
    conn.connect((hostname, 443))
    ssl_info = conn.getpeercert()
    expiry_date = datetime.datetime.strptime(ssl_info['notAfter'], '%b %d %H:%M:%S %Y %Z')
    return expiry_date

@app.route(route="MyHttpTrigger", auth_level=func.AuthLevel.ANONYMOUS)
def MyHttpTrigger(req: func.HttpRequest) -> func.HttpResponse:
    logging.info('Python HTTP trigger function processed a request.')

    names = req.params.get('names')
    if names:
        try:
            names = json.loads(names)
        except json.JSONDecodeError:
            return func.HttpResponse(
                "Invalid JSON format for 'names' parameter.",
                status_code=400
            )
    else:
        try:
            req_body = req.get_json()
        except ValueError:
            req_body = {}
        names = req_body.get('names')

    if names:
        if not isinstance(names, list):
            return func.HttpResponse(
                "'names' should be a JSON list.",
                status_code=400
            )
        # expiry_date = get_ssl_expiry_date(hostname)

        result = {}
        for url in names:
            hostname = url.split("//")[-1].split("/")[0]
            logging.info(hostname)
            expiry_date = get_ssl_expiry_date(hostname)
            logging.info(expiry_date.strftime('%Y-%m-%d'))
            result[url] = expiry_date.strftime('%Y-%m-%d')



        # response_message = f"Hello, {', '.join(names)}. SSL certificate expiry date is {expiry_date}."
        # response_message = f"Hello, {', '.join(names)}. SSL certificate expiry date is {', '.join(result)}."
        response_message = f"Hello, {', '.join(names)}. SSL certificate expiry date is {result}."
        # response_message = f"Hello."
        # response_message = f"Domain:, {', '.join(names)}. SSL certificate expiry date is {result}."
        # response_message = f"[ {result} ]"
        # FOR JSON output response_message = json.dumps([result])
        return func.HttpResponse(response_message)
    else:
        return func.HttpResponse(
            "This HTTP triggered function executed successfully. Pass a 'names' JSON list in the query string or in the request body for a personalized response.",
            status_code=200
        )
```{{copy}}


`curl -X POST http://localhost:7071/api/MyHttpTrigger -H "Content-Type: application/json" -d '{"names": ["www.example.com", "www.bbc.com"]}'`{{exec}}

---
DELETE BELOW?



curl cmd:

WIP `curl -X POST "http://localhost:7071/api/MyHttpTrigger" -H "Content-Type: application/json" -d '{"names":["john","jim"]}'`{{exec}}

CORRECT FORMAT `
CORRECT FORMAT `curl -X GET "http://localhost:7071/api/MyHttpTrigger" -d 'names=["www.example.com"}]'`{{exec}}
- but needs a LIST

THIS WORKS!  `curl -X GET "http://localhost:7071/api/MyHttpTrigger" -d '{"names":["www.example.com"]}'`{{exec}}
