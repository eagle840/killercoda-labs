
# Add a python library

Lets setup an app to accept a JSON from a POST request:

enter the following code:

```python
import azure.functions as func
import logging
import json

@app.route(route="http_trigger1", methods=['POST'])
def http_trigger1(req: func.HttpRequest) -> func.HttpResponse:
    logging.info('Python HTTP trigger function processed a request.')

    try:
        req_body = req.get_json()
    except ValueError:
        return func.HttpResponse("Invalid JSON in request body", status_code=400)

    if not req_body:
        return func.HttpResponse("Request body is empty", status_code=400)

    # Process the JSON object
    logging.info(f'Received JSON object: {req_body}')

    return func.HttpResponse("JSON object received successfully", status_code=200)
```

run run:

```bash
curl -X POST \
  -H "Content-Type: application/json" \
  -d '{"key1": "value1", "key2": "value2"}' \
  http://localhost:7071/api/http_trigger1
```

Now lets add a jq package, so we can run JSON queries

We're going to create and use a jq package.

First add `jq` to the requirement.txt file

and update the local python environment (will automatically do it on Azure)

stop the application are run:

`pip install -r requirements.txt`{{exec}}



and the following code at line 8

```
import jq

def apply_jq_query(json_obj, jq_query):
    try:
        compiled_query = jq.compile(jq_query)
        result = compiled_query.input(json_obj).first()
        return result
    except jq.JqError as e:
        return {"error": f"Invalid jq query: {e}"}

```{{copy}}

to end up with the final code:

**note the query string**

set the query and run an example


```python
import azure.functions as func
import logging
import json
import jq

def apply_jq_query(json_obj, jq_query):
    try:
        compiled_query = jq.compile(jq_query)
        result = compiled_query.input(json_obj).first()
        return result
    except jq.JqError as e:
        return {"error": f"Invalid jq query: {e}"}

@app.route(route="http_trigger1", methods=['POST'])
def http_trigger1(req: func.HttpRequest) -> func.HttpResponse:
    logging.info('Python HTTP trigger function processed a request.')

    try:
        req_body = req.get_json()
    except ValueError:
        return func.HttpResponse("Invalid JSON in request body", status_code=400)

    if not req_body:
        return func.HttpResponse("Request body is empty", status_code=400)

    # Process the JSON object
    logging.info(f'Received JSON object: {req_body}')

    # Run a jq query against the JSON object
    jq_query = ".key1"
    result = apply_jq_query(req_body, jq_query)

    logging.info(f'Query result: {result}')

    return func.HttpResponse("JSON object received and query executed successfully", status_code=200)
```
`func start --verbose`{{exec}}

```bash
curl -X POST \
  -H "Content-Type: application/json" \
  -d '{"key1": "value1", "key2": "value2"}' \
  http://localhost:7071/api/http_trigger1
```

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
