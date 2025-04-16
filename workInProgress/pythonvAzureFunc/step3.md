
# Add a python library

for the full Azure Functions API see: [ms docs](https://learn.microsoft.com/en-us/python/api/azure-functions/azure.functions?view=azure-python)

Lets setup an app to accept a JSON from a POST request:

enter the following code:

```
import azure.functions as func
import logging
import datetime
import json

app = func.FunctionApp()

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
```{{copy}}


Start the app

`func start --verbose`{{exec}}



run run:

```
curl -X POST \
  -H "Content-Type: application/json" \
  -d '{"key1": "value1", "key2": "value2"}' \
  http://localhost:7071/api/http_trigger1
```{{exec}}

You'll notice in the logs in in take of the json object.

Now lets add a jq package, so we can run JSON queries

We're going to create and use a jq package.

First add `jq` to the requirement.txt file

and update the local python environment (will automatically do it on Azure)

stop the application are run:

`pip install -r requirements.txt`{{exec}}

In the code we'll add

```
import jq
```
and add the function to the app code.
```
def apply_jq_query(json_obj, jq_query):
    try:
        compiled_query = jq.compile(jq_query)
        result = compiled_query.input(json_obj).first()
        return result
    except jq.JqError as e:
        return {"error": f"Invalid jq query: {e}"}

```{{copy}}

with some adjustment to end up with the final code:

**note the query string**

set the query and run an example


```python
import azure.functions as func
import logging
import datetime
import json
import jq

app = func.FunctionApp()

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
    response_message = f"Query result is, {result}"

    return func.HttpResponse(response_message, status_code=200)
```{{copy}}

Lets run the app, that should return the value of `key1`

`func start --verbose`{{exec}}

```bash
curl -X POST \
  -H "Content-Type: application/json" \
  -d '{"key1": "value1", "key2": "value2"}' \
  http://localhost:7071/api/http_trigger1
```{{exec}}



## The full app

Where the app uses the url parameter as the jq query

```python
import azure.functions as func
import logging
import json
import jq

app = func.FunctionApp()

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

    # Extract the jq query from the query parameter
    jq_query = req.params.get('jq_query')
    if not jq_query:
        return func.HttpResponse("Missing jq_query parameter", status_code=400)

    logging.info(f'Received jq query: {jq_query}')
    logging.info(f'Received JSON object: {req_body}')

    # Run the jq query against the JSON object
    result = apply_jq_query(req_body, jq_query)

    logging.info(f'Query result: {result}')
    response_message = f"Query result is, {result}"

    return func.HttpResponse(response_message, status_code=200)

```{{copy}}



Lets look at the data:

`cat data1.json`{{exec}}

and run the query

```bash
curl -X POST \
     -H "Content-Type: application/json" \
     --data "@data1.json" \
     "http://localhost:7071/api/http_trigger1?jq_query=.employees[]|select(.department==\"Engineering\"and.salary>75000)|{name,projects}"
```{{exec}}


--- 


[Developer Guide](https://learn.microsoft.com/en-us/azure/azure-functions/functions-reference-python?tabs=get-started%2Casgi%2Capplication-level&pivots=python-mode-decorators)
