## Step 4: Configuring Istio for the Bookinfo App

Apply Istio configuration files to enable traffic management and observability features for the Bookinfo app. Verify that the Istio sidecar proxies are injected into the Bookinfo microservices. Explore the different Istio resources and their configurations.



Apply the Istio configuration files:

```
kubectl apply -f <path_to_istio_config_files>
```{{exec}}

Verify that the Istio sidecar proxies are injected into the Bookinfo microservices:

```shell
kubectl get pods -n <namespace> -l app=productpage -o jsonpath='{.items[*].metadata.name}' | xargs -I {} kubectl exec -n <namespace> {} -c istio-proxy -- curl -s http://localhost:15000/config_dump | grep "cluster_name"
```{{exec}}

Explore the different Istio resources and their configurations:

```shell
kubectl get virtualservices -n <namespace>
kubectl get destinationrules -n <namespace>
kubectl get gateways -n <namespace>
kubectl get serviceentries -n <namespace>
kubectl get sidecars -n <namespace>
```{{exec}}