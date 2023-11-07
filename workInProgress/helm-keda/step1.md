Stateful sets require dynamic provisioning to use volumes,  however in this scenario will be using NFS to get around this


Run Ubuntu updates:

`apt-get update -y`{{execute}}

# HELM


`curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3`{{execute}}

`chmod 700 get_helm.sh`{{execute}}

`./get_helm.sh`{{execute}}

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






================================

# install metrics-server

install helm3  (from https://github.com/helm/helm/releases)

`wget https://get.helm.sh/helm-v3.7.1-linux-amd64.tar.gz`{{execute}}   

`tar -zxvf helm-v3.7.1-linux-amd64.tar.gz`{{execute}}

`mv linux-amd64/helm /usr/local/bin/helm`{{execute}}

`helm version`{{execute}}

# install by script

`curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3`{{execute}}

`chmod 700 get_helm.sh`{{execute}}

`./get_helm.sh`{{execute}}

`helm repo add metrics-server https://kubernetes-sigs.github.io/metrics-server/`

```
helm install metrics-server metrics-server/metrics-server \
  --version=4.2.2 \
  --namespace kube-system \
  --set apiService.create=true \
  --set extraArgs.kubelet-insecure-tls=true \
  --set extraArgs.kubelet-preferred-address-types=InternalIP
``` 


`helm repo add bitnami https://charts.bitnami.com/bitnami`{{execute}}   
```
helm install metrics-server bitnami/metrics-server \
  --version=4.2.2 \
  --namespace kube-system \
  --set apiService.create=true \
  --set extraArgs.kubelet-insecure-tls=true \
  --set extraArgs.kubelet-preferred-address-types=InternalIP
``` 


Lets check the endpoint is up

`kubectl get --raw /apis/metrics.k8s.io/v1beta1/nodes | jq`{{execute}}

and check the top command (will take a couple of minutes to set getting metrics)

`kubectl top node`{{execute}}


# setup docker images

Create a custom Dockerfile


`nano Dockerfile`{{execute}}

```
FROM php:5-apache
COPY index.php /var/www/html/index.php
RUN chmod a+rx index.php
```

create the index.php file

`nano index.php`{{execute}}
```
<?php
  $x = 0.0001;
  for ($i = 0; $i <= 1000000; $i++) {
    $x += sqrt($x);
  }
  echo "OK!";
?>
```

build the docker image

`docker build -t php-apache .`{{execute}}

Deploy that image into K8S:

`mkdir application`{{execute}}   

`nano application/php-apache.yaml`{{execute}}

```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: php-apache
spec:
  selector:
    matchLabels:
      run: php-apache
  replicas: 1
  template:
    metadata:
      labels:
        run: php-apache
    spec:
      containers:
      - name: php-apache
        image: k8s.gcr.io/hpa-example
        ports:
        - containerPort: 80
        resources:
          limits:
            cpu: 500m
          requests:
            cpu: 200m
---
apiVersion: v1
kind: Service
metadata:
  name: php-apache
  labels:
    run: php-apache
spec:
  ports:
  - port: 80
  selector:
    run: php-apache
```



Apply the application in K8S:

`kubectl apply -f https://k8s.io/examples/application/php-apache.yaml`{{execute}}

check the application has been started

`kubectl get pods`{{execute}}





Create the HPA.
`kubectl autoscale deployment php-apache --cpu-percent=50 --min=1 --max=10`{{execute}}



`kubectl get hpa`{{execute}}

