



`kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml`{{exec}}



`k apply -f ./samples/addons/`{{exec}}

`k get svc -n istio-system kiali`{{exec}}

`istio dashboard jaeger`{{exec}}

istioctl dashboard

port 20001/Kiali/console

`istio dashboard kiali`{{exec}}

`istio dashboard grafana`{{exec}}

`kubectl patch -n istio-system svc kiali -p '{"spec": {"type": "NodePort"}}'`{{exec}}

 `k get svc -n istio-system kiali`{{exec}}

kubectl patch -n istio-system svc kiali -p '{"spec": {"port": {}}} =< change port #




