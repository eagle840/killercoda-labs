## Step 3: Deploying the Bookinfo Example App

In this step, you will deploy the Bookinfo example application to your Kubernetes cluster.

Clone the Bookinfo example app repository from GitHub:

`git clone https://github.com/istio/istio.git`{{exec}}

Change to the Bookinfo example app directory:

`cd istio/samples/bookinfo/platform/kube`{{exec}}

Deploy the Bookinfo application to your Kubernetes cluster:

`kubectl apply -f bookinfo.yaml`{{exec}}

Verify that all microservices and associated resources are successfully deployed:

`kubectl get pods`{{exec}}