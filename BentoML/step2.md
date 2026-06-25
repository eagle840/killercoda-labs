## Containize the service

Lets creat a bentofile file:

`nano bentofile.yaml`{{exec}}


```yaml
service: "service:CancerClassifier"
name: "cancer"
include:
  - "service.py"
python:
  packages:
    - scikit-learn
    - numpy
```{{copy}}

and build it:

`bentoml build`{{exec}}


`bentoml serve cancer --production`{{exec}}

In a new terminal Tab:



```bash
curl -X 'POST' \
    'http://localhost:3000/predict' \
    -H 'accept: application/json' \
    -H 'Content-Type: application/json' \
    -d '{
    "data": [
        [1.308e+01, 1.571e+01, 8.563e+01, 5.200e+02, 1.075e-01, 1.270e-01,
        4.568e-02, 3.110e-02, 1.967e-01, 6.811e-02, 1.852e-01, 7.477e-01,
        1.383e+00, 1.467e+01, 4.097e-03, 1.898e-02, 1.698e-02, 6.490e-03,
        1.678e-02, 2.425e-03, 1.450e+01, 2.049e+01, 9.609e+01, 6.305e+02,
        1.312e-01, 2.776e-01, 1.890e-01, 7.283e-02, 3.184e-01, 8.183e-02]
      ]
    }'
```{{exec}}

or open http://127.0.0.1:3000  at the following link:
{{TRAFFIC_HOST1_3000}}


### And build a container  (18:01)


`bentoml containerize cancer`{{exec}}


`docker images`{{exec}}

`IMAGE=$(docker images | awk 'NR==2 {print $1}')`{{exec}}

`echo $IMAGE`{{exec}}

replace the tag name in the following:

Make sure the Bento serve isn't running, then:

`docker run -it --rm -p 3000:3000 $IMAGE serve --production`{{exec}}


In a new terminal Tab:



```bash
curl -X 'POST' \
    'http://localhost:3000/predict' \
    -H 'accept: application/json' \
    -H 'Content-Type: application/json' \
    -d '{
    "data": [
        [1.308e+01, 1.571e+01, 8.563e+01, 5.200e+02, 1.075e-01, 1.270e-01,
        4.568e-02, 3.110e-02, 1.967e-01, 6.811e-02, 1.852e-01, 7.477e-01,
        1.383e+00, 1.467e+01, 4.097e-03, 1.898e-02, 1.698e-02, 6.490e-03,
        1.678e-02, 2.425e-03, 1.450e+01, 2.049e+01, 9.609e+01, 6.305e+02,
        1.312e-01, 2.776e-01, 1.890e-01, 7.283e-02, 3.184e-01, 8.183e-02]
      ]
    }'
```{{exec}}

or open http://127.0.0.1:3000  at the following link:
{{TRAFFIC_HOST1_3000}}

