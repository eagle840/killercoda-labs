# istio dashboards

To access the Istio web dashboard, you can use:

`istioctl dashboard -h`{{exec}}

when you want to launch a dashboard on killacoda, add:

'--address 0.0.0.0 --browser=false'


for these dashboards, we need to install the following:

Lets review the addons that the istio install provides:

`tree ./samples/addons/`{{exec}}

`cat ./samples/addons/README.md`{{exec}}


## Kiali Dashboard

Kiali (https://kiali.io/) the the main dashboard for Kiali

start the kiali dashbord:

`istioctl dashboard kiali --address 0.0.0.0 --browser=false &`{{exec}}

`k get pods -n istio-system`{{exec}}

`k get svc -n istio-system kiali`{{exec}}

we'll also need prometheus

`k apply -f ./samples/addons/prometheus.yaml`{{exec}}


`kubectl patch -n istio-system svc kiali -p '{"spec": {"type": "NodePort"}}'`{{exec}}

 `k get svc -n istio-system kiali`{{exec}}

and open the port on 20001

port 20001/Kiali/console

{{TRAFFIC_HOST1_20001}}



##  Grafana WIP:  crashes prometheus!


`k apply -f ./samples/addons/grafana.yaml`{{exec}}

and confirm its running:

`k get pods -n istio-system`{{exec}}



to start grafana  <=  need to add k8s storage for grafana!

`istioctl dashboard grafana --address 0.0.0.0 --browser=false`{{exec}}  
{{TRAFFIC_HOST1_3000}}

`kubectl patch -n istio-system svc kiali -p '{"spec": {"type": "NodePort"}}'`{{exec}}

 `k get svc -n istio-system kiali`{{exec}}

kubectl patch -n istio-system svc kiali -p '{"spec": {"port": {}}} =< change port #

prometheus:   /graph   (9090)
kiali:        /kiali/console/overview?duration=60&refresh=60000 (20001)
grafana:      ?orgId=1
jaeger:       /jaeger/search


## Generate some flow through the app:


`k get svc productpage`{{exec}}

`export INGRESS_PORT=$(kubectl get svc productpage -o json | jq .spec.ports[0].port)`{{exec}}

`export INGRESS_IP=$(kubectl get svc productpage -o json | jq -r .spec.clusterIP)`{{exec}}


`while sleep 0.01; do curl -sS 'http://'"$INGRESS_IP"':'"$INGRESS_PORT"'/productpage'\ &> /dev/null ; done`{{exec}}

? add -HHost:httpbin.example.com



===========  WIP ==========

`curl -s -I -HHost:httpbin.example.com "http://$INGRESS_HOST:$INGRESS_PORT/status/200"`


`curl -s -I -HHost:httpbin.example.com "http://$INGRESS_HOST:$INGRESS_PORT/headers"`

`curl -HHost:httpbin.example.com "http://$INGRESS_HOST:$INGRESS_PORT/html"`


##  metrics-server  ====================================

`kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml`{{exec}}

from: https://github.com/kubernetes-sigs/metrics-server

tls doesn't work on killercoda, add 

--kubelet-insecure-tls   

`k edit deploy -n kube-system   metrics-server`{{copy}}

WIP  add to to the apply command?  

`k patch -n kube-system svc metrics-server -p '{"spec":{"type": "NodePort"}}'`{{copy}}


==============================================================



