
## setup a demo chart (nginx)

We'll create a default helm chart to use for terraform to deploy

`helm create nginx`{{execute}}

`tree nginx`{{exec}}


## Create the resource in k8s

`cd mytf`{{exec}}

`terraform init`{{exec}}

`terraform plan`{{exec}}

`terraform apply`{{exec}}

`kubectl get deploy`{{exec}}

`terraform show`{{exec}}

`helm list -A`{{exec}}

