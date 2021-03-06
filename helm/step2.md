# INSTALL A SAMPLE CHART

## Install  metrics-server

There are two way to search repos from the command line: 

- helm search hub # searchs the artifact hub at: https://artifacthub.io/
- helm search repo # search the local repo you've added repo's to

### using the Repo

search the repo (all repos that have been added), note each has a chart version and an app version

`helm search repo`{{execute}} - None found, so lets add one

`helm repo add bitnami https://charts.bitnami.com/bitnami`{{execute}}   

`helm search repo`{{execute}}

If you ever need to update: `helm repo update`

Here's an example of a chart install, which we've called my-metrics-server

`helm install my-metrics-server bitnami/metrics-server \
  --version=4.2.2 \
  --namespace kube-system \
  --set apiService.create=true \
  --set extraArgs.kubelet-insecure-tls=true \
  --set extraArgs.kubelet-preferred-address-types=InternalIP
`

You can view the charts for bitnami at: https://bitnami.com/stacks/helm

###  using the hub

`helm search hub metrics-server`{{execute}}

we'll be using the 'metrics-server' version, details (including install) can be found here: https://artifacthub.io/packages/helm/metrics-server/metrics-server

`helm repo add metrics-server https://kubernetes-sigs.github.io/metrics-server/`{{execute}}

`helm install my-metrics-server metrics-server/metrics-server --version 3.8.2`{{execute}}

* Helm requires a names-space parameter if you choose to install the chart into a name-space

* to add addictional parameters: `helm install --set param=vale`, or supply a 'values' yaml file with the vales `--values file.yaml`

eg service.port=80



Lets check the helm chart is installed (-A shows all namespaces)

`helm list -A`{{execute}}

Also note that information is stored in ~/.cache/helm/:

`ls ./.cache/helm/repository/`{{exec}}


***Name***  this is the release name   
***App version:*** this is the version of the actual app
***Chart Version:*** this is the version of the chart, every time there is a change to the chart, the chart version is incremented, and you'll see it in the end of the chart name

`helm status my-metrics-server`{{execute}}

Lets check the endpoint is up (it will take a few minutes)

`kubectl get --raw /apis/metrics.k8s.io/v1beta1/nodes | jq`{{execute}}

tip: you can add the --debug  argument to troubleshoot



## Check metrics-server

let check it's installed, since it's installed in the kube-system namespace, we have to add the --namespace argument

`helm list -A`{{execute}}

`helm get notes my-metrics-server`{{execute}}

and lets check what values have been used:

`helm get values my-metrics-server`{{execute}}

To get a pervious release, you can use `--revision <release number>`

## Pull down and exmine the chart

lets pull down and look at the metric server on the bitnami repo

`helm pull bitnami/metrics-server`{{execute}}

`tar -zxvf metrics-server-*.tgz`{{execute}}

`tree metrics-server`{{execute}}

`cd metrics-server/`{{execute}}

all the files in the template folder will be processed with [Go Templating](https://pkg.go.dev/text/template) to produce a yaml file for a k8s apply file

lets see the output, as text, when we process this chart

`helm template .`{{execute}}

You can override the values in the values.yaml folder when processing, by using '--set'

