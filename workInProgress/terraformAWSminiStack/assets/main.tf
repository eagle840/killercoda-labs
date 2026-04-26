resource "kubernetes_namespace" "namespace" {
  metadata {
    name = "my-first-namespace"
  }
}

# WIP add to main
resource "helm_release" "nginx_app" {
  name = "nginx-app"

  #repository = "https://charts.bitnami.com/bitnami"
  repository = "./"
  chart      = "nginx"
  namespace  = kubernetes_namespace.namespace.name

  set {
    name  = "service.type"
    value = "ClusterIP"
  }
  set {
    name  = "service.port"
    value = 80
  }
  set {
    name  = "ingress.enabled"
    value = false
  }
}