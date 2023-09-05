
# Initial Setup

We'll need the latest docker version (with Docker Buildx)

### Uninstall the old Docker

`apt-get remove docker  docker.io containerd runc -y`{{exec}}   

`apt-get update`{{exec}}   

`apt-get install ca-certificates curl gnupg  lsb-release -y`{{exec}}   

`mkdir -p /etc/apt/keyrings`{{exec}}   

`curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg`{{exec}}   

```
echo   "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```{{exec}}   

`apt-get update`{{exec}}   

#### And finally install the lastest version

`apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y `{{exec}}   

`docker version`{{exec}}   

`docker-compose version`{{exec}}   

`docker compose version`{{exec}}

## BentoML

This quickstart is taken from the BenoML site: https://docs.bentoml.org/en/latest/tutorial.html


```
git clone https://github.com/bentoml/bentoml.git
cd bentoml
pip install -e .
```{{exec}}




`cd examples/quickstart/`{{exec}}

`pip install bentoml scikit-learn pandas`{{exec}}

Lets reveiw the ML code:

`cat train.py`{{exec}}

And run it:

`python train.py`{{exec}}

Bentoml will require a service code

`cat service.py`{{exec}}

and run it to provide an api for processing predictions:

`bentoml serve service:svc --reload`{{exec}}

In a new terminal Tab:

```
curl -X POST \
   -H "content-type: application/json" \
   --data "[[5.9, 3, 5.1, 1.8]]" \
   http://127.0.0.1:3000/classify
```{{exec}}

Note the returned value of '[2]'

or open http://127.0.0.1:3000  at the following link:
{{TRAFFIC_HOST1_3000}}

Terminate bentoservice with crtl-c


########  delete below   ###


## Containize the service

`cat bentofile.yaml`{{exec}}

`bentoml build`{{exec}}


`bentoml serve iris_classifier:latest --production`{{exec}}

In a new terminal Tab:

```
curl -X POST \
   -H "content-type: application/json" \
   --data "[[5.9, 3, 5.1, 1.8]]" \
   http://127.0.0.1:3000/classify
```{{exec}}

or open http://127.0.0.1:3000  at the following link:
{{TRAFFIC_HOST1_3000}}



########  delete below   ###

### Build a container  (18:01)

`bentoml containerize iris_classifier:latest`{{exec}}

WIP: change docker tag

`docker images`{{exec}}

replace the tag name in the following:

`docker run -it --rm -p 3000:3000 iris_classifier:<TAG> serve --production`{{copy}}

In a new terminal Tab:

```
curl -X POST \
   -H "content-type: application/json" \
   --data "[[5.9, 3, 5.1, 1.8]]" \
   http://127.0.0.1:3000/classify
```{{exec}}

or open http://127.0.0.1:3000  at the following link:
{{TRAFFIC_HOST1_3000}}

