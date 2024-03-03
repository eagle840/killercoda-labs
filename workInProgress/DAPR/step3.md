# Step 3 Using zipkin

Stop the prior apps/dapr and return to  root

`cd ~`{{exec}}

https://docs.dapr.io/concepts/observability-concept/

Connect to zipkin, which was started at dapr init.

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


`kubectl get pods -A`{{exec}}




`helm repo add dapr https://dapr.github.io/helm-charts/`{{exec}}

`helm repo update`{{exec}}

`helm search repo dapr --devel --versions`{{exec}}

`helm upgrade --install dapr dapr/dapr --version=1.12 --namespace dapr-system --create-namespace --wait`{{exec}}

`kubectl get pods --namespace dapr-system`{{exec}}

`cat deploy/appconfig.yaml`{{exec}}

`kubectl apply -f ./deploy/appconfig.yaml`{{exec}}

`dapr configurations --kubernetes`{{exec}}

`kubectl apply -f ./deploy/zipkin.yaml`{{exec}}


`kubectl port-forward svc/zipkin 19411:9411 --address 0.0.0.0`{{exec}}


{{TRAFFIC_HOST1_19411}}

### Instrument the application for tracing and deploy it

`kubectl apply -f ../distributed-calculator/deploy`{{exec}}

`kubectl rollout status deploy/addapp`{{exec}}

`kubectl rollout status deploy/subtractapp`{{exec}}

`kubectl rollout status deploy/divideapp`{{exec}}

`kubectl rollout status deploy/multiplyapp`{{exec}}

`kubectl rollout status deploy/calculator-front-end`{{exec}}

`kubectl get pods`{{exec}}

`kubectl port-forward service/calculator-front-end 8000:80 --address 0.0.0.0`{{exec}}

{{TRAFFIC_HOST1_8000}}

### Discover and troubleshoot a performance issue using Zipkin


`kubectl apply -f ./deploy/python-multiplier.yaml`{{exec}}


`kubectl rollout status deploy/multiplyapp`{{exec}}

Now go to the calculator UI and perform several calculations. Make sure to use all operands. For example, do the following: 9 + 3 * 2 / 4 - 1 =


`curl -s http://localhost:8000/calculate/add -H Content-Type:application/json --data @operands.json`{{exec}}


Now go to the Zipkin dashboard by running. (Note: if you are running Dapr locally, be sure to use a different local port for Zipkin):

`kubectl port-forward svc/zipkin 19411:9411 --address 0.0.0.0`{{exec}}

{{TRAFFIC_HOST1_19411}}

### Zipkin API

As before, you can also access traces through the Zipkin API. The following will give you the same traces as the UI search above:

`curl -s http://localhost:19411/api/v2/traces?minDuration=250000 -H accept:application/json -o output.json && python3 -m json.tool output.json`{{exec}}

### Clean up

`kubectl delete -f ../distributed-calculator/deploy`{{exec}}

`kubectl delete -f deploy/zipkin.yaml`{{exec}}

----


dotnet and zipkin


https://www.youtube.com/watch?v=Cb0tyU9uSLQ
