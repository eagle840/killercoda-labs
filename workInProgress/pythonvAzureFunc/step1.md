


[MS doc](https://learn.microsoft.com/en-us/azure/azure-functions/functions-run-local?tabs=linux%2Cisolated-process%2Cnode-v4%2Cpython-v2%2Chttp-trigger%2Ccontainer-apps&pivots=programming-language-python)



## Quick Install - w/ pip-tools



Lets first check which version of python the F() app is running:
- goto your Azure Function App
- Click on 'Configuration' under Settings.
- In the general tab, not the python version.


We'll be using python version 3.11



```bash
sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt update
sudo apt install python3.11
```{{exec}}

`python3 -V`{{exec}}

`python3.11 -V`{{exec}}

WIP `pip3 install --upgrade pip`{{exec}}

`apt install python3.8-venv`{{copy}}

`apt install python3.11-venv`{{exec}}

`mkdir cleanproject`{{exec}}

`cd cleanproject`{{exec}}

`python3 -m venv .venv`{{copy}}

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

`func init MyProjFolder --worker-runtime python --model V2`{{exec}}

WIP appears this creats code in the folder MyProjFolder

`ls`{{exec}}

WIP copilot says run `new` inside the created foler `cd MyProjFolder`{{exec}}

`func new --template "Http Trigger" --name MyHttpTrigger`{{exec}}

WIP makes code in this folder

select 'python' and 'anonymous'

`func start`

`func start --verbose`{{exec}}

WIP `Reading host configuration file '/root/cleanproject/host.json'`

WIP it looks like the run function auto reloads on code change.


WIP check port #
`curl http://localhost:7071/api/MyHttpTrigger`{{exec}}


`curl http://localhost:7071/api/MyHttpTrigger?name=john`{{exec}}

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


curl -X POST http://localhost:7071/api/MyHttpTrigger -H "Content-Type: application/json" -d '{"names": ["www.example.com", "www.bbc.com"]}'


curl cmd:

WIP `curl -X POST "http://localhost:7071/api/MyHttpTrigger" -H "Content-Type: application/json" -d '{"names":["john","jim"]}'`{{exec}}

CORRECT FORMAT `
CORRECT FORMAT `curl -X GET "http://localhost:7071/api/MyHttpTrigger" -d 'names=["www.example.com"}]'`{{exec}}
- but needs a LIST

THIS WORKS!  `curl -X GET "http://localhost:7071/api/MyHttpTrigger" -d '{"names":["www.example.com"]}'`{{exec}}
