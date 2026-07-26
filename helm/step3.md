# Create and Customize Helm Charts

In this step, we will learn how to create a basic Helm chart, customize it using Go templating, debug it, and deploy it to the cluster.

---

### 1. Create a Helm Chart

Helm provides a generator to bootstrap a new chart with a default nginx-based structure.

`cd ~`{{execute}}

`helm create examplechart`{{execute}}

`cd examplechart`{{execute}}

---

### 2. Explore Chart Structure

*   **`Chart.yaml`**: Contains metadata about the chart (name, description, and version). Note the `apiVersion: v2`, which indicates this is a Helm 3 chart; version 2 of the API was introduced to support Helm 3 features and is not related to the chart versioning itself.
*   **`values.yaml`**: Contains the default configuration values. You can override these during installation using `--set` or a custom values file.

---

### 3. Customize and Debug

To make a chart dynamic, we use Go templates to inject values.

#### Customize the Template
Edit the deployment file to use a value from `values.yaml` for the number of replicas:

`sed -i 's/replicaCount: 1/replicaCount: 2/' values.yaml`{{execute}}

`sed -i 's/{{ .Values.replicaCount }}/{{ .Values.replicaCount }}/' templates/deployment.yaml`{{execute}}

*(Note: The default generator already uses `{{ .Values.replicaCount }}`. You can check it with `cat templates/deployment.yaml`)*

#### Lint and Debug
It is best practice to verify your chart's structure and simulate the output.

**Lint the Chart:**
`helm lint`{{execute}}

**Debug with Template:**
Use `helm template` to render the manifests without installing them. The `--debug` flag is essential for troubleshooting template errors.

`helm template . --set replicaCount=2 --debug`{{execute}}

---

### 4. Install and Verify

Now, install your new chart into the cluster:

`cd ~`{{execute}}

`helm install new-chart examplechart/ --values examplechart/values.yaml`{{execute}}

#### Verify Deployment

`helm list -A`{{execute}}

`helm status new-chart`{{execute}}

`kubectl get svc -A`{{execute}}

#### Test Connectivity
Port-forward the service to your local machine:

```bash
export POD_NAME=$(kubectl get pods --namespace default -l "app.kubernetes.io/name=examplechart,app.kubernetes.io/instance=new-chart" -o jsonpath="{.items[0].metadata.name}")
export CONTAINER_PORT=$(kubectl get pod --namespace default $POD_NAME -o jsonpath="{.spec.containers[0].ports[0].containerPort}")
kubectl --namespace default port-forward $POD_NAME 8080:$CONTAINER_PORT
```{{copy}}

*You can now connect to {{TRAFFIC_HOST1_80}}.*

---

### 5. Cleanup

Once you have verified the deployment, uninstall the release:

`helm uninstall new-chart`{{execute}}
