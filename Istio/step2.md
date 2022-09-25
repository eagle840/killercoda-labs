



`kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml`{{exec}}

from: https://github.com/kubernetes-sigs/metrics-server

tls doesn't work on killercoda, add --kubelet-insecure-tls
`k edit deploy -n kube-system   metrics-server`{{copy}}
WIP  add to to the apply command?

`k patch -n kube-system svc metrics-server -p '{"spec":{"type": "NodePort"}}'`{{copy}}

`istioctl dashboard -h`{{exec}}



`k apply -f ./samples/addons/`{{exec}}

`k get svc -n istio-system kiali`{{exec}}


istioctl dashboard

port 20001/Kiali/console

this fails in killacoda: `istioctl dashboard kiali`{{copy}}

`istioctl dashboard kiali --address 0.0.0.0 --browser=false`{{exec}}

{{TRAFFIC_HOST1_20001}}

`istioctl dashboard grafana --address 0.0.0.0 --browser=false`{{exec}}  
{{TRAFFIC_HOST1_3000}}

`kubectl patch -n istio-system svc kiali -p '{"spec": {"type": "NodePort"}}'`{{exec}}

 `k get svc -n istio-system kiali`{{exec}}

kubectl patch -n istio-system svc kiali -p '{"spec": {"port": {}}} =< change port #

prometheus:   /graph   (9090)
kiali:        /kiali/console/overview?duration=60&refresh=60000 (20001)
grafana:      ?orgId=1
jaeger:       /jaeger/search


while sleep 0.01; do curl -sS 'http://'"$INGRESS_HOST"':'"$INGRESS_PORT"'/productpage'\ &> /dev/null ; done



