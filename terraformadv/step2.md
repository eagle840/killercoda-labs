# console

https://prefetch.net/blog/2020/04/27/using-the-terraform-console-to-debug-interpolation-syntax/


# helm deploy

`mkdir mytf && cd mytf`{{execute}}

`nano main.tf`{{execute}}

```
provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}
 
resource "helm_release" "nginx_ingress" {
  name       = "nginx-ingress-controller"

  # repository = "https://charts.bitnami.com/bitnami"
  chart      = "../nginx"

  #set {
  #  name  = "service.type"
  #  value = "ClusterIP"
  #}
}
```{{copy}}