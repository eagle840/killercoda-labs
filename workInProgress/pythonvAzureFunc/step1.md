


[Gettinng started](https://learn.microsoft.com/en-us/azure/azure-functions/functions-reference-python?tabs=get-started%2Casgi%2Capplication-level&pivots=python-mode-decorators)

[MS doc](https://learn.microsoft.com/en-us/azure/azure-functions/functions-run-local?tabs=linux%2Cisolated-process%2Cnode-v4%2Cpython-v2%2Chttp-trigger%2Ccontainer-apps&pivots=programming-language-python)

[MS Docs python](https://learn.microsoft.com/en-us/azure/azure-functions/functions-reference-python?tabs=get-started%2Casgi%2Capplication-level&pivots=python-mode-decorators)

[Using the new V2 model](https://techcommunity.microsoft.com/blog/azurecompute/azure-functions-v2-python-programming-model/3665168)

https://pypi.org/project/azure-functions/

https://learn.microsoft.com/en-us/azure/azure-functions/

step 5 - Push to Azure


## Quick Install - w/ pip-tools



Lets first check which version of python the F() app is running:
- goto your Azure Function App
- Click on 'Configuration' under Settings.
- In the general tab, not the python version.

`apt update`{{exec}}

`apt install -y python3.12-venv jq tree`{{exec}}

### Azurite (blob and other) docker service

start docker

https://learn.microsoft.com/en-us/azure/storage/common/storage-use-azurite?tabs=docker-hub%2Cblob-storage#install-azurite

`docker run -p 10000:10000 -p 10001:10001 -p 10002:10002 mcr.microsoft.com/azure-storage/azurite`{{exec}}

Azurite does not create any containers or blobs by default. It only emulates the storage account `devstoreaccount1`

see docs if you only want blob

When using Azurite, the default account is:

Account Name: devstoreaccount1
Account Key: Eby8vdM02xNOcqFe...== (standard dev key)
Blob Endpoint: http://127.0.0.1:10000/devstoreaccount1
Connection String:  `UseDevelopmentStorage=true`


### install the cli tool

https://learn.microsoft.com/en-us/azure/storage/common/storage-use-azurite?tabs=npm%2Cblob-storage#command-line-options

`apt install -y npm`{{exec}}

`npm install -g azurite`{{exec}}

`azurite -h`{{exec}}

to connect with SDK's and tools:  https://learn.microsoft.com/en-us/azure/storage/common/storage-use-azurite?tabs=npm%2Cblob-storage#connect-to-azurite-with-sdks-and-tools

## Install az

you'll need az to work with azurite

`curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash`{{exec}}

`az -h`{{exec}}

and create a container

```bash
az storage container create \
  --name mycontainer \
  --connection-string "UseDevelopmentStorage=true"
```{{exec}}

To list all blobs

```bash
az storage blob list \
  --container-name mycontainer \
  --connection-string "UseDevelopmentStorage=true" \
  --output table

```{{exec}}


## Azure Functions

`mkdir cleanproject`{{exec}}

`cd cleanproject`{{exec}}

`python -m venv .venv`{{exec}}

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

## Add Send to blob

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
