



`kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml`{{exec}}



`k apply -f ./samples/addons/`{{exec}}

`k get svc -n istio-system kiali`{{exec}}

istioctl dashboard

port 20001/Kiali/console

`kubectl patch -n istio-system svc kiali -p '{"spec": {"type": "NodePort"}}'{{exec}}

kubectl patch -n istio-system svc kiali -p '{"spec": {"type": "NodePort"}} =< change port #




