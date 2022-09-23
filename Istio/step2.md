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

WIP: use this helm chart

```sh
helm install my-metrics-server bitnami/metrics-server \
  --version=5.11.9 \
  --namespace kube-system \
  --set apiService.create=true \
  --set extraArgs.kubelet-insecure-tls=true \
  --set extraArgs.kubelet-preferred-address-types=InternalIP
```{{copy}}

You can view the charts for bitnami at: https://bitnami.com/stacks/helm



* to add addictional parameters: `helm install --set param=vale`, or supply a 'values' yaml file with the vales `--values file.yaml`

eg service.port=80



Lets check the helm chart is installed (-A shows all namespaces)

`helm list -A`{{execute}}

Also note that information is stored in ~/.cache/helm/:

`ls ./.cache/helm/repository/`{{exec}}


***Name***  this is the release name   
***App version:*** this is the version of the actual app
***Chart Version:*** this is the version of the chart, every time there is a change to the chart, the chart version is incremented, and you'll see it in the end of the chart name

`helm status my-metrics-server -n kube-system`{{execute}}

Lets check the endpoint is up (it will take a few minutes)

`kubectl get --raw /apis/metrics.k8s.io/v1beta1/nodes | jq`{{execute}}

tip: you can add the --debug  argument to troubleshoot

connect to the uri

`k get svc -A`{{exec}}

We'll port forward to this machine:

WIP: update with the correct values:

`export POD_NAME=$(kubectl get pods --namespace kube-system  -l "app.kubernetes.io/name=metrics-server,app.kubernetes.io/instance=my-metrics-server" -o jsonpath="{.items[0].metadata.name}")`{{execute}}     


`export CONTAINER_PORT=$(kubectl get pod --namespace kube-system $POD_NAME -o jsonpath="{.spec.containers[0].ports[0].containerPort}")`{{exec}} 

`kubectl --namespace kube-system port-forward $POD_NAME 8080:$CONTAINER_PORT`{{execute}}   

and connect {{TRAFFIC_HOST1_8080}}



## Check metrics-server

let check it's installed, since it's installed in the kube-system namespace, we have to add the --namespace argument

`helm list -A`{{execute}}

`helm get notes my-metrics-server`{{execute}}

and lets check what values have been used:

`helm get values my-metrics-server`{{execute}}

To get a pervious release, you can use `--revision <release number>`

## Pull down and examine the chart

lets pull down and look at the metric server on the bitnami repo

`helm pull bitnami/metrics-server`{{execute}}

`tar -zxvf metrics-server-*.tgz`{{execute}}

`tree metrics-server`{{execute}}

`cd metrics-server/`{{execute}}

all the files in the template folder will be processed with [Go Templating](https://pkg.go.dev/text/template) to produce a yaml file for a k8s apply file

lets see the output, as text, when we process this chart

`helm template .`{{execute}}

You can override the values in the values.yaml folder when processing, by using '--set'

