# Checkov

## Quick Install - w/ pip-tools

We'll be using python version 3.

`sudo apt update`{{exec}}

`python3 -V`{{exec}}

`pip3 install --upgrade pip`{{exec}}

`apt install python3.8-venv`{{exec}}

`mkdir cleanproject`{{exec}}

`cd cleanproject`{{exec}}

`python3 -m venv .venv`{{exec}}

`source .venv/bin/activate`{{exec}}

Pip tool will help resolve dependency issues across packages

`pip install pip-tools`{{exec}}


`pip install checkov`{{exec}}

`touch template.json`{{exec}}

```
{
    "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
    "contentVersion": "1.0.0.0",
    "resources": [
    {
        "type": "Microsoft.Storage/storageAccounts",
        "apiVersion": "2021-04-01",
        "name": "mystorageaccount",
        "location": "westus",
        "sku": {
        "name": "Standard_LRS"
        },
        "kind": "StorageV2",
        "properties": {
        "supportsHttpsTrafficOnly": true
        }
    }
    ]
}
```
`checkov -h`{{exec}}

`pip3 install -U checkov`{{exec}}

`checkov -f template.json`{{exec}}
