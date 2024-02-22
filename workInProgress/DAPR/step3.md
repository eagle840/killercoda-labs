# Step 3 Using zipkin

https://docs.dapr.io/concepts/observability-concept/

Connect to zipkin

{{TRAFFIC_HOST1_9411}}

REVIEW https://github.com/dapr/quickstarts/tree/master/tutorials/observability

`node --version`{{exec}}

`cd ~/quickstarts/tutorials/observability`{{exec}}


`cd ../hello-world/node && npm install && dapr run --app-id hello-tracing --app-port 3000 node app.js && cd ../../observability`{{exec}}

NEW TAB

`cd ~/quickstarts/tutorials/observability`{{exec}}

`dapr invoke --app-id hello-tracing --method neworder --data-file sample.json`{{exec}}

WIP Can I deploy on k8s and run the rest of the quickstart?

## K8S observability


`cd ~/quickstarts/tutorials/observability`{{exec}}

`kubectl get pods`{{exec}}

`kubectl get pods -A`{{exec}}

`kubectl apply -f ./deploy/appconfig.yaml`{{exec}}

`pwd`{{exec}}

`cat deploy/appconfig.yaml`{{exec}}

`helm repo add dapr https://dapr.github.io/helm-charts/`{{exec}}

`helm repo update`{{exec}}

`helm search repo dapr --devel --versions`{{exec}}

`helm upgrade --install dapr dapr/dapr --version=1.12 --namespace dapr-system --create-namespace --wait`{{exec}}

`kubectl get pods --namespace dapr-system`{{exec}}

`kubectl apply -f ./deploy/appconfig.yaml`{{exec}}

`dapr configurations --kubernetes`{{exec}}

`kubectl apply -f ./deploy/zipkin.yaml`{{exec}}

`kubectl port-forward svc/zipkin 19411:9411`{{exec}}

`kubectl port-forward svc/zipkin 0.0.0.0:19411:9411`{{exec}}



