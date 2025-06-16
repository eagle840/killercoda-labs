# Check a github repo



`git clone https://github.com/Azure-Samples/function-app-arm-templates.git`{{exec}}

`cd function-app-arm-templates`{{exec}}

`ls`{{exec}}

`cd function-app-linux-consumption/`{{exec}}


`checkov -f azuredeploy.json`{{exec}}

**VS**

`checkov -f azuredeploy.jsonn --framework arm`{{exec}}

### now the whole directory


`checkov -d . --framework arm`{{exec}}

`checkov -d . --framework arm --summary-position bottom`{{exec}}
