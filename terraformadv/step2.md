# console

https://prefetch.net/blog/2020/04/27/using-the-terraform-console-to-debug-interpolation-syntax/

# locals

where var's can't be changed with tf is running, locals can be

# conditionls

# functions#


# helm deploy

`mkdir mytf && cd mytf`{{execute}}

we'll be deploying: https://bitnami.com/stack/nginx/helm

see the following docs for deploying a helm chart with terraform: https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release

`nano main.tf`{{execute}}

```
provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

resource "helm_release" "nginx_app" {
  name = "nginx-app"

  repository = "https://charts.bitnami.com/bitnami"
  chart      = "nginx"

  #set {
  #  name  = "service.type"
  #  value = "ClusterIP"
  #}
}
```{{copy}}


