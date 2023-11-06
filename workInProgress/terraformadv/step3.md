
## setup a demo chart (nginx)

We'll create a default helm chart to use for terraform to deploy

`helm create nginx`{{execute}}

`tree nginx`{{exec}}


## add install with tf


`terraform init`{{exec}}

`terraform plan`{{exec}}

`terraform apply`{{exec}}

! I beleive this timesout, because the svc is set as a LB, need to change to a nodeport?

`terraform show`{{exec}}

`helm list -A`{{exec}}

