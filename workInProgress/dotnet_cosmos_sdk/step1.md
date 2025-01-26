
# Initial Setup


WIP Install c# debugger in VSC


`sudo apt update`{{exec}}

`apt install -y curl git sqlite3 libpq-dev libreadline-dev sqlite jq`{{exec}}

## Install dotnet


```
wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb
```{{exec}}

```
sudo apt-get update && \
  sudo apt-get install -y dotnet-sdk-8.0
```{{exec}}

and verify the install:

`dotnet --version`{{exec}}


## Setup Cosmos 

In Azure setup a cosmos resourvce

WIP  Compare against serverless

```
{
  "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
  "contentVersion": "1.0.0.0",
  "resources": [
    {
      "type": "Microsoft.DocumentDB/databaseAccounts",
      "apiVersion": "2021-04-01-preview",
      "name": "[parameters('accountName')]",
      "location": "[parameters('location')]",
      "kind": "GlobalDocumentDB",
      "properties": {
        "databaseAccountOfferType": "Standard",
        "locations": [
          {
            "locationName": "[parameters('location')]"
          }
        ]
      }
    }
  ],
  "parameters": {
    "accountName": {
      "type": "string",
      "defaultValue": "mycosmosdbaccount"
    },
    "location": {
      "type": "string",
      "defaultValue": "West US"
    }
  }
}

```

**create a arm template** to 'custom deploy'

## Install cosmos data migration tool

https://learn.microsoft.com/en-us/azure/cosmos-db/how-to-migrate-desktop-tool?tabs=azure-cli

https://github.com/azurecosmosdb/data-migration-desktop-tool

Download the latest release at https://github.com/AzureCosmosDB/data-migration-desktop-tool/releases

as on Jan 2025

`wget https://github.com/AzureCosmosDB/data-migration-desktop-tool/releases/download/2.1.6/dmt-2.1.6-linux-x64.zip`{{exec}}

`unzip dmt-2.1.6-linux-x64.zip`{{exec}}

/root/linux-package

```
chmod +x /root/linux-package/dmt
echo 'export PATH=$PATH:/root/linux-package' >> ~/.bashrc
source ~/.bashrc
```{{exec}}


`dmt -h`{{exec}}

## Create new database


Put some data here and migrate to cosmos

