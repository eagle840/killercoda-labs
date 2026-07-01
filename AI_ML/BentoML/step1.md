

# BentoML

## XGboost verson

This is the quickstart we'll  be using: 
[BentoML with XGBoost](https://github.com/bentoml/BentoXGBoost)


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
```{{exec}}

