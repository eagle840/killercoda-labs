# Custom and multiple metrics

Lets get a copy of the HPA yaml

`kubectl get hpa php-apache -o yaml > /tmp/hpa-v2.yaml`{{execute}}

Review the documentation at: https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale-walkthrough/


===============================    

copied from katacode observe  https://www.katacoda.com/courses/kubernetes/kubernetes-observability-basics-by-javajon


install helm3  (from https://github.com/helm/helm/releases)

`wget https://get.helm.sh/helm-v3.7.1-linux-amd64.tar.gz`{{execute}}   

`tar -zxvf helm-v3.7.1-linux-amd64.tar.gz`{{execute}}

`mv linux-amd64/helm /usr/local/bin/helm`{{execute}}

`helm version`{{execute}}

Add the Bitnami chart repository for the Helm chart to be installed.

`helm init`{{execute}}

`helm repo add bitnami https://charts.bitnami.com/bitnami`{{execute}}

Install the chart.

```
helm install metrics-server bitnami/metrics-server \
  --version=4.2.2 \
  --namespace kube-system \
  --set apiService.create=true \
  --set extraArgs.kubelet-insecure-tls=true \
  --set extraArgs.kubelet-preferred-address-types=InternalIP
```  

This will install the server in the kube-system namespace. It also add a new API endpoint named metrics.k8s.io. In a few moments you should be able to list metrics using the following command:

`kubectl get --raw /apis/metrics.k8s.io/v1beta1/nodes | jq`{{execute}}

If the metrics are not ready, this message will appear

Error from server (ServiceUnavailable): the server is currently unable to handle the request

Once the metrics are ready, a JSON dump of the metrics will appear. Additional metrics also appears in the top report.

`kubectl top node`{{execute}}

If the metrics are not ready you may get this message.

Error from server (ServiceUnavaliable): the server is currently unable to handle the request (get nodes.metrics.k8s.io)

or

error: metrics not available yet

However, once the metrics are available the normal message should look similar to this:

NAME           CPU(cores)   CPU%   MEMORY(bytes)   MEMORY%
controlplane   138m         6%     991Mi           52%
node01         79m          3%     575Mi           14%
Pod information can also be observed.

`kubectl top pods --all-namespaces`{{execute}}



# KEDA

https://keda.sh/docs/2.4/deploy/

https://keda.sh/docs/2.4/concepts/



## install keda

see doc:  https://keda.sh/docs/1.4/deploy/

`helm repo add kedacore https://kedacore.github.io/charts`{{execute}}   
`helm repo update`{{execute}}   
`kubectl create namespace keda`{{execute}}   
`helm install keda kedacore/keda --version 1.4.2 --namespace keda`{{execute}}

I noted that the lastest version is 2.4!




