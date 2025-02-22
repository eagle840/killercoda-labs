
# Deploy to Azure

[MS docs quickstart](https://learn.microsoft.com/en-us/azure/azure-functions/create-first-function-cli-python?tabs=linux%2Cbash%2Cazure-cli%2Cbrowser)

## Install Az cli

`curl -L https://aka.ms/InstallAzureCli | bash`{{exec}}

`exec -l $SHELL`{{exec}}

## Create resources

`az --h`{{exec}}

`az login`{{exec}}

WIP need variable for the following commands

`az group create --name AzureFunctionsQuickstart-rg --location <REGION>`{{exec}}

`az storage account create --name <STORAGE_NAME> --location <REGION> --resource-group AzureFunctionsQuickstart-rg --sku Standard_LRS`{{exec}}

`az functionapp create --resource-group AzureFunctionsQuickstart-rg --consumption-plan-location westeurope --runtime python --runtime-version <PYTHON_VERSION> --functions-version 4 --name <APP_NAME> --os-type linux --storage-account <STORAGE_NAME>`{{exec}}

## Publish App

`func azure functionapp publish <APP_NAME>`{{exec}}



## Clean up

`az group delete --name AzureFunctionsQuickstart-rg`{{exec}}
