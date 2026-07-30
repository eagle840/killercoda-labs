# Deploying Nginx on K3s

Now that our lightweight cluster is running, let's deploy a containerized workload to confirm its orchestration capabilities. We will deploy Nginx and expose it to external traffic.

### 1. Create Nginx Deployment
Create a deployment running Nginx with 2 replica pods:

```bash
kubectl create deployment nginx-deploy --image=nginx --replicas=2
```{{exec}}

### 2. Monitor Pod Status
Watch the pods being scheduled and started by the K3s engine:

```bash
kubectl get pods -w
```{{exec}}

*Press `Ctrl+C` to stop watching once both pods are in the `Running` state.*

### 3. Expose the Application
We will expose the deployment using a Kubernetes `NodePort` service. This will open a dedicated port on the host machine to forward traffic to our Nginx pods:

```bash
kubectl expose deployment nginx-deploy --type=NodePort --port=80 --name=nginx-service
```{{exec}}

### 4. Query the Application
Let's find the high-port NodePort assigned by Kubernetes and send an HTTP request to verify Nginx is serving traffic:

```bash
NODE_PORT=$(kubectl get svc nginx-service -o jsonpath='{.spec.ports[0].nodePort}')
echo "Nginx is exposed on NodePort: $NODE_PORT"
curl -I http://localhost:$NODE_PORT
```{{exec}}

You should see a successful `200 OK` response back from Nginx!

Once the Nginx deployment is running with 2 replicas and you have successfully verified traffic via curl, click **Verify** to proceed to the next step.
