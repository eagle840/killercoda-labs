
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


`apt install -y python3.12-venv`{{exec}}

from: https://docs.bentoml.com/en/latest/get-started/hello-world.html

```
git clone https://github.com/bentoml/quickstart.git
cd quickstart
```{{exec}}


# WIP
```
git clone https://github.com/bentoml/bentoml.git
cd bentoml
```{{exec}}

`python3 -m venv .venv`{{exec}}

`source ./.venv/bin/activate`{{exec}}

`pip install -e .`{{exec}}


---
# 2026

# Recommend Python 3.11
`pip install bentoml torch transformers`{{exec}}

`cat service.py`{{exec}}

`bentoml serve`{{exec}}

You can call the exposed summarize endpoint at http://localhost:3000.

```
curl -X 'POST' \
    'http://localhost:3000/summarize' \
    -H 'accept: text/plain' \
    -H 'Content-Type: application/json' \
    -d '{
    "text": "Breaking News: In an astonishing turn of events, the small town of Willow Creek has been taken by storm as local resident Jerry Thompson'\''s cat, Whiskers, performed what witnesses are calling a '\''miraculous and gravity-defying leap.'\'' Eyewitnesses report that Whiskers, an otherwise unremarkable tabby cat, jumped a record-breaking 20 feet into the air to catch a fly. The event, which took place in Thompson'\''s backyard, is now being investigated by scientists for potential breaches in the laws of physics. Local authorities are considering a town festival to celebrate what is being hailed as '\''The Leap of the Century."
}'
```{{exec}}


expect: `Hello world! Here's your summary: Whiskers, an otherwise unremarkable tabby cat, jumped a record-breaking 20 feet into the air to catch a fly . The event is now being investigated by scientists for potential breaches in the laws of physics . Local authorities considering a town festival to celebrate what is being hailed as 'The Leap of the Century'`


---

`cd examples/quickstart/`{{exec}}

`pip install bentoml scikit-learn pandas`{{exec}}

Lets reveiw the ML code:

`cat train.py`{{exec}}

And run it:

`python train.py`{{exec}}

Bentoml will require a service code

`cat service.py`{{exec}}

and run it to provide an api for processing predictions:

`entoml serve service:svc --reload`{{exec}}

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


---
# Reduced Model size

`python3 -m venv .venv`{{exec}}

`source ./.venv/bin/activate`{{exec}}


```
mkdir minimal-bento && cd minimal-bento
```{{exec}}

`pip install bentoml scikit-learn`{{exec}}

## 2. Create and Save a Tiny Model
Create a script named train.py. This script trains a model on a toy dataset and saves it to the BentoML local model store.

`nano train.py`{{exec}}

```python
# train.py
import bentoml
from sklearn.linear_model import LogisticRegression
from sklearn.datasets import load_iris

# Load a tiny toy dataset
data = load_iris()
X, y = data.data, data.target

# Train a simple model
clf = LogisticRegression(max_iter=200)
clf.fit(X, y)

# Save the model
bentoml.sklearn.save_model("iris_clf", clf)
print("Model saved to BentoML store.")
```{{copy}}

`python train.py`{{exec}}



## 3. Define the Service
Create a file named service.py. This handles the API logic. By keeping logic simple, you minimize memory overhead during startup.

`nano service.py`{{exec}}

```python
# service.py
import bentoml
import numpy as np

# Load the model from the store
runner = bentoml.sklearn.get("iris_clf:latest").to_runner()

# Define the service
svc = bentoml.Service("iris_service", runners=[runner])

@svc.api(input=bentoml.io.NumpyNdarray(), output=bentoml.io.NumpyNdarray())
def predict(input_series: np.ndarray) -> np.ndarray:
    result = runner.predict.run(input_series)
    return result
```{{copy}}

## Serve Locally

Launch the service. Using the --reload flag is helpful for development, but for a 2GB machine, running it directly is safer for memory stability.

`bentoml serve service:svc`{{exec}}


# Test the API


```bash
curl -X POST -H "Content-Type: application/json" \
  --data '[[5.1, 3.5, 1.4, 0.2]]' \
  http://localhost:3000/predict
```{{exec}}
