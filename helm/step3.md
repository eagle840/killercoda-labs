# CREATE YOUR OWN

we'll install the sample chart provided by helm, this example automatically uses an nginx image:

`cd ~`{{execute}}

`helm create examplechart`{{execute}}

`cd examplechart`{{execute}}

`tree`{{execute}}

take a read of the chart file

`cat Chart.yaml`{{execute}}

Note  the `version: 0.1.0`  that defines the chart version, The `ApiVersion=v2`, which is actuall Helm 3

The charts folder is for dependant charts for this chart, but we won't using these in this demo.
Note  the `version: 0.1.0`  that defines the chart version

`cat values.yaml`{{execute}}

The values yaml file is for values that you'll want to change every now and then. EG a service port number, again you can override using --set (eg service.port=80)

lets look at the generated yaml, but chnage a value

`helm template .  --set replicaCount=2`{{execute}}

Lets run a helm lint on this chart to make sure its ok

`helm lint`{{execute}}

Now install the chart

`cd ~`{{execute}}

`helm install new-chart examplechart/ --values examplechart/values.yaml`{{execute}}

`helm list -A`{{execute}}

`helm status new-chart`{{execute}}

`k get svc -A`{{execute}}


We'll port forward to this machine:

`export POD_NAME=$(kubectl get pods --namespace default -l "app.kubernetes.io/name=examplechart,app.kubernetes.io/instance=new-chart" -o jsonpath="{.items[0].metadata.name}")`{{execute}}     


`export CONTAINER_PORT=$(kubectl get pod --namespace default $POD_NAME -o jsonpath="{.spec.containers[0].ports[0].containerPort}")`{{exec}} 

`kubectl --namespace default port-forward $POD_NAME 8080:$CONTAINER_PORT`{{execute}}   

and connect {{TRAFFIC_HOST1_80}}

to remove

`helm uninstall new-chart`{{execute}}
