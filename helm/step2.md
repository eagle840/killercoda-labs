# Install a Sample Chart

In this step, we will learn how to search Helm repositories, install the `metrics-server` chart, and examine the chart structure.

---

### 1. Repository Management

Helm uses repositories to manage chart collections. 

**Search Options:**
*   `helm search hub`: Searches the [Artifact Hub](https://artifacthub.io/), which is a good place to discover new charts.
*   `helm search repo`: Searches the local repositories you have already added.

**Add the Metrics Server Repository:**
Add the official repository and update your local cache:

`helm repo add metrics-server https://kubernetes-sigs.github.io/metrics-server/`{{execute}}
`helm repo update`{{execute}}

---

### 2. Installing metrics-server

Before installing, it is helpful to understand versioning:
*   **App Version:** The version of the underlying application (the `metrics-server` binary).
*   **Chart Version:** The version of the Helm chart itself, which packages the manifests and configuration.

**Install the Chart:**
We will use `helm upgrade --install` which creates the release if it doesn't exist or upgrades it if it does.

`helm upgrade --install metrics-server metrics-server/metrics-server --namespace kube-system`{{execute}}

---

### 3. Verification and Troubleshooting

#### Verify Installation
Confirm the chart is installed in the `kube-system` namespace:

`helm list -n kube-system`{{execute}}

#### Check Pod Status
If the metrics aren't appearing, check that the pod is running:

`kubectl get pods -n kube-system -l app.kubernetes.io/name=metrics-server`{{execute}}

#### Accessing Metrics
Once the pod is ready, verify the API endpoint:

`kubectl get --raw /apis/metrics.k8s.io/v1beta1/nodes | jq`{{execute}}

#### Port Forwarding
For testing access, you can port-forward to the pod:

```bash
export POD_NAME=$(kubectl get pods --namespace kube-system -l "app.kubernetes.io/name=metrics-server" -o jsonpath="{.items[0].metadata.name}")
kubectl --namespace kube-system port-forward $POD_NAME 8080:4443
```{{copy}}

---

### 4. Examine the Chart

You can pull down the chart source to examine how it is packaged:

`helm pull metrics-server/metrics-server`{{execute}}
`tar -zxvf metrics-server-*.tgz`{{execute}}
`tree metrics-server`{{execute}}

Inside the `templates/` folder, Helm uses Go Templating to process the Kubernetes manifests. You can render these templates to see the final output:

`helm template metrics-server/`{{execute}}
