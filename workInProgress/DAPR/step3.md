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


