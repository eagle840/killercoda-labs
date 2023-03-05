## setup a demo chart (nginx)

We'll create a default helm chart to use for terraform to deploy

`helm create nginx`{{execute}}

`tree nginx`{{exec}}

# set tf file



see the following docs for deploying a helm chart with terraform: https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release

`nano provider.tf`{{execute}}

WIP consider using Redis (needs storage)

```

# WIP add to provider
provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

```

`nano main.tf`{{exec}}

```
# WIP add to main
resource "helm_release" "nginx_app" {
  name = "nginx-app"

  #repository = "https://charts.bitnami.com/bitnami"
  repository = "../"
  chart      = "nginx"

  set {
    name  = "service.type"
    value = "ClusterIP"
  }
  set {
    name = "service.port"
    value = 80
  }
  set {
    name = "ingress.enabled"
    value = false
  }
}
```{{copy}}






# create



`terraform init`{{exec}}

`terraform plan`{{exec}}

`terraform apply`{{exec}}

! I beleive this timesout, because the svc is set as a LB, need to change to a nodeport?

`terraform show`{{exec}}

`helm list -A`{{exec}}