## Step 3: Testing Traffic Management with Istio

In this step, you will use Istio's traffic management features to route traffic to different versions of the Bookinfo microservices. You will observe the behavior of the application as traffic is routed to different versions and experiment with Istio's fault injection and circuit breaking capabilities.

### Route Traffic to Different Versions

To route traffic to different versions of the Bookinfo microservices, you will use Istio's VirtualService resource. Let's start by creating a VirtualService for the reviews microservice:

```shell
kubectl apply -f virtualservice-reviews-v2.yaml
```{{exec}}

Verify that the VirtualService is created:

```shell
kubectl get virtualservice reviews -o yaml
```{{exec}}

You should see the VirtualService configuration for the reviews microservice, specifying the routing rules.

### Observe the Behavior of the Application

To observe the behavior of the application as traffic is routed to different versions, you can use the Bookinfo web interface. Open the Bookinfo web page by running the following command:

```shell
minikube service productpage --url
```{{exec}}

Copy the URL and open it in a web browser. You should see the Bookinfo application.

Refresh the page multiple times and observe that the reviews section displays different versions of reviews (v1, v2, and v3) based on the routing rules defined in the VirtualService.

### Experiment with Fault Injection and Circuit Breaking

Istio provides fault injection and circuit breaking capabilities that allow you to simulate failures and control traffic flow. Let's experiment with these features.

#### Fault Injection

To simulate a delay in the reviews microservice, apply a fault injection rule:

```shell
kubectl apply -f fault-injection-reviews.yaml
```{{exec}}

Verify that the fault injection rule is applied:

```shell
kubectl get faultinjectionreviews -o yaml
```{{exec}}

Refresh the Bookinfo web page and observe that the reviews section now has a delay.

#### Circuit Breaking

To apply circuit breaking to the reviews microservice, create a DestinationRule:

```shell
kubectl apply -f destinationrule-reviews.yaml
```{{exec}}

Verify that the DestinationRule is created:

```shell
kubectl get destinationrule reviews -o yaml
```{{exec}}

Refresh the Bookinfo web page and observe that the reviews section now displays an error message due to circuit breaking.

### Clean Up

Before proceeding to the next step, let's clean up the resources created in this step.

```shell
kubectl delete -f virtualservice-reviews-v2.yaml
kubectl delete -f fault-injection-reviews.yaml
kubectl delete -f destinationrule-reviews.yaml
```{{exec}}