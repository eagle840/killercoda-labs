# My first function app


## Start a new function app

Function vs Function App, the app is what holds the functions.

### Create the 'Function App'

"Create a new Function App in the current folder. Initializes git repo."

`func init MyProjFolder --worker-runtime python --model V2`{{exec}}

WIP appears this creats code in the folder MyProjFolder



select 'python' and 'anonymous'

`tree`{{exec}}

`cd MyProjFolder`{{exec}}

`cat function_app.py`{{exec}}

The app only contains a bare template - creates only an instance of the FunctionApp class

### Create the 'Function'

"Create a new function from a template."

Lets add a 'function'

`func new --template "Http Trigger" --name http_trigger1 --authlevel "anonymous"`{{copy}}

`func new --template "Http Trigger" --name http_trigger1 `{{exec}}

If I add the authlevel in the command I get a python error, but adding it in the q&a I don't

Note that the name is used in the url `/api/<name>`

select 'python' and 'anonymous'

See how the code has been added to the app:

`cat function_app.py`{{exec}}

we'll start the app in verbose mode:

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

# Add a second function

Stop the func app

Make sure you're still in  the MyProjFolder

`func new --template "Timer Trigger" --name myTimerFunc`{{exec}}

- select python
- enter for the schedule:  `0 */1 * * * *` # every minute

And check the editor for the new updated code.

`cat function_app.py`{{exec}}


`func start --verbose`{{exec}}

Note the logs showing the app first every minute.


## Add Send to blob

add 'azure-storage-blob' to the requirments.txt file and run:

`pip install -r requirements.txt`{{exec}}

WIP ChatGPT, need to troubleshoot - the program runs but no updates to the blob storage

Create a container to store the responses

```bash
az storage container create  --name responses --connection-string "DefaultEndpointsProtocol=http;AccountName=devstoreaccount1;AccountKey=Eby8vdM02xNOcqFlqUwJPLlmEtlCDXJ1OUzFT50uSRZ6IFsuFq2UVErCz4I6tq/K1SZFPTOtr/KBHBeksoGMGw==;BlobEndpoint=http://127.0.0.1:10000/devstoreaccount1;QueueEndpoint=http://127.0.0.1:10001/devstoreaccount1;TableEndpoint=http://127.0.0.1:10002/devstoreaccount1;"
```{{exec}}

```python
import azure.functions as func
import datetime
import json
import logging
from azure.storage.blob import BlobServiceClient, BlobClient, ContainerClient

app = func.FunctionApp()

# Connection string for Azurite (local emulator)
AZURITE_CONNECTION_STRING = "DefaultEndpointsProtocol=http;AccountName=devstoreaccount1;" \
                            "AccountKey=Eby8vdM02xNOcqFlqUwJPLlmEtlCDXJ1OUzFT50uSRZ6IFsuFq2UVErCz4I6tq/K1SZFPTOtr/KBHBeksoGMGw==;" \
                            "BlobEndpoint=http://127.0.0.1:10000/devstoreaccount1;"

CONTAINER_NAME = "responses"

@app.route(route="http_trigger1", auth_level=func.AuthLevel.ANONYMOUS)
def http_trigger1(req: func.HttpRequest) -> func.HttpResponse:
    logging.info('Python HTTP trigger function processed a request.')

    name = req.params.get('name')
    if not name:
        try:
            req_body = req.get_json()
        except ValueError:
            req_body = {}
        name = req_body.get('name')

    if name:
        message = f"Hello, {name}. This HTTP triggered function executed successfully."
    else:
        message = "This HTTP triggered function executed successfully. Pass a name in the query string or in the request body for a personalized response."

    # Store the message in blob storage
    try:
        blob_service_client = BlobServiceClient.from_connection_string(AZURITE_CONNECTION_STRING)
        container_client = blob_service_client.get_container_client(CONTAINER_NAME)

        # Create container if it doesn't exist
        try:
            container_client.create_container()
        except Exception:
            pass  # Container already exists

        blob_name = f"response-{datetime.datetime.utcnow().isoformat()}.txt"
        blob_client = container_client.get_blob_client(blob_name)
        blob_client.upload_blob(message, overwrite=True)
    except Exception as e:
        logging.error(f"Failed to upload to blob storage: {e}")

    return func.HttpResponse(message, status_code=200)
```{{copy}}


`func start --verbose`{{exec}}


```
curl -X POST \
  http://localhost:7071/api/http_trigger1 \
  -H 'Content-Type: application/json' \
  -d '{"name": "nick"}'
```{{exec}}

```bash
az storage blob list \
  --container-name responses \
  --connection-string "DefaultEndpointsProtocol=http;AccountName=devstoreaccount1;AccountKey=Eby8vdM02xNOcqFlqUwJPLlmEtlCDXJ1OUzFT50uSRZ6IFsuFq2UVErCz4I6tq/K1SZFPTOtr/KBHBeksoGMGw==;BlobEndpoint=http://127.0.0.1:10000/devstoreaccount1;QueueEndpoint=http://127.0.0.1:10001/devstoreaccount1;TableEndpoint=http://127.0.0.1:10002/devstoreaccount1;" \
  --output table
```{{exec}}

```bash
az storage blob download \
  --container-name responses \
  --name <blob_name> \
  --connection-string "DefaultEndpointsProtocol=http;AccountName=devstoreaccount1;AccountKey=Eby8vdM02xNOcqFlqUwJPLlmEtlCDXJ1OUzFT50uSRZ6IFsuFq2UVErCz4I6tq/K1SZFPTOtr/KBHBeksoGMGw==;BlobEndpoint=http://127.0.0.1:10000/devstoreaccount1;" \
  --file - \
  --output none
  ```{{bash}}
