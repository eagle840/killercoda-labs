## Containize the service

Lets review the creation file:

`cat bentofile.yaml`{{exec}}

and build it:

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


### And auild a container  (18:01)

`bentoml containerize iris_classifier:latest`{{exec}}

WIP: change docker tag

`docker images`{{exec}}

`IMAGE=$(docker images | awk 'NR==2 {print $1":"$2}')`{{exec}}

`echo $IMAGE`{{exec}}


replace the tag name in the following:

Make sure the Bento serve isn't running, then:

`docker run -it --rm -p 3000:3000 $IMAGE serve --production`{{exec}}


In a new terminal Tab:

```
curl -X POST \
   -H "content-type: application/json" \
   --data "[[5.9, 3, 5.1, 1.8]]" \
   http://127.0.0.1:3000/classify
```{{exec}}

or open http://127.0.0.1:3000  at the following link:
{{TRAFFIC_HOST1_3000}}

