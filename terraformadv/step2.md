# steps

- create providers.tf
- create main.tf
- create var.tf
- create output.tf
- create modules (where in this list)

## setup provider

in this example we are going to use a 'null provider'  Goto https://registry.terraform.io/providers/hashicorp/null/3.2.1 and click on the 'use provider' button and you'll get the code:

```yaml
terraform {
  required_providers {
    null = {
      source = "hashicorp/null"
      version = "3.2.1"
    }
  }
}

provider "null" {
  # Configuration options
}
```

Now lets look at the documentation, to select a resource on the left hand side, there is only one 'null_resource'. 

we'll recreate the following resource:

```
resource "null_resource" "cluster" {
  # Changes to any instance of the cluster requires re-provisioning
  # triggers = {
  #   cluster_instance_ids = join(",", aws_instance.cluster.*.id)
  }
```


# cmd

- tf fmt
- tf validate



# console

https://prefetch.net/blog/2020/04/27/using-the-terraform-console-to-debug-interpolation-syntax/  <= way out of date

`terraform console`{{exec}}

`type(["a","b"])`

`type(tolist(["a","b"]))`

use the name (dot notation) of any resource/data and it'll return the json data

for more functions see https://developer.hashicorp.com/terraform/language/functions

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


