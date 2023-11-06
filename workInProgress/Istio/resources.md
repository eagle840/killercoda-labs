###  using the hub to install metrics-server

`helm search hub metrics-server`{{execute}}

we'll be using the 'metrics-server' version, details (including install) can be found here: https://artifacthub.io/packages/helm/metrics-server/metrics-server

`helm repo add metrics-server https://kubernetes-sigs.github.io/metrics-server/`{{execute}}

`helm install my-metrics-server metrics-server/metrics-server --version 3.8.2`{{execute}}

* Helm requires a names-space parameter if you choose to install the chart into a name-space