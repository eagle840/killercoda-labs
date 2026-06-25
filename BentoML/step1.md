# Reduced Model size

`apt install -y python3.12-venv`{{exec}}

```
mkdir minimal-bento && cd minimal-bento
```{{exec}}

`python3 -m venv .venv`{{exec}}

`source ./.venv/bin/activate`{{exec}}



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

`bentoml models list`{{exec}}



## 3. Define the Service
Create a file named service.py. This handles the API logic. By keeping logic simple, you minimize memory overhead during startup.

`nano service.py`{{exec}}

```python
import bentoml
import numpy as np

# 1. Reference the model directly
iris_model = bentoml.sklearn.get("iris_clf:latest")

@bentoml.service(name="iris_service")
class IrisService:
    # 2. Use the model reference. 
    # BentoML 1.4+ automatically handles the runner initialization 
    # when you declare the model as part of the service.
    def __init__(self):
        self.model = bentoml.sklearn.load_model("iris_clf:latest")

    @bentoml.api
    def predict(self, input_series: np.ndarray) -> np.ndarray:
        # 3. Predict directly using the loaded model
        return self.model.predict(input_series)
```{{copy}}

## Serve Locally

Launch the service. Using the --reload flag is helpful for development, but for a 2GB machine, running it directly is safer for memory stability.


`bentoml serve service:IrisService`{{exec}}


# Test the API

In a new tab, run the following curl command to use the api

```bash
curl -X POST http://localhost:3000/predict   -H "Content-Type: application/json"   -d '{"input_series": [[5.1, 3.5, 1.4, 0.2]]}'
```{{exec}}

The expected result should be `[0]`

# Check the GUI interface

open http://127.0.0.1:3000  at the following link:
{{TRAFFIC_HOST1_3000}}

---

# XGboost verson

This is the quickstart we'll  be using: https://github.com/bentoml/BentoXGBoost


`apt install -y python3.12-venv`{{exec}}



`git clone https://github.com/bentoml/BentoXGBoost.git`{{exec}}

`cd BentoXGBoost`{{exec}}

`python3 -m venv .venv`{{exec}}

`source ./.venv/bin/activate`{{exec}}



`pip install bentoml xgboost scikit-learn`{{exec}}

## Train and save a model

`cat save_model.py`{{exec}}

`python3 save_model.py`{{exec}}

## Run the BentoML service

`bentoml serve`{{exec}}

In a new tab run

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
```{exec}

