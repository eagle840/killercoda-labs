# istio dashboards

`istioctl dashboard -h`{{exec}}

when you want to launch a dashboard on killacoda, add:

`--address 0.0.0.0 --browser=false`{{copy}}


for these dashboards, we need to install the following:

WIP `k apply -f ./samples/addons/`{{copy}}  # crashs cluster

`tree ./samples/addons/`{{exec}}

`k apply -f ./samples/addons/kiali.yaml`{{exec}}


WIP prometheus isn't booting (and so grafana), add each addon seperatly and troubleshoot

`k get pods -n istio-system`{{exec}}

`k get svc -n istio-system kiali`{{exec}}


start the kiali dashbord:

`istioctl dashboard kiali --address 0.0.0.0 --browser=false &`{{exec}}

and open the port on 20001

port 20001/Kiali/console

{{TRAFFIC_HOST1_20001}}

start prometheus

`k apply -f ./samples/addons/prometheus.yaml`{{exec}}

and confirm its running:

`k get pods -n istio-system`{{exec}}

start grafana WIP:  crashes prometheus!
see `cat ./samples/addons/README.md`{{exec}}

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

export INGRESS_PORT=$(kubectl get svc productpage -o json | jq .spec.ports[0].port)

export INGRESS_IP=$(kubectl get svc productpage -o json | jq -r .spec.clusterIP)


while sleep 0.01; do curl -sS 'http://'"$INGRESS_IP"':'"$INGRESS_PORT"'/productpage'\ &> /dev/null ; done

? add -HHost:httpbin.example.com



======================  WIP =====================


```
export INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="http2")].nodePort}')
export SECURE_INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="https")].nodePort}')
export TCP_INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="tcp")].nodePort}')
export INGRESS_HOST=$(kubectl get po -l istio=ingressgateway -n istio-system -o jsonpath='{.items[0].status.hostIP}')
```{{exec}}


`while sleep 0.01; do curl -sS 'http://'"$INGRESS_HOST"':'"$INGRESS_PORT"'/productpage'\ &> /dev/null ; done`

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



