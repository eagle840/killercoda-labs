# steps

- create providers.tf
- create main.tf
- create var.tf
- create output.tf
- create modules (where in this list)


# cmd

- tf fmt
- tf validate



# console

https://prefetch.net/blog/2020/04/27/using-the-terraform-console-to-debug-interpolation-syntax/

# locals

where var's can't be changed with tf is running, locals can be

# conditionls

condition ? true_val : false_val

# functions#

# for loop

  tags = {
    for key, value in var.ec2_tags :
    key => lower(value)
  }
}


# helm deploy

`mkdir mytf && cd mytf`{{execute}}

we'll be deploying: https://bitnami.com/stack/nginx/helm

see the following docs for deploying a helm chart with terraform: https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release

`nano main.tf`{{execute}}

WIP consider using Redis (needs storage)

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


