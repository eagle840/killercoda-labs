# Deploy to k8s with Yatai


https://github.com/bentoml/Yatai

install Yatai

`DEVEL=true bash <(curl -s "https://raw.githubusercontent.com/bentoml/yatai/main/scripts/quick-install-yatai.sh")`


`kubectl cluster-info`{{exec}}




In a seperate terminal:

```
YATAI_INITIALIZATION_TOKEN=$(kubectl get secret env --namespace yatai-system -o jsonpath="{.data.YATAI_INITIALIZATION_TOKEN}" | base64 --decode)
echo "Open in browser: http://127.0.0.1:8080/setup?token=$YATAI_INITIALIZATION_TOKEN"
```((exec))


goto http://127.0.0.1:8080/api_tokens


`bentoml yatai login --api-token {YOUR_TOKEN} --endpoint http://127.0.0.1:8080`{{exec}}

`bentoml push iris_classifier:latest`{{exec}}

```
DEVEL=true bash <(curl -s "https://raw.githubusercontent.com/bentoml/yatai-deployment/main/scripts/quick-install-yatai-deployment.sh")
```{{exec}}

goto http://127.0.0.1:8080/deployments and click 'create' and follow the instructions


The github page also includes instructions for deploying through CRD


### BentoMLctl

consider fro deployment to a cloud provider
https://github.com/bentoml/bentoctl