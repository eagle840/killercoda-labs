


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


### install the cli tool (optional)

If you want to install azurite directly on the local machine

https://learn.microsoft.com/en-us/azure/storage/common/storage-use-azurite?tabs=npm%2Cblob-storage#command-line-options

`apt install -y npm`{{exec}}

`npm install -g azurite`{{exec}}

`azurite -h`{{exec}}


## Install az

to connect with SDK's and tools:  https://learn.microsoft.com/en-us/azure/storage/common/storage-use-azurite?tabs=npm%2Cblob-storage#connect-to-azurite-with-sdks-and-tools


you'll need az to work with azurite

`curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash`{{exec}}

`az -h`{{exec}}

and create a container  Be sure to use the HTTP version of the endpoing


```bash
az storage container create  --name mycontainer --connection-string "DefaultEndpointsProtocol=http;AccountName=devstoreaccount1;AccountKey=Eby8vdM02xNOcqFlqUwJPLlmEtlCDXJ1OUzFT50uSRZ6IFsuFq2UVErCz4I6tq/K1SZFPTOtr/KBHBeksoGMGw==;BlobEndpoint=http://127.0.0.1:10000/devstoreaccount1;QueueEndpoint=http://127.0.0.1:10001/devstoreaccount1;TableEndpoint=http://127.0.0.1:10002/devstoreaccount1;"
```{{exec}}

`touch myfile.txt`{{exec}}

```bash
az storage blob upload \
  --account-name devstoreaccount1 \
  --container-name mycontainer \
  --name myfile.txt \
  --file ./myfile.txt \
  --connection-string "DefaultEndpointsProtocol=http;AccountName=devstoreaccount1;AccountKey=Eby8vdM02xNOcqFlqUwJPLlmEtlCDXJ1OUzFT50uSRZ6IFsuFq2UVErCz4I6tq/K1SZFPTOtr/KBHBeksoGMGw==;BlobEndpoint=http://127.0.0.1:10000/devstoreaccount1;QueueEndpoint=http://127.0.0.1:10001/devstoreaccount1;TableEndpoint=http://127.0.0.1:10002/devstoreaccount1;"
```{{exec}}

To list all blobs



```bash
az storage blob list \
  --container-name mycontainer \
  --connection-string "DefaultEndpointsProtocol=http;AccountName=devstoreaccount1;AccountKey=Eby8vdM02xNOcqFlqUwJPLlmEtlCDXJ1OUzFT50uSRZ6IFsuFq2UVErCz4I6tq/K1SZFPTOtr/KBHBeksoGMGw==;BlobEndpoint=http://127.0.0.1:10000/devstoreaccount1;QueueEndpoint=http://127.0.0.1:10001/devstoreaccount1;TableEndpoint=http://127.0.0.1:10002/devstoreaccount1;" \
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
