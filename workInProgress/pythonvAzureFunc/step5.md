
# Deploy to Azure

[MS docs quickstart](https://learn.microsoft.com/en-us/azure/azure-functions/create-first-function-cli-python?tabs=linux%2Cbash%2Cazure-cli%2Cbrowser)


## Create resources

`az login`{{exec}}

WIP need variable for the following commands

## Create New resources

If you don't have the resource created already:

WIP `region=""`

`az group create --name AzureFunctionsQuickstart-rg --location <REGION>`{{exec}}

`az storage account create --name <STORAGE_NAME> --location <REGION> --resource-group AzureFunctionsQuickstart-rg --sku Standard_LRS`{{exec}}

`az functionapp create --resource-group AzureFunctionsQuickstart-rg --consumption-plan-location westeurope --runtime python --runtime-version <PYTHON_VERSION> --functions-version 4 --name <APP_NAME> --os-type linux --storage-account <STORAGE_NAME>`{{exec}}

## Publish App

Before you publish, make sure you are in the app folder (that contains host.json)

`func azure functionapp -h`{{exec}}


`func azure functionapp publish <APP_NAME>`{{exec}}

`func azure functionapp list-functions <APP_NAME>`{{exec}}



## Clean up

`az group delete --name AzureFunctionsQuickstart-rg`{{exec}}
