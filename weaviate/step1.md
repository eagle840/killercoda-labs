In this lab we will setup Weaviate on docker compose and run some simple actions with python.


## Initial Setup

Install the prerequisites for this lab

`apt-get update`{{exec}}

`apt update`{{exec}}

`mkdir vector`{{exec}}

`cd vector/`{{exec}}

`sudo add-apt-repository -y ppa:deadsnakes/ppa`{{exec}}

`sudo apt-get update`{{exec}}

`apt-get install -y python3.10`{{exec}}

`sudo apt-get install build-essential -y`{{exec}}

`apt install -y python3.10-venv`{{exec}}

`python3.10 -m venv .venv`{{exec}}

`source .venv/bin/activate`{{exec}}

`pip install --upgrade pip`{{exec}}



## Install Weaviate on Docker

Since the example [template](https://weaviate.io/downloads/docker-templates/docker-compose-core.yml) requires a OpenAI account,  we'll use a local vectorizor [text2vec-contextionary](https://weaviate.io/developers/weaviate/modules/retriever-vectorizer-modules/text2vec-contextionary)

copy the following code into a dock compose template:

`nano docker-compose.yaml`{{exec}}

```
---
version: '3.4'
services:
  weaviate:
    command:
    - --host
    - 0.0.0.0
    - --port
    - '8080'
    - --scheme
    - http
    image: semitechnologies/weaviate:1.21.2
    ports:
    - 8080:8080
    restart: on-failure:0
    environment:
      CONTEXTIONARY_URL: contextionary:9999
      QUERY_DEFAULTS_LIMIT: 25
      AUTHENTICATION_ANONYMOUS_ACCESS_ENABLED: 'true'
      PERSISTENCE_DATA_PATH: '/var/lib/weaviate'
      ENABLE_MODULES: 'text2vec-contextionary'
      DEFAULT_VECTORIZER_MODULE: 'text2vec-contextionary'
      CLUSTER_HOSTNAME: 'node1'
  contextionary:
    environment:
      OCCURRENCE_WEIGHT_LINEAR_FACTOR: 0.75
      EXTENSIONS_STORAGE_MODE: weaviate
      EXTENSIONS_STORAGE_ORIGIN: http://weaviate:8080
      NEIGHBOR_OCCURRENCE_IGNORE_PERCENTILE: 5
      ENABLE_COMPOUND_SPLITTING: 'false'
    image: semitechnologies/contextionary:en0.16.0-v1.2.1
    ports:
    - 9999:9999
```{{copy}}

(ctrl-s,enter)(ctrl x) to save and exit.


`docker-compose up -d`{{exec}}

finally confirm the endpoint is up


{{TRAFFIC_HOST1_8080}}  
